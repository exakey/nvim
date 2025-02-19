return {     --twilight
    "monaqa/dial.nvim",
    enabled = true,
    keys    = {
        {     -- example for lazy-loading on keystroke
            "<leader>tl",
            "<cmd>Twilight<CR>",
            mode = { "n", "o", "x" },
            desc = "Toggle Twilight",
        },
    },
    config  = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group({
            -- default augends used when no group name is specified
            default = {
                augend.semver.alias.semver,
                augend.integer.alias.decimal,     -- nonnegative decimal number (0, 1, 2, 3, ...)
                augend.constant.alias.bool,       -- boolean value (true <-> false)
                augend.integer.alias.hex,         -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                augend.constant.alias.alpha,
                augend.constant.alias.Alpha,
                augend.hexcolor.new({
                    case = "lower",
                }),
                augend.constant.new({
                    elements = { "and", "or" },
                    word     = true,     -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                    cyclic   = true,     -- "or" is incremented into "and".
                }),
                augend.constant.new({
                    elements = { "&&", "||" },
                    word     = false,
                    cyclic   = true,
                }),
                augend.integer.new({
                    radix   = 16,
                    prefix  = "0x",
                    natural = true,
                    case    = "upper",
                }),
                augend.date.new({
                    pattern      = "%d/%m/%Y",
                    default_kind = "day",
                    -- if true, it does not match dates which does not exist, such as 2022/05/32
                    only_valid   = true,
                    -- if true, it only matches dates with word boundary
                    word         = false,
                }),
                augend.date.new({
                    pattern      = "%Y/%m/%d",
                    default_kind = "day",
                    -- if true, it does not match dates which does not exist, such as 2022/05/32
                    only_valid   = true,
                    -- if true, it only matches dates with word boundary
                    word         = false,
                }),
            },

            -- augends used when group with name `mygroup` is specified
            mygroup = {},
        })
    end,
    vim.keymap.set("n", "+", function()
        require("dial.map").manipulate("increment", "normal")
    end),
    vim.keymap.set("n", "-", function()
        require("dial.map").manipulate("decrement", "normal")
    end),
    vim.keymap.set("n", "+", function()
        require("dial.map").manipulate("increment", "gnormal")
    end),
    vim.keymap.set("n", "-", function()
        require("dial.map").manipulate("decrement", "gnormal")
    end),
    vim.keymap.set("v", "+", function()
        require("dial.map").manipulate("increment", "visual")
    end),
    vim.keymap.set("v", "-", function()
        require("dial.map").manipulate("decrement", "visual")
    end),
    vim.keymap.set("v", "+", function()
        require("dial.map").manipulate("increment", "gvisual")
    end),
    vim.keymap.set("v", "-", function()
        require("dial.map").manipulate("decrement", "gvisual")
    end),
}
