return {
  "neovim/nvim-lspconfig",
  event = "BufRead",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    { "folke/neodev.nvim", opts = {} },
  },

  config = function()
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
      nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    local servers = {
      rust_analyzer = {},
      tsserver = {},
      eslint = {},
      emmet_ls = {},
      html = {},
      svelte = {},
      tailwindcss = {},
      bufls = {},
      sqlls = {},
      yamlls = {},
      clangd = {},

      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        local server = servers[server_name]
        if server then
          require("lspconfig")[server_name].setup({
            capabilities = server.capabilities or capabilities,
            on_attach = server.on_attach or on_attach,
            settings = server.settings or {},
          })
        else
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {},
          })
        end
      end,
    })

    package.loaded["lsp-handlers"] = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}