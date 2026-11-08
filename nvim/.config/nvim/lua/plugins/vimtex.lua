return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"

    vim.g.vimtex_compiler_latexmk = {
      executable = "latexmk",
      continuous = 1, -- 启动后，保存时自动重新编译
      aux_dir = ".build",
      out_dir = ".build",
      options = {
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-out2dir=.", -- 仅将 PDF 复制到项目根目录
        "-e",
        vim.fn.shellescape("@out2_exts = ('pdf');"),
      },
    }
  end,
}
