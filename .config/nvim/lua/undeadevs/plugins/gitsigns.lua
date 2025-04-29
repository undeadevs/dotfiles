return {
  "lewis6991/gitsigns.nvim",
  event = "BufRead",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          gitsigns.nav_hunk('next')
        end
      end, { desc = "gitsigns: Next hunk" })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          gitsigns.nav_hunk('prev')
        end
      end, { desc = "gitsigns: Previous hunk" })

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "gitsigns: Stage hunk" })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "gitsigns: Reset hunk" })

      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = "gitsigns: Stage hunk" })

      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = "gitsigns: Reset hunk" })

      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "gitsigns: Stage buffer" })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "gitsigns: Reset buffer" })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "gitsigns: Preview hunk" })
      map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "gitsigns: Preview hunk inline" })

      map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
      end, { desc = "gitsigns: Preview blame" })

      map('n', '<leader>hd', gitsigns.diffthis, { desc = "gitsigns: Diff current changes" })

      map('n', '<leader>hD', function()
        gitsigns.diffthis('~')
      end, { desc = "gitsigns: Diff to previous commit" })

      map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = "gitsigns: Store repo changes location to quickfix list" })
      map('n', '<leader>hq', gitsigns.setqflist, { desc = "gitsigns: Store current buffer changes location to quickfix list" })

      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "gitsigns: Toggle current line blame" })
      map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "gitsigns: Toggle deleted" })
      map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = "gitsigns: Toggle word diff" })

      -- Text object
      map({'o', 'x'}, 'ih', gitsigns.select_hunk, { desc = "gitsigns: Select hunk" })
    end,
  },
}
