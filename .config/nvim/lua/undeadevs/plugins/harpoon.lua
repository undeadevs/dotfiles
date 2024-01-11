return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = { "<leader>.", "<leader>n", "<leader>N", "<leader>oh", "<leader>o1", "<leader>o2", "<leader>o3", "<leader>o4" },
  config = function()
    require("harpoon").setup()

    vim.keymap.set("n", "<leader>.", function()
      require("harpoon.mark").add_file()
    end, { desc = "[<leader>.] Add file to harpoon" })

    vim.keymap.set("n", "<leader>n", function()
      require("harpoon.ui").nav_next()
    end, { desc = "[<leader>n] Jump to next file in harpoon list" })

    vim.keymap.set("n", "<leader>N", function()
      require("harpoon.ui").nav_prev()
    end, { desc = "[<leader>N] Jump to prev file in harpoon list" })

    vim.keymap.set("n", "<leader>oh", function()
      require("harpoon.ui").toggle_quick_menu()
    end, { desc = "[O]pen [H]arpoon menu" })

    vim.keymap.set("n", "<leader>o1", function()
      require("harpoon.ui").nav_file(1)
    end, { desc = "[<leader>q1] Jump to 1st file in harpoon list" })

    vim.keymap.set("n", "<leader>o2", function()
      require("harpoon.ui").nav_file(2)
    end, { desc = "[<leader>q2] Jump to 2nd file in harpoon list" })

    vim.keymap.set("n", "<leader>o3", function()
      require("harpoon.ui").nav_file(3)
    end, { desc = "[<leader>q3] Jump to 3rd file in harpoon list" })

    vim.keymap.set("n", "<leader>o4", function()
      require("harpoon.ui").nav_file(4)
    end, { desc = "[<leader>q4] Jump to 4th file in harpoon list" })
  end,
}
