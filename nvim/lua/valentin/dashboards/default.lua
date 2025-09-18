-- ~/.config/nvim/lua/plugins/alpha_menu.lua
local alpha     = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local plugin_count = #require("lazy").plugins()

local header = {
    type = "text",
    val  = {
        [[        ]],
        [[  +___+ ]],
        [[  {O,o} ]],
        [[ /)___) ]],
        [[  "  "  ]],
        [[        ]],
        [[ Mornin']],
    },
    opts = { position = "center", hl = "Type" },
}

local buttons = {
    type = "group",
    opts = { spacing = 1, position = "center" },
    val = {
        dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("o", "  Open file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("q", "󰒲  Quit", ":qa<CR>"),
    },
}

local footer = {
    type = "text",
    val  = "Plugins: " .. plugin_count,
    opts = { position = "center", hl = "Type" },
}


-- ─── Assemble & activate ────────────────────────────────────────────────────────
alpha.setup({
    layout = {
        { type = "padding", val = 4 },
        header,
        { type = "padding", val = 3 },
        buttons,
        -- { type = "text", val = "Recent files", opts = { position = "center" } },
        { type = "padding", val = 1 },
        footer
    },
    opts = { margin = 5 },
})
