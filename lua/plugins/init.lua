return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "pyright",
                "lua-language-server",
                "html-lsp",
                "css-lsp",
                "stylua",
                "prettier",
            },
        },
    },

    {
        "stevearc/dressing.nvim",
        lazy = false,
        opts = {},
    },

    {
        "stevearc/aerial.nvim",
        event = "VeryLazy",
        config = function()
            require "configs.aerial"
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },

    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit" },
    },
    {
        "f-person/auto-dark-mode.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            -- Query macOS appearance BEFORE plugin loads to prevent flash
            local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
            if handle then
                local result = handle:read("*a")
                handle:close()
                if result:match("Dark") then
                    vim.o.background = "dark"
                else
                    vim.o.background = "light"
                end
            end
        end,
        opts = require "configs.auto_dark_mode",
    },
}
