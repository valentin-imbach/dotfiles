
---@diagnostic disable: undefined-global

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.mapleader = " "

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.goto_next, { desc = "Go to previous diagnostic" })
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

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = { "*.hpp", "*.cpp" },
    command = "silent! update"
})

vim.keymap.set("n", "<leader>ct", function()
    local cs = vim.api.nvim_buf_get_option(0, "commentstring")
    local comment_leader = cs:match("^(.-)%%s") or cs
    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1]
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, {comment_leader .. " TODO:  "})
    vim.api.nvim_win_set_cursor(0, {row, #comment_leader + 8})
    vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Add TODO Comment" })

require("valentin.lazy")

require("valentin.dashboards.default")
