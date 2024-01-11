return {
  "nvimtools/none-ls.nvim",
  event = "BufRead",
  config = function()
    local null_ls = require("null-ls")

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          only_local = "node_modules/.bin",
          extra_filetypes = { "svelte" },
          disabled_filetypes = { "ejs" },
        }),
        {
          name = "ejs_beautify",
          method = null_ls.methods.FORMATTING,
          filetypes = { "ejs" },
          generator = null_ls.formatter({
            command = "js-beautify",
            args = { "--type html", "-I true", "-f" },
            to_stdin = true,
            -- from_stderr = true,
          }),
        },

        null_ls.builtins.diagnostics.eslint.with({
          only_local = "node_modules/.bin",
        }),

        null_ls.builtins.completion.spell,
      },

      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })
  end,
}
