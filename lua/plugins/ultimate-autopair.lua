return {
        { -- auto-pair
                -- EXAMPLE config of the plugin: https://github.com/Bekaboo/nvim/blob/master/lua/configs/ultimate-autopair.lua
                "altermo/ultimate-autopair.nvim",
                lazy   = false,
                branch = "v0.6", -- recommended as each new version will have breaking changes
                event  = { "InsertEnter", "CmdlineEnter" },
                keys   = {
                        -- Open new scope (`remap` to trigger auto-pairing)
                        { "<A-o>", "a{<CR>", desc = " Open new scope", remap = true },
                        { "<A-o>", "{<CR>", mode = "i", desc = " Open new scope", remap = true },
                },
                opts   = {
                        bs                    = {
                                space = "balance",
                                cmap  = false, -- keep my `<BS>` mapping for the cmdline
                        },
                        fastwarp              = {
                                map          = "<D-f>",
                                rmap         = "<D-F>", -- backwards
                                hopout       = true,
                                nocursormove = true,
                                multiline    = false,
                        },
                        cr                    = { autoclose = true },
                        space                 = { enable = true },
                        space2                = { enable = true },

                        config_internal_pairs = {
                                { "'", "'", nft = { "markdown" } }, -- since used as apostroph
                                { '"', '"', nft = { "vim" } }, -- vimscript uses quotes as comments
                        },
                        -- INFO custom keys need to be "appended" to the opts as a list
                        { "*",    "*",    ft = { "markdown" } },       -- italics
                        { "__",   "__",   ft = { "markdown" } },       -- bold
                        { [[\"]], [[\"]], ft = { "zsh", "json", "applescript" } }, -- escaped quote

                        {                                              -- commit scope (= only first word) for commit messages
                                "(",
                                "): ",
                                ft   = { "gitcommit" },
                                cond = function(_) return not vim.api.nvim_get_current_line():find(" ") end,
                        },

                        -- for keymaps like `<C-a>`
                        { "<", ">", ft = { "vim" } },
                        {
                                "<",
                                ">",
                                ft   = { "lua" },
                                cond = function(fn)
                                        -- FIX https://github.com/altermo/ultimate-autopair.nvim/issues/88
                                        local inLuaLua = vim.endswith(vim.api.nvim_buf_get_name(0), "/ftplugin/lua.lua")
                                        return not inLuaLua and fn.in_string()
                                end,
                        },
                },
        },
}
