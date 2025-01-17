return {     -- Better input/selection fields
    "stevearc/dressing.nvim",
    init = function(spec)
        ---@diagnostic disable: duplicate-set-field
        vim.ui.select = function(...)
            require("lazy").load { plugins = { spec.name } }
            return vim.ui.select(...)
        end

        vim.ui.input = function(...)
            require("lazy").load { plugins = { spec.name } }
            return vim.ui.input(...)
        end
        ---@diagnostic enable: duplicate-set-field
    end,
    keys = {
        { "<Tab>",   "j", ft = "DressingSelect" },
        { "<S-Tab>", "k", ft = "DressingSelect" },
    },
    opts = {
        input  = {
            trim_prompt  = true,
            border       = vim.g.borderStyle,
            relative     = "editor",
            prefer_width = 45,
            min_width    = 0.4,
            max_width    = 0.8,
            mappings     = { n = { ["q"] = "Close" } },
        },
        select = {
            trim_prompt = true,
            builtin     = {
                show_numbers = false,
                border       = vim.g.borderStyle,
                relative     = "editor",
                max_width    = 80,
                min_width    = 20,
                max_height   = 12,
                min_height   = 3,
                mappings     = { ["q"] = "Close" },
            },
            telescope   = {
                layout_config = {
                    horizontal = { width = { 0.7, max = 75 }, height = 0.6 },
                },
            },
            get_config  = function(opts)
                local useBuiltin = { "plain", "codeaction", "rule_selection" }
                if vim.tbl_contains(useBuiltin, opts.kind) then
                    return {
                        backend = { "builtin" },
                        builtin = { relative = "cursor" },
                    }
                end
            end,
        },
    },
}
