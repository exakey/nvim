return {
    "glepnir/lspsaga.nvim",
    lazy         = false,
    enabled      = true,
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" },
    },
    config       = function()
        require("lspsaga").setup({
            ui               = {
                use_saga_diagnostic_sign = false,
                code_action              = "󱠀",
                error_sign               = "󰨓",
                warn_sign                = "󰨓",
                hint_sign                = "󰨓",
                infor_sign               = "󰨓",
                dianostic_header_icon    = " ж  ",
                code_action_icon         = "󱠀 ",
            },
            symbol_in_winbar = {
                enable = false,
            },
        })
    end,
}
