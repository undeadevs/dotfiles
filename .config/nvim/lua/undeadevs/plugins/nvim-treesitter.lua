return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    { "tree-sitter/tree-sitter-embedded-template", ft = "embedded_template" },
  },
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.install").compilers = { "gcc" }
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "cpp",
        "go",
        "lua",
        "python",
        "rust",
        "tsx",
        "typescript",
        "javascript",
        "vimdoc",
        "vim",
        "java",
        "html",
        "embedded_template",
        "svelte",
      },

      auto_install = false,

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    })

    vim.cmd.autocmd("BufRead,BufNewFile *.ejs se filetype=ejs")
    local ejs_group = vim.api.nvim_create_augroup("EJSAuto", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { "*.ejs" },
      callback = function(args)
        vim.api.nvim_buf_create_user_command(args.buf, "EJSBeautify", function(_)
          vim.cmd(
            "!js-beautify --type html -I true -f "
              .. vim.api.nvim_buf_get_name(args.buf)
              .. " -o "
              .. vim.api.nvim_buf_get_name(args.buf)
          )
        end, { desc = "Format current EJS file" })
      end,
      group = ejs_group,
    })

    vim.treesitter.language.register("embedded_template", "ejs")
  end,
}
