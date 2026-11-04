import sys
import subprocess
from pathlib import Path

import os
import logging
import traceback

# Short translations use the status bar; longer ones open Zenity.
STATUS_TEXT_MAX_CHARS = 80


API_KEY_FILE = Path.home() / ".sioyek_translate_api_deepseek"

SYSTEM_PROMPT = """
你是一名专业的英中学术翻译官，擅长翻译计算机科学、数学、人工智能、机器人学及其他理工科领域的教材和学术论文。

你的任务是将用户从 PDF 文档中选中的英文内容准确、自然地翻译为简体中文。

## 翻译原则

1. **忠实原文**：准确保留原文的含义、逻辑关系、语气和技术细节，不得擅自添加、删减或改变信息。
2. **术语准确**：优先采用学术界通用的中文术语。对于重要专业术语，首次出现时可以保留英文，例如“马尔可夫决策过程（Markov Decision Process）”。
3. **表达自然**：使用符合中文学术教材习惯的表达方式，避免生硬的逐词翻译，同时不改变原文含义。
4. **保留格式**：保留原文中的数学公式、变量名、代码、函数名、符号、编号和引用，不翻译代码标识符。
5. **尊重上下文**：结合提供的上下文选择正确的词义。如果缺少上下文，优先采用最符合学术语境的解释，不要编造背景。
6. **不擅自纠错**：如果原文存在错误、歧义或不严谨之处，原则上忠实翻译，不擅自修改原文。

## 根据选中文本调整翻译方式

- **单个单词**：给出最符合学术语境的中文含义。如果有多个常见含义，可以简要列出，但不要展开长篇解释。
- **短语**：直接翻译，必要时保留核心英文术语。
- **完整句子**：翻译为准确、流畅的中文句子，保留原文逻辑。
- **段落**：保持原文的段落结构、论证顺序和逻辑关系，不进行总结或缩写。
- **数学定义、定理和证明**：严格保留量词、条件、否定、蕴含、充分性、必要性及推导关系，确保翻译后的数学含义与原文一致。
- **不完整的句子或跨行文本**：只翻译实际提供的内容，不自行补全缺失部分。

## 输出规则

1. 只输出中文翻译结果，不添加“翻译如下”等开场白。
2. 不重复英文原文，除非保留专业术语确有必要。
3. 不主动解释知识点、总结内容或回答原文中的问题。
4. 不使用无关的 Markdown 标题、列表或额外格式。
5. 对确实无法准确判断的歧义，可以在译文后用一句简短说明指出。
6. 如果用户明确要求解释某个术语或句子，则可以切换为解释模式。

你的首要目标是让用户在阅读英文 PDF 教材或论文时，快速获得准确、清晰、可靠的中文翻译，而不是额外的教学内容。
"""


def translate(text: str) -> str:
    from openai import OpenAI

    api_key = API_KEY_FILE.read_text(
        encoding="utf-8"
    ).strip()

    client = OpenAI(
        api_key=api_key,
        base_url="https://api.deepseek.com",
        timeout=30.0,
    )

    logging.info("stage=api_request text_length=%d", len(text))
    response = client.chat.completions.create(
        model="deepseek-flash",
        messages=[
            {
                "role": "system",
                "content": SYSTEM_PROMPT,
            },
            {
                "role": "user",
                "content": text,
            },
        ],
        temperature=0,
        extra_body={
            "thinking": {"type": "disabled"}
        },
    )

    result = response.choices[0].message.content or ""
    logging.info("stage=api_response result_length=%d", len(result))
    if not result.strip():
        raise ValueError("DeepSeek returned an empty translation")
    return result


def setup_logging():
    # Do not log API bodies, headers, exception messages, or selected text.
    path = "/tmp/sioyek-translate-debug.log"
    fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_APPEND | os.O_NOFOLLOW, 0o600)
    os.fchmod(fd, 0o600)
    logging.basicConfig(
        stream=os.fdopen(fd, "a", encoding="utf-8"),
        level=logging.INFO,
        format="%(asctime)s pid=%(process)d %(levelname)s %(message)s",
    )
    for name in ("openai", "httpx", "httpcore"):
        logging.getLogger(name).setLevel(logging.CRITICAL)
    safe_args = sys.argv[:2] + [f"<text length={len(a)}>" for a in sys.argv[2:]]
    logging.info("stage=start python=%r argc=%d argv=%r", sys.executable, len(sys.argv), safe_args)


def log_exception(stage, exc):
    # Frame locations preserve the stack without leaking response bodies or locals.
    frames = [(f.filename, f.lineno, f.name)
              for f in traceback.extract_tb(exc.__traceback__)]
    logging.error("stage=%s exception=%s traceback_frames=%r",
                  stage, type(exc).__name__, frames)


def show_status(sioyek_path, text):
    # The status bar is one line; keep all symbols, replacing only line breaks.
    text = text.replace("\r\n", " ").replace("\r", " ").replace("\n", " ")
    logging.info("stage=status_start executable=%r text_length=%d", sioyek_path, len(text))
    completed = subprocess.run(
        [sioyek_path, "--execute-command", "set_status_string",
         "--execute-command-data", text],
        capture_output=True, timeout=10, check=False,
    )
    logging.info("stage=status_return returncode=%d stdout_bytes=%d stderr_bytes=%d",
                 completed.returncode, len(completed.stdout), len(completed.stderr))
    completed.check_returncode()


def show_translation(text):
    # Plain text via stdin preserves paragraphs and symbols without shell parsing.
    logging.info("stage=zenity_start text_length=%d", len(text))
    completed = subprocess.run(
        ["/usr/bin/zenity", "--text-info", "--title=DeepSeek 翻译",
         "--width=800", "--height=600", "--ok-label=关闭"],
        input=text.encode("utf-8"), capture_output=True, check=False,
    )
    logging.info("stage=zenity_return returncode=%d stderr_bytes=%d",
                 completed.returncode, len(completed.stderr))
    # Closing or cancelling the dialog is normal, not a translation failure.
    if completed.returncode not in (0, 1):
        completed.check_returncode()


def main():
    setup_logging()
    sioyek_path = None
    stage = "arguments"
    try:
        if len(sys.argv) != 3:
            raise ValueError("Usage: translate.py SIOYEK_PATH TEXT | --test TEXT")
        selected_text = sys.argv[2]
        logging.info("stage=selection nonempty=%s text_length=%d",
                     bool(selected_text.strip()), len(selected_text))
        if sys.argv[1] == "--test":
            stage = "api"
            print(translate(selected_text))
            logging.info("stage=done mode=test")
            return 0

        sioyek_path = sys.argv[1]
        stage = "status"
        if not selected_text.strip():
            show_status(sioyek_path, "请先用鼠标选中英文文本")
            logging.info("stage=done reason=empty_selection")
            return 0
        show_status(sioyek_path, "正在翻译…")
        stage = "api"
        result = translate(selected_text)
        stage = "status"
        if len(result.strip()) <= STATUS_TEXT_MAX_CHARS:
            logging.info("stage=display target=status text_length=%d", len(result.strip()))
            show_status(sioyek_path, result.strip())
        else:
            logging.info("stage=display target=zenity text_length=%d", len(result.strip()))
            show_status(sioyek_path, "翻译完成，请查看翻译窗口")
            stage = "zenity"
            show_translation(result)
        logging.info("stage=done mode=sioyek")
        return 0
    except Exception as exc:
        log_exception(stage, exc)
        print(f"Translation failed: {type(exc).__name__}; see /tmp/sioyek-translate-debug.log",
              file=sys.stderr)
        if sioyek_path:
            try:
                show_status(sioyek_path, f"翻译失败：{type(exc).__name__}（查看调试日志）")
            except Exception as status_exc:
                log_exception("error_status", status_exc)
        return 1


if __name__ == "__main__":
    sys.exit(main())
