return {
        "lukas-reineke/indent-blankline.nvim",
        lazy    = false,
        main    = "ibl",
        config  = function()
                require("ibl").setup({
                        indent     = {
                                tab_char = "󰨕",
                                char     = "󰨕",
                        },
                        whitespace = {
                                remove_blankline_trail = true,
                        },
                        scope      = {
                                show_start = true,
                                show_end   = true,
                                char       = "󰨕",
                        },
                })
        end,
}
