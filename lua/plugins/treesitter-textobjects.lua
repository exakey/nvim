local textObj = require("core.utils").extraTextobjMaps
--------------------------------------------------------------------------------

return { -- treesitter-based textobjs
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
        cmd = { -- commands need to be defined, since used in various utility functions
                "TSTextobjectSelect",
                "TSTextobjectSwapNext",
                "TSTextobjectSwapPrevious",
                "TSTextobjectGotoNextStart",
                "TSTextobjectGotoPreviousStart",
        },
        keys = {
                -- COMMENT OPERATIONS
                {
                        "q",
                        function() vim.cmd.TSTextobjectSelect("@comment.outer") end,
                        mode = "o", -- only operator-pending to not conflict with selection-commenting
                        desc = "󰆈 Single Comment",
                },
                {
                        "dq",
                        function()
                                local prevCursor = vim.api.nvim_win_get_cursor(0)
                                vim.cmd.TSTextobjectSelect("@comment.outer")
                                vim.cmd.normal { "d", bang = true }
                                vim.api.nvim_win_set_cursor(0, prevCursor)
                        end,
                        desc = "󰆈 Sticky Delete Comment",
                },
                {
                        "cq",
                        function()
                                vim.cmd.TSTextobjectSelect("@comment.outer")
                                vim.cmd.normal { "d", bang = true }
                                local comStr = vim.trim(vim.bo.commentstring:format(""))
                                local line   = vim.api.nvim_get_current_line():gsub("%s+$", "")
                                vim.api.nvim_set_current_line(line .. " " .. comStr .. " ")
                                vim.cmd.startinsert { bang = true }
                        end,
                        desc = "󰆈 Change Comment",
                },
                -- MOVE & SWAP
                -- stylua: ignore start
                { "q,", "<cmd>TSTextobjectGotoPreviousStart @comment.outer<CR>zz", desc = " Swap next arg" },
                { "q.", "<cmd>TSTextobjectGotoNextStart @comment.outer<CR>zz", desc = " Swap next arg" },
                { "<A-;>", "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>zz", desc = " Swap prev arg" },
                { "<A-'>", "<cmd>TSTextobjectSwapNext @parameter.inner<CR>zz", desc = " Swap next arg" },
                { "<A-.>", "<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>zz", desc = " Swap prev arg" },
                { "<A-,>", "<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>zz", desc = " Swap next arg" },
                -- stylua: ignore end

                -- TEXT OBJECTS
                -- stylua: ignore start
                { "a<CR>", "<cmd>TSTextobjectSelect @return.outer<CR>zz", mode = { "x", "o" }, desc = "↩ outer return" },
                { "<CR>", "<cmd>TSTextobjectSelect @return.inner<CR>zz", mode = "o", desc = "↩ inner return" },
                { "a/", "<cmd>TSTextobjectSelect @regex.outer<CR>zz", mode = { "x", "o" }, desc = " outer regex" },
                { "i/", "<cmd>TSTextobjectSelect @regex.inner<CR>zz", mode = { "x", "o" }, desc = " inner regex" },
                { "aa", "<cmd>TSTextobjectSelect @parameter.outer<CR>zz", mode = { "x", "o" }, desc = "󰏪 outer parameter" },
                { "ia", "<cmd>TSTextobjectSelect @parameter.inner<CR>zz", mode = { "x", "o" }, desc = "󰏪 inner parameter" },
                { "iu", "<cmd>TSTextobjectSelect @loop.inner<CR>zz", mode = { "x", "o" }, desc = "󰛤 inner loop" },
                { "au", "<cmd>TSTextobjectSelect @loop.outer<CR>zz", mode = { "x", "o" }, desc = "󰛤 outer loop" },
                { "a" .. textObj.func, "<cmd>TSTextobjectSelect @function.outer<CR>zz", mode = { "x", "o" }, desc = " outer function" },
                { "i" .. textObj.func, "<cmd>TSTextobjectSelect @function.inner<CR>zz", mode = { "x", "o" }, desc = " inner function" },
                { "a" .. textObj.condition, "<cmd>TSTextobjectSelect @conditional.outer<CR>zz", mode = { "x", "o" }, desc = "󱕆 outer condition" },
                { "i" .. textObj.condition, "<cmd>TSTextobjectSelect @conditional.inner<CR>zz", mode = { "x", "o" }, desc = "󱕆 inner condition" },
                { "a" .. textObj.call, "<cmd>TSTextobjectSelect @call.outer<CR>zz", mode = { "x", "o" }, desc = "󰡱 outer call" },
                { "i" .. textObj.call, "<cmd>TSTextobjectSelect @call.inner<CR>zz", mode = { "x", "o" }, desc = "󰡱 inner call" },
                -- stylua: ignore end
        },
}
