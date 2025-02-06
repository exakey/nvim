return {
    "anuvyklack/windows.nvim",
    lazy         = false,
    dependencies = {
        "anuvyklack/middleclass",
        -- "anuvyklack/animation.nvim",
    },
    config       = function()
        vim.o.winwidth    = 30
        vim.o.winminwidth = 30
        vim.o.equalalways = false
        require('windows').setup()
    end
}
