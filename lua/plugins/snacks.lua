return {
        "folke/snacks.nvim",
        lazy     = false,
        priority = 1000,
        keys     = {
                { "<C-9>",      function() Snacks.notifier.show_history() end,   desc = "Notification History" },
                { "<A-b>",      function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
                { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
                { "<leader>lg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
                { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",      mode = { "n", "t" } },
                { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",      mode = { "n", "t" } },
                { -- MAIN
                        "<leader><leader><leader>",
                        function() Snacks.picker({ layout = "vscode" }) end,
                        desc = "Main Picker",
                        mode = { "n" },
                },
                { -- TODO  COMMENTS
                        "<leader><leader>t",
                        function() Snacks.picker.todo_comments({ layout = "select" }) end,
                        desc = "TODO comments",
                        mode = { "n" },
                },
                { -- FILES
                        "<leader><leader>f",
                        function() Snacks.picker.files({ layout = "vertical" }) end,
                        desc = "File Picker",
                        mode = { "n" },
                },
                { -- KEYMAPS
                        "<leader><leader>k",
                        function() Snacks.picker.keymaps({ layout = "select" }) end,
                        desc = "Keymap Picker",
                        mode = { "n" },
                },
                { -- GREP
                        "<leader><leader>g",
                        function() Snacks.picker.grep({ layout = "vertical" }) end,
                        desc = "Grep Picker",
                        mode = { "n" },
                },
                { -- GREP WORD
                        "<leader><leader>w",
                        function() Snacks.picker.grep_word({ layout = "default" }) end,
                        desc = "Grep Word",
                        mode = { "n" },
                },
                { -- REGISTERS
                        "<leader><leader>R",
                        function() Snacks.picker.registers({ layout = "vertical" }) end,
                        desc = "Register Picker",
                        mode = { "n" },
                },
                { -- HIGHLIGHTS
                        "<leader><leader>h",
                        function() Snacks.picker.highlights({ layout = "default" }) end,
                        desc = "Highlight Picker",
                        mode = { "n" },
                },
                { -- LAZY
                        "<leader><leader>l",
                        function() Snacks.picker.lazy({ layout = "dropdown" }) end,
                        desc = "Lazy Picker",
                        mode = { "n" },
                },
                { -- BUFFERS
                        "<leader><leader>b",
                        function()
                                Snacks.picker.buffers({
                                        on_show = function() vim.cmd.stopinsert() end,
                                        layout  = "default",
                                        format  = "buffer",
                                        hidden  = false,
                                        win     = {
                                                input = { keys = { ["Backspace"] = "bufdelete" } },
                                                list  = { keys = { ["Backspace"] = "bufdelete" } },
                                        },
                                })
                        end,
                        desc = "Buffer Picker",
                        mode = { "n" },
                },
        },

        opts     = {

                ------------------------------------------------------------------------
                -- STYLES

                styles   = {
                        float                = { backdrop = vim.g.backdrop },
                        input                = {
                                backdrop = true,
                                wo       = {
                                        cursorline   = false,
                                        winhighlight =
                                        "NormalFloat:SnacksInputNormal,DropBarMenuThumb:SnacksInputBorder,FloatTitle:SnacksInputTitle",
                                },
                        },
                        notification         = {
                                wo      = { winblend = 40 },
                                icons   = { error = " ■", warn = " ■", info = " ■", debug = " ■", trace = " ■" },
                                enabled = true,
                                timeout = 2000,
                                style   = "minimal",
                        },
                        notification_history = { width = 0.9, height = 0.9 }
                },

                lazygit  = { enabled = true },
                words    = { enabled = false },

                ----------------------------------------------------------------
                -- DIM

                dim      = {
                        {
                                scope = {
                                        min_size = 5,
                                        max_size = 20,
                                        siblings = true,
                                },
                        }
                },

                ----------------------------------------------------------------
                -- NOTIFIER

                notifier = {
                        icons   = { error = " ■", warn = " ■", info = " ■", debug = " ■", trace = " ■" },
                        style   = "minimal",
                        enabled = true,
                        timeout = 2000,
                },

                ----------------------------------------------------------------
                -- PICKERS

                picker   = {
                        win     = {
                                input = {
                                        keys = {
                                                ["<Esc>"] = { "close", mode = { "n", "i" } },
                                                ["J"]     = { "preview_scroll_down", mode = { "i", "n" } },
                                                ["K"]     = { "preview_scroll_up", mode = { "i", "n" } },
                                                ["H"]     = { "preview_scroll_left", mode = { "i", "n" } },
                                                ["L"]     = { "preview_scroll_right", mode = { "i", "n" } },
                                        },
                                },
                        },
                        layout  = { preset = "default" },
                        layouts = {
                                vscode   = {
                                        preview = false,
                                        layout  = {
                                                backdrop  = true,
                                                row       = 1,
                                                width     = 0.3,
                                                height    = 0.45,
                                                min_width = 60,
                                                border    = "none",
                                                box       = "vertical",
                                                { win = "input",   height = 1,          border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                                                { win = "list",    border = "bottom" },
                                                { win = "preview", title = "{preview}", border = "rounded" },
                                        },
                                },
                                select   = {
                                        preview = false,
                                        layout  = {
                                                backdrop   = true,
                                                width      = 0.5,
                                                min_width  = 80,
                                                height     = 0.4,
                                                min_height = 10,
                                                box        = "vertical",
                                                border     = "rounded",
                                                title      = "{title}",
                                                title_pos  = "center",
                                                { win = "input",   height = 1,          border = "bottom" },
                                                { win = "list",    border = "none" },
                                                { win = "preview", title = "{preview}", height = 0.4,     border = "top" },
                                        },
                                },
                                vertical = {
                                        layout = {
                                                backdrop   = true,
                                                width      = 0.9,
                                                height     = 0.9,
                                                min_width  = 80,
                                                min_height = 30,
                                                box        = "vertical",
                                                border     = "rounded",
                                                title      = "{title} {live} {flags}",
                                                title_pos  = "center",
                                                { win = "preview", title = "{preview}", height = 0.6,     border = "top" },
                                                { win = "input",   height = 1,          border = "bottom" },
                                                { win = "list",    border = "none" },
                                        },
                                },
                                default  = {
                                        layout = {
                                                box       = "horizontal",
                                                width     = 0.9,
                                                min_width = 120,
                                                height    = 0.9,
                                                {
                                                        box    = "vertical",
                                                        border = "rounded",
                                                        title  = "{title} {live} {flags}",
                                                        { win = "input", height = 1,     border = "bottom" },
                                                        { win = "list",  border = "none" },
                                                },
                                                { win = "preview", title = "{preview}", border = "rounded", width = 0.8 },
                                        },
                                },
                                dropdown = {
                                        layout = {
                                                backdrop  = true,
                                                row       = 1,
                                                width     = 0.5,
                                                height    = 0.9,
                                                min_width = 80,
                                                border    = "none",
                                                box       = "vertical",
                                                {
                                                        box       = "vertical",
                                                        border    = "rounded",
                                                        title     = "{title} {live} {flags}",
                                                        title_pos = "center",
                                                        { win = "input", height = 1,     border = "bottom" },
                                                        { win = "list",  border = "none" },
                                                        -- { win = "preview", title = "{preview}", height = 0.6,     border = "rounded" },
                                                },
                                        },
                                },
                                sidebar  = {
                                        preview = false,
                                        layout  = {
                                                backdrop  = true,
                                                width     = 20,
                                                min_width = 20,
                                                height    = 0,
                                                position  = "left",
                                                border    = "none",
                                                box       = "vertical",
                                                {
                                                        win       = "input",
                                                        height    = 1,
                                                        border    = "rounded",
                                                        title     = "{title} {live} {flags}",
                                                        title_pos = "center",
                                                },
                                                { win = "list",    border = "none" },
                                                { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                                        },
                                }
                        },
                },

                ----------------------------------------------------------------
                -- IMAGE

                image    = {
                        formats  = { "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif", "mp4", "mov", "avi", "mkv", "webm", "pdf" },
                        force    = false,
                        doc      = {
                                enabled = true,
                                inline = true,
                                float = true,
                                max_width = 80,
                                max_height = 40,

                                conceal = function(lang, type)
                                        return type == "math"
                                end,
                        },
                        img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
                        wo       = {
                                wrap           = false,
                                number         = false,
                                relativenumber = false,
                                cursorcolumn   = false,
                                signcolumn     = "no",
                                foldcolumn     = "0",
                                list           = false,
                                spell          = false,
                                statuscolumn   = "",
                        },
                        cache    = vim.fn.stdpath("cache") .. "/snacks/image",
                        debug    = {
                                request   = false,
                                convert   = false,
                                placement = false,
                        },
                        env      = {},
                        icons    = {
                                math  = "󰪚 ",
                                chart = "󰄧 ",
                                image = " ",
                        },
                        convert  = {
                                notify  = true,
                                mermaid = function()
                                        local theme = vim.o.background == "light" and "neutral" or "dark"
                                        return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme,
                                                "-s", "{scale}" }
                                end,
                                magick  = {
                                        default = { "{src}[0]", "-scale", "1920x1080>" },
                                        vector  = { "-density", 192, "{src}[0]" },
                                        math    = { "-density", 192, "{src}[0]", "-trim" },
                                        pdf     = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
                                },
                        },
                        math     = {
                                enabled = true,
                                typst = {
                                        tpl = [[
                                                        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
                                                        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
                                                        #set text(size: 12pt, fill: rgb("${color}"))
                                                        ${header}
                                                        ${content}
                                                ]],
                                },
                                latex = {
                                        font_size = "Large",
                                        packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
                                        tpl = [[
                                                        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
                                                        \usepackage{${packages}}
                                                        \begin{document}
                                                        ${header}
                                                        { \${font_size} \selectfont
                                                        \color[HTML]{${color}}
                                                        ${content}}
                                                        \end{document}
                                                ]],
                                },
                        },
                },

                ----------------------------------------------------------------
                -- DASHBOARD

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
        },

}
