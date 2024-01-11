return {
  "undeadevs/clarity-dark.vim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("clarity-dark")
    vim.cmd.highlight("Normal", "guibg=none")
    vim.cmd.highlight("NonText", "guibg=none")
    vim.cmd.highlight("Normal", "ctermbg=none")
    vim.cmd.highlight("NonText", "ctermbg=none")
  end,
}
