vim.lsp.config.luals = {
        cmd          = { "lua-language-server", "--force-accept-workspace" },
        root_markers = { ".git", "git", "luarc,json", ".luarc.json", "luarc,jsonc", ".luarc.jsonc" },
        filetypes    = { "lua" },
        settings     = {
                Lua = {
                        completion  = {
                                callSnippet    = "Replace", -- functions -> no replace snippet
                                keywordSnippet = "Replace", -- keywords -> replace
                                showWord       = "Disable", -- already done by completion plugin
                                workspaceWord  = false,     -- already done by completion plugin
                                postfix        = ".",       -- useful for `table.insert` and the like
                        },
                        diagnostics = {
                                disable = {
                                        "trailing-space",
                                        "unused-function",
                                },
                        },
                        hint        = {
                                enable     = true,
                                setType    = true,
                                arrayIndex = "Disable",
                                semicolon  = "Disable",
                        },
                        format      = {
                                enable = true,
                        },
                        -- FIX https://github.com/sumneko/lua-language-server/issues/679#issuecomment-925524834
                        workspace   = {
                                checkThirdParty                      = "Disable",
                                [vim.fn.expand("$VIMRUNTIME/lua")]   = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                        semantic    = {
                                enable = true
                        },
                },
        }
}
