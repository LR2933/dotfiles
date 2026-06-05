return {
  "eraserhd/parinfer-rust",
  build = "cargo build --release", -- 利用 Rust 的超高性能，实时推导零延迟
  ft = { "scheme", "lisp", "clojure" }, -- 仅在编写 Lisp 类语言时启动
}
