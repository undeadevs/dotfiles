return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      ejs_beautify = {
        command = "js-beautify",
        args = { "--type", "html", "-I", "true", "--file", "-" },
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      haskell = { "hindent", lsp_format = "fallback" },
      php = { "pint", lsp_format = "fallback" },
      ejs = { "ejs_beautify", lsp_format = "fallback" },
    },
    -- format_on_save = {
    --   timeout_ms = 1000,
    --   lsp_format = "fallback",
    -- },
  },
}
