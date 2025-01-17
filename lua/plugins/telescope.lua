return {
    "nvim-telescope/telescope.nvim",
    event        = "VeryLazy",
    branch       = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },

    config       = function()
        require("functions.telescope-backdrop")
        local telescope = require("telescope")
        local actions   = require("telescope.actions")

        telescope.load_extension("fzf")

        telescope.setup({
            defaults = {
                borderchars           = { " ", " ", " ", " ", " ", " ", " ", " " },
                sorting_strategy      = "ascending",
                scroll_strategy       = "cycle",
                selection_caret       = "󰨓 ",
                dynamic_preview_title = true,
                path_display          = { "truncate" },
                default_mappings      = false,
                winblend              = 0,
                layout_strategy       = "vertical",
                preview               = {},

                layout_config         = {
                    vertical   = {
                        prompt_position = "top",
                        preview_height  = 0.50,
                        height          = 0.85,
                        width           = 0.65,
                    },
                    horizontal = {
                        prompt_position = "top",
                        preview_width   = 0.70,
                        height          = 0.90,
                        width           = 0.80,
                    },
                },

                mappings              = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-h>"] = actions.preview_scrolling_up,
                        ["<C-l>"] = actions.preview_scrolling_down,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["gg"]    = actions.move_to_top,
                        ["G"]     = actions.move_to_bottom,
                    },
                },
            },
        })
    end,
}
