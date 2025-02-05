return {
        "mvllow/modes.nvim",
        tag    = 'v0.2.1',
        lazy   = false,
        config = function()
                require("modes").setup({
                        colors           = {
                                bg     = "NONE",
                                insert = "#89dceb",
                                visual = "#f5c359",
                                delete = "#c75c6a",
                                copy   = "#cba6f7",
                        },
                        line_opacity     = 0.20,
                        set_cursor       = true,
                        set_cursorline   = false,
                        set_number       = false,
                        ignore_filetypes = { "neo-tree", "TelescopePrompt", "Outline", "alpha" },
                })
        end,
}
