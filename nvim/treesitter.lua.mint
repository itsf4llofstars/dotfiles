-- [[ Treesitter ]]

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "c", "lua", "vim", "vimdoc", "query", "python", "vimdoc", "arduino",
      "bash", "markdown", "markdown_inline", "rust", "typescript"
  },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
