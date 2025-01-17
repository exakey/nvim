return {
        enabled = true,
        "folke/noice.nvim",
        event  = "VeryLazy",
        config = function()
                require("noice").setup({
                        notify    = {},
                        views     = {
                                cmdline_popup = {
                                        border         = {
                                                style   = "none",
                                                padding = { 1, 1 },
                                        },
                                        position       = {
                                                row = 6,
                                                col = "50%",
                                        },
                                        filter_options = {},
                                        win_options    = {
                                                -- winhighlight = {
                                                -- 	Normal = "Pmenu",
                                                -- 	FloatBorder = "Normal",
                                                -- },
                                        },
                                },
                        },
                        messages  = {
                                enabled = false,
                        },
                        cmdline   = {
                                format = {
                                        cmdline     = { pattern = "^:", icon = ">", lang = "vim" },
                                        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                                        search_up   = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                                        filter      = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                                        lua         = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                                        help        = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                                        input       = { view = "cmdline_input", icon = "󰥻 " },
                                },
                        },
                        popupmenu = {
                                enabled = "cmp",
                        },
                })
        end,
}
