
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
    update_in_insert = true,
    severity_sort = true
})

-- autosave
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = { "*.hpp", "*.cpp" },
    command = "silent! update"
})

-- Quick TODO
vim.keymap.set("n", "<leader>ct", function()
    local cs = vim.api.nvim_buf_get_option(0, "commentstring")
    local comment_leader = cs:match("^(.-)%%s") or cs
    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1]
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, {comment_leader .. " TODO:  "})
    vim.api.nvim_win_set_cursor(0, {row, #comment_leader + 8})
    vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Add TODO Comment" })

-- Toogle Quickfix
vim.keymap.set('n', '<leader>q', function()
    local qf_open = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
            qf_open = true
            vim.api.nvim_win_close(win, true)
            break
        end
    end
    if not qf_open then
        vim.cmd('botright copen')
        vim.cmd('wincmd p')
    end
end, { noremap = true, silent = true })

-- Highlight Text after Yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({higroup="IncSearch", timeout=1000})
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = "en_gb"
    end
})

-- vim.api.nvim_create_user_command("SpellCheckDirectory", function()
--     local cwd = vim.fn.getcwd()
--     vim.cmd("args " .. cwd .. "/**/*.tex")  -- only .tex files
--
--     local qf = {}
--
--     for _, buf in ipairs(vim.fn.getbufinfo({bufloaded = 1})) do
--         local name = buf.name
--         if name ~= "" and vim.fn.filereadable(name) == 1 then
--             vim.fn.bufload(buf.bufnr)
--             vim.cmd("buffer " .. buf.bufnr)
--
--             -- set LaTeX filetype and spell
--             vim.bo.filetype = "tex"
--             vim.opt_local.spell = true
--
--             -- start at beginning
--             vim.api.nvim_win_set_cursor(0, {1, 0})
--
--             while true do
--                 local bad = vim.fn.spellbadword()
--                 local word = bad[1]
--                 if word == "" then break end
--
--                 table.insert(qf, {
--                     filename = name,
--                     lnum = vim.fn.line("."),
--                     col = vim.fn.col("."),
--                     text = "Misspelling: " .. word,
--                 })
--
--                 -- move cursor forward
--                 vim.cmd("normal! " .. #word .. "l")
--             end
--         end
--     end
--
--     vim.fn.setqflist(qf, "r")
--     vim.cmd("copen")
--     print("Use :cnext + z= to interactively fix LaTeX misspellings.")
-- end, {})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.textwidth = 65
        vim.opt_local.colorcolumn = "66"
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "GoyoEnter",
    callback = function()
        vim.wo.wrap = true
        vim.wo.linebreak = true
        vim.wo.breakindent = true
        vim.cmd("Limelight")
        vim.opt.fillchars:append({ eob = " " })
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "GoyoLeave",
    command = "Limelight!",
})

require("valentin.keymaps")
require("valentin.lazy")
require("valentin.dashboards.default")


