local fold    = {
        { -- L1
                "1",
                function() require("ufo").closeFoldsWith(1) vim.cmd("norm zz") end,
                desc = "󱃄 Close L1 folds",
        },
        { -- L2
                "2",
                function() require("ufo").closeFoldsWith(2) vim.cmd("norm zz") end,
                desc = "󱃄 Close L2 folds",
        },
        { -- L3
                "3",
                function() require("ufo").closeFoldsWith(3) vim.cmd("norm zz") end,
                desc = "󱃄 Close L3 folds",
        },
        { -- L4
                "4",
                function() require("ufo").closeFoldsWith(4) vim.cmd("norm zz") end,
                desc = "󱃄 Close L4 folds",
        },
        { -- L5
                "5",
                function() require("ufo").closeFoldsWith(5) vim.cmd("norm zz") end,
                desc = "󱃄 Close L5 folds",
        },
        { -- CLOSE ALL
                "H",
                function() require("ufo").closeAllFolds() vim.cmd("norm zz") end,
                desc = "󱃄 Close all folds",
        },
        { -- OPEN ALL
                "L",
                function() require("ufo").openAllFolds() vim.cmd("norm zz") end,
                desc = "󱃄 Open all folds",
        },
        { "h", "zczz", desc = "󱃄 Close fold" },
        { "l", "zozz", desc = "󱃄 Open fold" },
        { "j", "zjzz", desc = "󱃄 Goto next fold" },
        { -- GOTO PREV
                "k",
                function() require("ufo").goPreviousStartFold() vim.cmd("norm zz") end,
                desc = "󱃄 Goto prev fold",
        },
        { "J", "zOzz", desc = "󱃄 Open all fold under cursor" },
        { -- PREVIEW
                "K",
                function()
                        local winid = require("ufo").peekFoldedLinesUnderCursor()
                        if not winid then vim.lsp.buf.hover() end
                end,
                desc = "󱃄 Preview fold"
        },
}

local windows = {
        -- SHIFT
        { -- SHIFT LEFT
                "h", "<cmd>WinShift left<CR>"
        },
        { -- SHIFT DOWN
                "j", "<cmd>WinShift down<CR>"
        },
        { -- SHIFT UP
                "k", "<cmd>WinShift up<CR>"
        },
        { -- SHIFT RIGHT
                "l", "<cmd>WinShift right<CR>"
        },

        -- CURSOR
        { -- LEFT
                "<C-h>",
                function()
                        require("smart-splits").move_cursor_left()
                        vim.cmd("norm zz")
                end
        },
        { -- DOWN
                "<C-j>",
                function() require("smart-splits").move_cursor_down() end
        },
        { -- UP
                "<C-k>",
                function() require("smart-splits").move_cursor_up() end
        },
        { -- RIGHT
                "<C-l>",
                function() require("smart-splits").move_cursor_right() end
        },
        { -- PREVIOUS
                "<C-o>",
                function() require("smart-splits").move_cursor_previous() end
        },

        -- RESIZE
        { -- LEFT
                "<A-h>",
                function() require("smart-splits").resize_left() end
        },
        { -- DOWN
                "<A-j>",
                function() require("smart-splits").resize_down() end
        },
        { -- UP
                "<A-k>",
                function() require("smart-splits").resize_up() end
        },
        { -- RIGHT
                "<A-l>",
                function() require("smart-splits").resize_right() end
        },
}

local tree    = {
        -- MOVE
        { -- FUNC OUTER PREV
                "F",
                "<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>zz",
                desc = " Goto prev function",
        },
        { -- FUNC OUTER NEXT
                "f",
                "<cmd>TSTextobjectGotoNextStart @function.outer<CR>zz",
                desc = " Goto next function",
        },
        { -- FUNC INNER PREV
                "<A-F>",
                "<cmd>TSTextobjectGotoPreviousStart @function.inner<CR>zz",
                desc = " Goto prev function",
        },
        { -- FUNC INNER NEXT
                "<A-f>",
                "<cmd>TSTextobjectGotoNextStart @function.inner<CR>zz",
                desc = " Goto next function",
        },
        { -- COND OUTER PREV
                "I",
                "<cmd>TSTextobjectGotoPreviousStart @conditional.outer<CR>zz",
                desc = " Goto prev cond",
        },
        { -- COND OUTER NEXT
                "i",
                "<cmd>TSTextobjectGotoNextStart @conditional.outer<CR>zz",
                desc = " Goto next cond",
        },
        { -- COND INNER PREV
                "<A-I>",
                "<cmd>TSTextobjectGotoPreviousStart @conditional.inner<CR>zz",
                desc = " Goto prev cond",
        },
        { -- COND INNER NEXT
                "<A-i>",
                "<cmd>TSTextobjectGotoNextStart @conditional.inner<CR>zz",
                desc = " Goto next cond",
        },
        { -- LOOP OUTER PREV
                "L",
                "<cmd>TSTextobjectGotoPreviousStart @loop.outer<CR>zz",
                desc = " Goto prev loop",
        },
        { -- LOOP OUTER NEXT
                "l",
                "<cmd>TSTextobjectGotoNextStart @loop.outer<CR>zz",
                desc = " Goto next loop",
        },
        { -- LOOP INNER PREV
                "<A-L>",
                "<cmd>TSTextobjectGotoPreviousStart @loop.inner<CR>zz",
                desc = " Goto prev loop",
        },
        { -- LOOP INNER NEXT
                "<A-l>",
                "<cmd>TSTextobjectGotoNextStart @loop.inner<CR>zz",
                desc = " Goto next loop",
        },
        { -- ASGN OUTER PREV
                "A",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.outer<CR>zz",
                desc = " Goto next assignment",
        },
        { -- ASGN OUTER NEXT
                "a",
                "<cmd>TSTextobjectGotoNextStart @assignment.outer<CR>zz",
                desc = " Goto next assignment",
        },
        { -- ASGN INNER PREV
                "<A-A>",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.inner<CR>zz",
                desc = " Goto next assignment",
        },
        { -- ASGN INNER NEXT
                "<A-a>",
                "<cmd>TSTextobjectGotoNextStart @assignment.inner<CR>zz",
                desc = " Goto next assignment",
        },
        { -- CALL OUTER PREV
                "C",
                "<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>zz",
                desc = " Goto prev call",
        },
        { -- CALL OUTER NEXT
                "c",
                "<cmd>TSTextobjectGotoNextStart @call.outer<CR>zz",
                desc = " Goto next call",
        },
        { -- COMT OUTER PREV
                "Q",
                "<cmd>TSTextobjectGotoPreviousStart @comment.outer<CR>zz",
                desc = " Goto prev comment",
        },
        { -- COMM OUTER NEXT
                "q",
                "<cmd>TSTextobjectGotoNextStart @comment.outer<CR>zz",
                desc = " Goto next comment",
        },
        { -- ARG  INNER PREV
                "P",
                "<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>zz",
                desc = " Goto prev arg",
        },
        { -- ARG  INNER NEXT
                "p",
                "<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>zz",
                desc = " Goto next arg",
        },

        -- SWAP
        { -- ARG  INNER PREV
                "<C-P>",
                "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>zz",
                desc = " Swap prev arg",
        },
        { -- ARG  INNER NEXT
                "<C-p>",
                "<cmd>TSTextobjectSwapNext @parameter.inner<CR>zz",
                desc = " Swap next arg",
        },
}

return {
        "anuvyklack/hydra.nvim",
        lazy   = false,
        event  = "VeryLazy",
        config = function()
                local hydra = require("hydra")

                hydra({ -- WINMODE
                        name   = "winmode",
                        config = { invoke_on_body = true },
                        mode   = "n",
                        body   = "<leader>w",
                        heads  = windows
                })
                hydra({ -- FOLDMODE
                        name   = "foldmode",
                        config = { invoke_on_body = true },
                        mode   = "n",
                        body   = "<leader>z",
                        heads  = fold,
                })
                hydra({ -- TREEMODE
                        name   = "treemode",
                        config = { invoke_on_body = true },
                        mode   = "n",
                        body   = "<leader>t",
                        heads  = tree
                })
        end
}
