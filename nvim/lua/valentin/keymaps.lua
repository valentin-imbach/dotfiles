
---@diagnostic disable: undefined-global

vim.keymap.set("n", "<leader>d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>D", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.o.updatetime = 1000
vim.cmd("autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })")

vim.keymap.set("n", "<leader>i", "mZgg=G`Zzz", { desc = "Indent File" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })

vim.keymap.set("n", "x", '"_x', { desc = "Delete character without yanking" })
vim.keymap.set("n", "X", '"_X', { desc = "Delete character without yanking" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Search & replace word" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight", silent = true })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center search result" })

vim.keymap.set("n", "G", "Gzz", { desc = "Center buffer bottom" })

vim.keymap.set({ "n", "v" }, "<leader>z", "<cmd>Goyo<CR>", { desc = "Zen Mode" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<Up>", "gk", { desc = "Move up visual line" })
vim.keymap.set({ "n", "v" }, "<Down>", "gj", { desc = "Move up visual line" })
vim.keymap.set({ "i" }, "<Up>", "<C-o>gk", { desc = "Move up visual line" })
vim.keymap.set({ "i" }, "<Down>", "<C-o>gj", { desc = "Move up visual line" })
