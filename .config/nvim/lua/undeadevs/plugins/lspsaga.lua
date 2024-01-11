return {
  "nvimdev/lspsaga.nvim",
  event = "BufRead",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lspsaga").setup({})
  end,
}
