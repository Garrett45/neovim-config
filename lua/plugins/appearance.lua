-- This config contains various mini libraries that just make neovim look nicer
return {
    -- Adding in our colorscheme, got to do it first before everything else
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
        opts = {
            auto_integrations = true,
        },
    },

    -- Shows indentscope to make indent easier to see
    {
        'nvim-mini/mini.indentscope',
        version = false,
        opts = {},
    },

    -- Adds in mini picker for selection/files/the rest
    {
        'nvim-mini/mini.pick',
        version = false,
        opts = {},
    },

    -- Shows nicer status line with very little configuration
    {
        'nvim-mini/mini.statusline',
        version = false,
        dependencies = {
            -- This dependency is declared elsewhere, but this also technically needs icons
            {
                'nvim-mini/mini.icons',
                version = false,
                opts = {},
            },

            -- Adds git support, requires special setup because name is a bit different
            {
                'nvim-mini/mini-git',
                version = false,
                config = function()
                    require('mini.git').setup()
                end,
            },

            -- Also part of adding git support to status line
            {
                'nvim-mini/mini.diff',
                version = false,
                opts = {},
            },
        },
        opts = {},
    },
}
