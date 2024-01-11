return {
  "tpope/vim-fugitive",
  config = function()
    vim.api.nvim_create_user_command("Gdot", function(opts)
      vim.cmd("split")
      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_create_buf(true, true)
      vim.api.nvim_win_set_buf(win, buf)
      vim.cmd("Ex ~/dotfiles")
      vim.cmd(string.format("Git %s", opts.args))
      vim.api.nvim_win_close(win, true)
    end, { nargs = "*", desc = "Git alias for dotfiles" })
  end,
}
