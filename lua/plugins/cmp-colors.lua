return {
    "xzbdmw/colorful-menu.nvim",
    config = function()
        require("colorful-menu").setup({
            ft = {
                lua        = {
                    auguments_hl = "@comment",
                },
                typescript = {
                    ls = "typescript-language-server",
                },
                rust       = {
                    extra_info_hl = "@comment",
                },
                c          = {
                    extra_info_hl = "@comment",
                }
            },
            fallback_highlight = "@comment",
            max_width = 60,
        })
    end,
}
