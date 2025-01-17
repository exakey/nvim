return {
    "aidancz/eolmark.nvim",
    lazy   = false,
    config = function()
        require("eolmark").setup({
            excluded_buftypes = {
                ".+",
            },
            opts = {
                virt_text = { { "󱞣", "NonText" } },
            },
        })
    end,
}
