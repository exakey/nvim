return {
        "folke/snacks.nvim",
        priority = 1000,
        lazy     = false,
        opts     = {
                styles    = {
                        float = {
                                backdrop = 40
                        }
                },
                words     = { enabled = false },
                lazygit   = { enabled = true },
                notifier  = {
                        timeout = 2000,
                        icons   = {
                                error = " ■",
                                warn  = " ■",
                                info  = " ■",
                                debug = " ■",
                                trace = " ■",
                        },
                        style   = "minimal",
                        styles  = {
                                wo = {
                                        winblend = 60,
                                },
                        },
                },
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
                                        action  = ":Telescope find_files",
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
                                        key     = "g",
                                        action  = "<cmd> Telescope live_grep <CR>",
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
                                        action  = [[<cmd>Telescope find_files cwd=$HOME/.config/nvim<cr>]],
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
                                -- {
                                --     pane    = 2,
                                --     section = "recent_files",
                                --     limit   = 20,
                                --     padding = 2,
                                --     align   = "center"
                                -- },
                        },
                },
        },
        keys     = {
                -- { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
                { "<C-9>",      function() Snacks.notifier.show_history() end,   desc = "Notification History" },
                -- { "<A-9>",      function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
                { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
                -- { "<leader>pp", function() Snacks.toggle.profiler() end,            desc = "Toggle profiler" },
                -- { "<leader>ph", function() Snacks.toggle.profiler_highlights() end, desc = "Toggle profiler highlights" },
                -- { "<leader>ps", function() Snacks.profiler.scratch() end,           desc = "Profiler Scratch Bufer" },
                { "<A-b>",      function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
                { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
                { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
                { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
                { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
                { "<leader>lg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
                { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
                { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
                { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
        },
}
