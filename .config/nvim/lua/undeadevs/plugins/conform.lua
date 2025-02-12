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
      javascript = { "prettier" },
      typescript = { "prettier" },
      haskell = { "hindent", lsp_format = "fallback" },
      php = { "pint", lsp_format = "fallback" },
      ejs = { "ejs_beautify", lsp_format = "fallback" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
