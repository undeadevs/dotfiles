-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>oe", function()
  vim.cmd("Ex")
end, { desc = "[O]pen [E]xplorer (Netrw)" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true })

vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true })

vim.keymap.set("n", "mh", "<C-w>h", { silent = true, desc = "[mh] Move to left pane" })
vim.keymap.set("n", "mj", "<C-w>j", { silent = true, desc = "[mj] Move to above pane" })
vim.keymap.set("n", "mk", "<C-w>k", { silent = true, desc = "[mk] Move to below pane" })
vim.keymap.set("n", "ml", "<C-w>l", { silent = true, desc = "[ml] Move to right pane" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, desc = "[<C-d>] Jump half page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, desc = "[<C-u>] Jump half page up and center" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Replace-paste without yanking" })

vim.keymap.set("i", '"', '""<left>', { silent = true, noremap = true, desc = "Complete double quotes" })
vim.keymap.set("i", "'", "''<left>", { silent = true, noremap = true, desc = "Complete single quotes" })
vim.keymap.set("i", "`", "``<left>", { silent = true, noremap = true, desc = "Complete backticks" })
vim.keymap.set("i", "(", "()<left>", { silent = true, desc = "Complete parentheses" })
vim.keymap.set("i", "[", "[]<left>", { silent = true, desc = "Complete brackets" })
vim.keymap.set("i", "{", "{}<left>", { silent = true, desc = "Complete curlies" })
vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O", { silent = true, desc = "Complete curlies newline" })
vim.keymap.set(
  "i",
  '\\"',
  '\\"',
  { silent = true, noremap = true, desc = "Avoid completion when escaping double quotes" }
)
vim.keymap.set(
  "i",
  "\\'",
  "\\'",
  { silent = true, noremap = true, desc = "Avoid competion when escaping single quotes" }
)
vim.keymap.set("i", "\\`", "`", { silent = true, noremap = true, desc = "Avoid competion when escaping backticks" })
vim.keymap.set(
  "i",
  "\\(",
  "\\(",
  { silent = true, noremap = true, desc = "Avoid completion when escaping parentheses" }
)
vim.keymap.set("i", "\\[", "\\[", { silent = true, noremap = true, desc = "Avoid completion when escaping brackets" })
vim.keymap.set("i", "\\{", "\\{", { silent = true, noremap = true, desc = "Avoid completion when escaping curlies" })
