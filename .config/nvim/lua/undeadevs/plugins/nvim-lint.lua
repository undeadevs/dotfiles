return {
  "mfussenegger/nvim-lint",
  opts = {},
  config = function()
    require("lint").linters_by_ft = {
      -- javascript = { "biomejs" },
      -- typescript = { "biomejs" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
