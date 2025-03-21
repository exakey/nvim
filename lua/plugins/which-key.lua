return {
        "folke/which-key.nvim",
        enabled = false,
        event   = "VeryLazy",
        keys    = {
                {
                        "<leader>?",
                        function() require("which-key").show({ global = false }) end,
                        desc = "Buffer Local Keymaps (which-key)",
                },
                {
                        -- "<leader>t",
                        function()
                                require("which-key").show({
                                        global = false,
                                        loop   = true,
                                        spec   = {
                                                mode = { "n", "x" },
                                                { "" },
                                                { "" },
                                                { "" },
                                                { "" },
                                                { "" },
                                                { "" },
                                                { "" },
                                                { "" },
                                                { "" },
                                                { "" },
                                        }
                                })
                        end,
                        desc = "TREEMODE",
                },
        },
        opts    = {
                delay   = 666,
                preset  = "helix",
                win     = {
                        -- border     = vim.g.borderStyle,
                        height     = { min = 1, max = 0.99 },
                        no_overlap = false,
                },
                spec    = {
                        { -- leader subgroups
                                mode = { "n", "x" },
                                { "<leader>", group = "󰓎 Leader" },
                                { "<leader>c", group = " Code action" },
                                { "<leader>e", group = "󰓗 Execute" },
                                { "<leader>r", group = "󱗘 Refactor" },
                                { "<leader>g", group = "󰊢 Git" },
                                { "<leader>i", group = "󱈄 Inspect" },
                                { "<leader>o", group = "󰒓 Option toggle" },
                                { "<leader>p", group = "󰏗 Packages" },
                                { "<leader>q", group = " Quickfix" },
                                { "<leader>u", group = "󰕌 Undo" },
                        },
                        { -- not using `text_objects` preset, since it's too crowded
                                mode = { "o", "x" },
                                { "r", group = "rest of" },
                                { "i", group = "inner" },
                                { "a", group = "outer" },
                                { "g", group = "misc" },
                                { "ip", desc = "¶ paragraph" },
                                { "ap", desc = "¶ paragraph" },
                                { "ib", desc = "󰅲 bracket" },
                                { "ab", desc = "󰅲 bracket" },
                                { "it", desc = " tag" },
                                { "at", desc = " tag" },
                                { "is", desc = "󰰢 sentence" },
                                { "as", desc = "󰰢 sentence" },
                                { "iw", desc = "󰬞 word" },
                                { "aw", desc = "󰬞 word" },
                                { "gn", desc = " search result" },
                        },
                        { -- base groups
                                mode = { "n", "x" },
                                { "g", group = "Goto" },
                                { "z", group = "Fold & spelling" },
                        },
                },
                plugins = {
                        marks     = false,
                        registers = false,
                        spelling  = { enabled = false },
                        presets   = {
                                motions      = false,
                                g            = false,
                                text_objects = true,
                                z            = false,
                                nav          = false,
                                operator     = false,
                        },
                },
                filter  = function(map)
                        -- need to remove comment mapping shere, since they are nvim-builtins
                        -- that do still show up with disabled whichkey-preset
                        local nvimBultins = { "gc", "gcc", "]d", "zf", "g~", "gu", "gU", "<C-W><C-D>", "<C-W>d" }
                        if vim.tbl_contains(nvimBultins, map.lhs) then return false end

                        return map.desc ~= nil
                end,
                replace = {
                        desc = { -- redundant info for when displayed in which-key
                                { " outer ",   " " },
                                { " inner ",   " " },
                                { " rest of ", " " },
                        },
                },
                icons   = {
                        group     = "",    -- different color for groups already distinguishable enough
                        separator = "│",
                        mappings  = false, -- disable icons for keymaps.
                        -- NOTE unfortuenately, we cannot get icons from the keymap
                        -- descriptions, so we just use the icons from there and disable
                        -- whickey's icon features
                },
        },
}
