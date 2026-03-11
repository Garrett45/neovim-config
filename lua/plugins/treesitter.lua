return {
    -- Adds in abstraction stuff on top of treesitter support in neovim. Basicallty makes it easier to work with
    -- If you need support for new file types, you'll want to make changes here and to lsp.lua
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            -- Intalls wanted treesitter languages
            require('nvim-treesitter').install({
                'c',
                'lua',
                'vim',
                'vimdoc',
                'query',
                'rust',
                'c_sharp',
                'javascript',
                'typescript',
                'jsx',
                'tsx',
                'sql',
            })

            -- Actually enables highlighting and the like on different file types
            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    'c',
                    'lua',
                    'vim',
                    'rs',
                    'cs',
                    'js',
                    'ts',
                    'jsx',
                    'tsx',
                    'sql',
                },
                callback = function()
                    vim.treesitter.start()
                    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.wo[0][0].foldmethod = 'expr'
                    -- experimental, could be used if wanted though to handle indenting with treesitter
                    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
