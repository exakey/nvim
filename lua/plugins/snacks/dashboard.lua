return {
        "snacks.nvim",
        opts = {

                dashboard = {
                        formats  = {
                                key = function(item)
                                        return {
                                                { "[",      hl = "DropBarKindNumber" },
                                                { item.key, hl = "DropBarKindCall" },
                                                { "]",      hl = "DropBarKindNumber" }
                                        }
                                end,
                        },
                        sections = {
                                {
                                        text    = {
                                                {
                                                        [[
  ▄████▄       ░░░░░    ░░░░░    ░░░░░    ░░░░░
 ███▄█▀       ░ ▄░ ▄░  ░ ▄░ ▄░  ░ ▄░ ▄░  ░ ▄░ ▄░
█████  █  █   ░░░░░░░  ░░░░░░░  ░░░░░░░  ░░░░░░░
 █████▄       ░░░░░░░  ░░░░░░░  ░░░░░░░  ░░░░░░░
   ████▀      ░ ░ ░ ░  ░ ░ ░ ░  ░ ░ ░ ░  ░ ░ ░ ░
              ]],
                                                },
                                                hl = "DropBarIconUISeparator"
                                                --             [[
                                                --   ▄████▄       █████    █████    █████    █████
                                                --  ███▄█▀       █ ▄█ ▄█  █ ▄█ ▄█  █ ▄█ ▄█  █ ▄█ ▄█
                                                -- █████  █  █   ███████  ███████  ███████  ███████
                                                --  █████▄       ███████  ███████  ███████  ███████
                                                --    ████▀      █ █ █ █  █ █ █ █  █ █ █ █  █ █ █ █
                                                --           ]],
                                                -- hl = "SignatureHelpBorder"
                                        },
                                        align   = "center",
                                        padding = 2
                                },
                                {
                                        text    = {
                                                { "󰻭  ", hl = "DropBarKindNumber" },
                                                { "New file", hl = "DropBarKindCall", width = 45 },
                                                { "[", hl = "DropBarKindNumber" },
                                                { "n", hl = "DropBarKindCall" },
                                                { "]", hl = "DropBarKindNumber" }
                                        },
                                        key     = "n",
                                        action  = "<cmd> enew <BAR> startinsert <CR>",
                                        padding = 1,
                                        align   = "center"
                                },
                                {
                                        text    = {
                                                { "󰕁  ", hl = "DropBarKindNumber" },
                                                { "Recent files", hl = "DropBarKindCall", width = 45 },
                                                { "[", hl = "DropBarKindNumber" },
                                                { "r", hl = "DropBarKindCall" },
                                                { "]", hl = "DropBarKindNumber" }
                                        },
                                        key     = "r",
                                        action  = "<cmd> Telescope oldfiles <CR>",
                                        padding = 1,
                                        align   = "center"
                                },
                                {
                                        text    = {
                                                { "󰱽  ", hl = "DropBarKindNumber" },
                                                { "Find File", hl = "DropBarKindCall", width = 45 },
                                                { "[", hl = "DropBarKindNumber" },
                                                { "f", hl = "DropBarKindCall" },
                                                { "]", hl = "DropBarKindNumber" }
                                        },
                                        action  = function() Snacks.picker.files({ layout = "vertical" }) end,
                                        key     = "f",
                                        padding = 1,
                                        align   = "center"
                                },
                                {
                                        text    = {
                                                { "󰦪  ", hl = "DropBarKindNumber" },
                                                { "Find text", hl = "DropBarKindCall", width = 45 },
                                                { "[", hl = "DropBarKindNumber" },
                                                { "g", hl = "DropBarKindCall" },
                                                { "]", hl = "DropBarKindNumber" }
                                        },
                                        action  = function() Snacks.picker.grep({ layout = "vertical" }) end,
                                        key     = "g",
                                        padding = 1,
                                        align   = "center"
                                },
                                {
                                        text    = {
                                                { "󰦛  ", hl = "DropBarKindNumber" },
                                                { "Restore session", hl = "DropBarKindCall", width = 45 },
                                                { "[", hl = "DropBarKindNumber" },
                                                { "s", hl = "DropBarKindCall" },
                                                { "]", hl = "DropBarKindNumber" }
                                        },
                                        key     = "s",
                                        action  = [[<cmd> lua require("persistence").load({ last = false }) <cr>]],
                                        padding = 1,
                                        align   = "center"
                                },
                                {
                                        text    = {
                                                { "󱤸  ", hl = "DropBarKindNumber" },
                                                { "Config", hl = "DropBarKindCall", width = 45 },
                                                { "[", hl = "DropBarKindNumber" },
                                                { "c", hl = "DropBarKindCall" },
                                                { "]", hl = "DropBarKindNumber" }
                                        },
                                        key     = "c",
                                        action  = function() Snacks.picker.files() end,
                                        padding = 1,
                                        align   = "center"
                                },
                                {
                                        text    = {
                                                { "󰏗  ", hl = "DropBarKindNumber" },
                                                { "Lazy", hl = "DropBarKindCall", width = 45 },
                                                { "[", hl = "DropBarKindNumber" },
                                                { "l", hl = "DropBarKindCall" },
                                                { "]", hl = "DropBarKindNumber" }
                                        },
                                        key     = "l",
                                        action  = "<cmd> Lazy <CR>",
                                        padding = 1,
                                        align   = "center"
                                },
                                {
                                        text    = {
                                                { "󱧕  ", hl = "DropBarKindNumber" },
                                                { "Update plugins", hl = "DropBarKindCall", width = 45 },
                                                { "[", hl = "DropBarKindNumber" },
                                                { "u", hl = "DropBarKindCall" },
                                                { "]", hl = "DropBarKindNumber" }
                                        },
                                        key     = "u",
                                        action  = "<cmd> Lazy update <CR>",
                                        padding = 1,
                                        align   = "center"
                                },
                                {
                                        text    = {
                                                { "󰈆  ", hl = "DropBarKindNumber" },
                                                { "Quit", hl = "DropBarKindCall", width = 45 },
                                                { "[", hl = "DropBarKindNumber" },
                                                { "q", hl = "DropBarKindCall" },
                                                { "]", hl = "DropBarKindNumber" }
                                        },
                                        key     = "q",
                                        action  = "<cmd> qa <CR>",
                                        padding = 2,
                                        align   = "center"
                                },
                                {
                                        pane    = 1,
                                        section = "startup",
                                },
                        },
                },
        }
}
