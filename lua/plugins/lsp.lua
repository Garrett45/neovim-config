return {
    -- Actually triggers use of the LSP
    -- This is basically a helper plugin from neovim themselves that gives a bunch of sensible default
    -- configurations for LSPs, so you don't have to write the verbose default syntax instead. If you
    -- want to enable more LSPs, you just add another vim.lsp.enable line in the config setting below
    -- Great video that explains it and inspired config: https://www.youtube.com/watch?v=HL7b63Hrc8U
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config('lua_ls', {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most
                            -- likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                            -- Tell the language server how to find Lua modules same way as Neovim
                            -- (see `:h lua-module-load`)
                            path = {
                                'lua/?.lua',
                                'lua/?/init.lua',
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                -- Depending on the usage, you might want to add additional paths
                                -- here.
                                -- '${3rd}/luv/library',
                                -- '${3rd}/busted/library',
                            },
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            })

            -- enable all LSPs you want in config
            vim.lsp.enable({
                'ccls',
                'lua_ls',
                'vimls',
                'rust_analyzer',
                'csharp_ls',
                'eslint',
                'sqls'
            })
        end,
    },
}
