vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd.highlight("Normal", "guibg=none")
vim.cmd.highlight("NonText", "guibg=none")
vim.cmd.highlight("Normal", "ctermbg=none")
vim.cmd.highlight("NonText", "ctermbg=none")

require("undeadevs.opts")
require("undeadevs.keymaps")
require("undeadevs.lazy")

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
