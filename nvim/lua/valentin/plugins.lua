return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin") 
        end,
        opts = { flavour = "mocha", }
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim", },
        keys = {
            { "<leader>tf", "<CMD>Telescope find_files<CR>", desc = "Telescope find files" },
            { "<leader>tw", "<CMD>Telescope live_grep<CR>", desc = "Telescope live grep" },
            { "<leader>tr", "<CMD>Telescope oldfiles<CR>", desc = "Telescope old files" },
            { "<leader>tb", "<CMD>Telescope file_browser<CR>", desc = "Telescope browse files" },
        },
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {"lua", "cpp", "latex"},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true }
        },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            { "williamboman/mason-lspconfig.nvim", opts = {
                ensure_installed = { "clangd", "lua_ls" },
                setup_handlers = function(server_name)
                    require("lspconfig")[server_name].setup({})
                end
            } },
        }
    },

    {
        "p00f/clangd_extensions.nvim",
        config = function()
            require("clangd_extensions").setup({
                memory_usage = { border = "single" },
                symbol_info = { border = "single" },
            })
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = 'vimtex' },
                },
            }
        end,
        enabled = function()
            -- Disable cmp if Copilot is showing a suggestion
            local copilot_visible = require("copilot.suggestion").is_visible()
            return not copilot_visible
        end,
    },

    {
        "goolord/alpha-nvim",
        dependencies = { "echasnovski/mini.icons" },
    },

    {
        'sudormrfbin/cheatsheet.nvim',
        dependencies = {
            {'nvim-telescope/telescope.nvim'},
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
        },
        opts = {
            bundled_cheatsheets = {
                enabled = { "default" },
            },
        },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    {
        "lervag/vimtex",
        lazy = false,
        ft = 'tex',  -- Optional: only load for TeX files
        init = function()
            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_view_method = 'skim'
            vim.g.vimtex_skim_sync = 1
            vim.g.vimtex_view_skim_activate = 1
            vim.g.vimtex_format_enabled = 1
        end,
    },

    {
        "micangl/cmp-vimtex",
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            enable = true,
            auto_trigger = true,
            keymap = {
                accept = "<C-a>",
            }
        },
        init = function()
            vim.keymap.set("n", "<leader>ct", function()
                require("copilot.suggestion").toggle_auto_trigger()
            end, { desc = "Toggle Copilot Auto-Trigger"})

            vim.keymap.set("i", "<S-Tab>", function()
                require("copilot.suggestion").accept()
            end, { desc = "Accept Copilot Suggestion" })

            -- cycle thrhoug suggestions with C-n and C-p
            vim.keymap.set("i", "<C-Right>", function()
                require("copilot.suggestion").next()
            end, { desc = "Next Copilot Suggestion" })

            vim.keymap.set("i", "<C-Left>", function()
                require("copilot.suggestion").prev()
            end, { desc = "Previous Copilot Suggestion" })

        end,
    },

    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        -- @module 'render-markdown'
        -- @type render.md.UserConfig
        opts = {},
    },

    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            processor = "magick_cli",
        }
    },

    {
        'ThePrimeagen/vim-be-good'
    },

    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    {
        "grddavies/tidal.nvim",
        opts = {},
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            opts = { ensure_installed = { "haskell", "supercollider" } },
        },
    },

    {
        "hat0uma/csvview.nvim",
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
            view = {
                display_mode = "border",
                header_lnum = 1,
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    },

    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

        dependencies = {
            'nvim-lua/plenary.nvim',

            -- optional dependencies:

            -- a completion engine
            --    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices

            -- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
            -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
            -- 'andrewradev/switch.vim',        -- for switch support
            -- 'tomtom/tcomment_vim',           -- for commenting
        },

        ---@type lean.Config
        opts = { -- see below for full configuration options
            mappings = true,
        }
    }



    -- {
        --     "akinsho/toggleterm.nvim",
        --     version = "*",
        --     opts = {},
        -- },

}

