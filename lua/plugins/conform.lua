local ft  = {
    c          = { "clang_format" },
    cpp        = { "clang_format" },
    sh         = { "shfmt" },
    zsh        = { "shfmt" },
    go         = { "gofmt", "goimports" },
    javascript = { "prettierd", "prettier" },
    html       = { "prettierd", "prettier" },
    css        = { "prettierd", "prettier" },
    json       = { "prettierd", "prettier" },
    jsonc      = { "prettierd", "prettier" },
    python     = { "ruff", "isort", "black" },
}

local fmt = {
    clang_format = {
        args = { "--style=file" },
    },
    shfmt        = {
        args = { "-ln=bash", "-i=8", "-ci" }
    },
        prettier = {
                args = { "--tab-width=8" }
        },
}

return {
    "stevearc/conform.nvim",
    event  = { "BufReadPre", "BufNewFile", "BufWritePost" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = ft,
            formatters       = fmt,
        })
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                lsp_fallback = true,
                async        = false,
                timeout_ms   = 1000
            })
        end)
    end
}
