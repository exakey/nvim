local fold   = {

        { -- L1
                "1",
                function()
                        require("ufo").closeFoldsWith(1)
                        vim.cmd("norm zz")
                end,
                desc = "󱃄 Close L1 folds",
        },
        { -- L2
                "2",
                function()
                        require("ufo").closeFoldsWith(2)
                        vim.cmd("norm zz")
                end,
                desc = "󱃄 Close L2 folds",
        },
        { -- L3
                "3",
                function()
                        require("ufo").closeFoldsWith(3)
                        vim.cmd("norm zz")
                end,
                desc = "󱃄 Close L3 folds",
        },
        { -- L4
                "4",
                function()
                        require("ufo").closeFoldsWith(4)
                        vim.cmd("norm zz")
                end,
                desc = "󱃄 Close L4 folds",
        },
        { -- L5
                "5",
                function()
                        require("ufo").closeFoldsWith(5)
                        vim.cmd("norm zz")
                end,
                desc = "󱃄 Close L5 folds",
        },
        { -- CLOSE ALL
                "H",
                function()
                        require("ufo").closeAllFolds()
                        vim.cmd("norm zz")
                end,
                desc = "󱃄 Close all folds",
        },
        { -- OPEN ALL
                "L",
                function()
                        require("ufo").openAllFolds()
                        vim.cmd("norm zz")
                end,
                desc = "󱃄 Open all folds",
        },
        { "h", "zczz", desc = "󱃄 Close fold" },
        { "l", "zozz", desc = "󱃄 Open fold" },
        { "j", "zjzz", desc = "󱃄 Goto next fold" },
        { -- GOTO PREV
                "k",
                function()
                        require("ufo").goPreviousStartFold()
                        vim.cmd("norm zz")
                end,
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

        { -- CURSOR LEFT
                "<C-h>",
                function()
                        require("smart-splits").move_cursor_left()
                        vim.cmd("norm zz")
                end
        },
        { -- CURSOR DOWN
                "<C-j>",
                function()
                        require("smart-splits").move_cursor_down()
                        vim.cmd("norm zz")
                end
        },
        { -- CURSOR UP
                "<C-k>",
                function()
                        require("smart-splits").move_cursor_up()
                        vim.cmd("norm zz")
                end
        },
        { -- CURSOR RIGHT
                "<C-l>",
                function()
                        require("smart-splits").move_cursor_right()
                        vim.cmd("norm zz")
                end
        },
        { -- CURSOR PREVIOUS
                "<C-o>",
                function()
                        require("smart-splits").move_cursor_previous()
                        vim.cmd("norm zz")
                end
        },
}

local window = {

        -- SHIFT
        { -- SHIFT LEFT
                "<C-h>", "<cmd>WinShift left<CR>"
        },
        { -- SHIFT DOWN
                "<C-j>", "<cmd>WinShift down<CR>"
        },
        { -- SHIFT UP
                "<C-k>", "<cmd>WinShift up<CR>"
        },
        { -- SHIFT RIGHT
                "<C-l>", "<cmd>WinShift right<CR>"
        },
        { -- SHIFT LEFT  FAR
                "<S-H>", "<cmd>WinShift far_left<CR>"
        },
        { -- SHIFT DOWN  FAR
                "<S-J>", "<cmd>WinShift far_down<CR>"
        },
        { -- SHIFT UP    FAR
                "<S-K>", "<cmd>WinShift far_up<CR>"
        },
        { -- SHIFT RIGHT FAR
                "<S-L>", "<cmd>WinShift far_right<CR>"
        },

        -- CURSOR
        { -- LEFT
                "h",
                function()
                        require("smart-splits").move_cursor_left()
                        vim.cmd("norm zz")
                end
        },
        { -- DOWN
                "j",
                function()
                        require("smart-splits").move_cursor_down()
                        vim.cmd("norm zz")
                end
        },
        { -- UP
                "k",
                function()
                        require("smart-splits").move_cursor_up()
                        vim.cmd("norm zz")
                end
        },
        { -- RIGHT
                "l",
                function()
                        require("smart-splits").move_cursor_right()
                        vim.cmd("norm zz")
                end
        },
        { -- PREVIOUS
                "u",
                function()
                        require("smart-splits").move_cursor_previous()
                        vim.cmd("norm zz")
                end
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

        -- SPLIT
        { -- VERTICAL
                "v",
                "<C-W>vzz"
        },
        { -- HORIZONTAL
                "s",
                "<C-W>szz"
        },
        { -- DELETE
                "d",
                "<C-W>czz"
        },
}

local tree   = {

        -- CRUSOR
        { -- CURSOR LEFT
                "<C-h>",
                function()
                        require("smart-splits").move_cursor_left()
                        vim.cmd("norm zz")
                end
        },
        { -- CURSOR DOWN
                "<C-j>",
                function()
                        require("smart-splits").move_cursor_down()
                        vim.cmd("norm zz")
                end
        },
        { -- CURSOR UP
                "<C-k>",
                function()
                        require("smart-splits").move_cursor_up()
                        vim.cmd("norm zz")
                end
        },
        { -- CURSOR RIGHT
                "<C-l>",
                function()
                        require("smart-splits").move_cursor_right()
                        vim.cmd("norm zz")
                end
        },
        { -- CURSOR PREVIOUS
                "<C-o>",
                function()
                        require("smart-splits").move_cursor_previous()
                        vim.cmd("norm zz")
                end
        },

        -- SWAP
        { -- ARG  INNER PREV
                "<A-S-P>",
                "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>zz",
                desc = " Swap prev arg",
        },
        { -- ARG  INNER NEXT
                "<A-p>",
                "<cmd>TSTextobjectSwapNext @parameter.inner<CR>zz",
                desc = " Swap next arg",
        },

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
                "<C-S-F>",
                "<cmd>TSTextobjectGotoPreviousStart @function.inner<CR>zz",
                desc = " Goto prev function",
        },
        { -- FUNC INNER NEXT
                "<C-f>",
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
                "<C-S-I>",
                "<cmd>TSTextobjectGotoPreviousStart @conditional.inner<CR>zz",
                desc = " Goto prev cond",
        },
        { -- COND INNER NEXT
                "<C-i>",
                "<cmd>TSTextobjectGotoNextStart @conditional.inner<CR>zz",
                desc = " Goto next cond",
        },

        { -- LOOP OUTER PREV
                "W",
                "<cmd>TSTextobjectGotoPreviousStart @loop.outer<CR>zz",
                desc = " Goto prev loop",
        },
        { -- LOOP OUTER NEXT
                "w",
                "<cmd>TSTextobjectGotoNextStart @loop.outer<CR>zz",
                desc = " Goto next loop",
        },
        { -- LOOP INNER PREV
                "<C-S-W>",
                "<cmd>TSTextobjectGotoPreviousStart @loop.inner<CR>zz",
                desc = " Goto prev loop",
        },
        { -- LOOP INNER NEXT
                "<C-w>",
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
                "<C-S-A>",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.inner<CR>zz",
                desc = " Goto next assignment",
        },
        { -- ASGN INNER NEXT
                "<C-a>",
                "<cmd>TSTextobjectGotoNextStart @assignment.inner<CR>zz",
                desc = " Goto next assignment",
        },

        { -- CALL OUTER PREV
                "K",
                "<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>zz",
                desc = " Goto prev call",
        },
        { -- CALL OUTER NEXT
                "k",
                "<cmd>TSTextobjectGotoNextStart @call.outer<CR>zz",
                desc = " Goto next call",
        },
        { -- CALL OUTER PREV
                "<C-S-K>",
                "<cmd>TSTextobjectGotoPreviousStart @call.inner<CR>zz",
                desc = " Goto prev call",
        },
        { -- CALL OUTER NEXT
                "<C-k>",
                "<cmd>TSTextobjectGotoNextStart @call.inner<CR>zz",
                desc = " Goto next call",
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

        { -- COMM OUTER PREV
                "Q",
                "<cmd>TSTextobjectGotoPreviousStart @comment.outer<CR>zz",
                desc = " Goto prev comment",
        },
        { -- COMM OUTER NEXT
                "q",
                "<cmd>TSTextobjectGotoNextStart @comment.outer<CR>zz",
                desc = " Goto next comment",
        },
        { -- COMM TODO  PREV
                "t",
                function ()
                        require("todo-comments").jump_next()
                end,
        },
        { -- COMM TODO  NEXT
                "T",
                function ()
                        require("todo-comments").jump_prev()
                end,
        },

        { -- NODE END
                "N",
                "<cmd>TSTextobjectGotoPreviousStart @_end<CR>zz",
                desc = " Goto prev arg",
        },
        { -- NODE START
                "n",
                "<cmd>TSTextobjectGotoNextStart @_start<CR>zz",
                desc = " Goto next arg",
        },
}

local lsp    = {

        -- DIAGNOSTICS
        { -- DIAG NEXT
                "d",
                function ()
                        vim.diagnostic.goto_next({ float = false })
                        vim.cmd("norm zz")
                end
        },
        { -- DIAG PREV
                "D",
                function ()
                        vim.diagnostic.goto_prev({ float = false })
                        vim.cmd("norm zz")
                end
        },
        { -- ERROR  NEXT
                "e",
                function ()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.ERROR })
                        vim.cmd("norm zz")
                end
        },
        { -- ERROR  PREV
                "E",
                function ()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.ERROR })
                        vim.cmd("norm zz")
                end
        },
        { -- WARN  NEXT
                "w",
                function ()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.WARN })
                        vim.cmd("norm zz")
                end
        },
        { -- WARN  PREV
                "W",
                function ()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.WARN })
                        vim.cmd("norm zz")
                end
        },
        { -- INFO  NEXT
                "i",
                function ()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.INFO })
                        vim.cmd("norm zz")
                end
        },
        { -- INFO  PREV
                "I",
                function ()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.INFO })
                        vim.cmd("norm zz")
                end
        },
        { -- HINT  NEXT
                "h",
                function ()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.HINT })
                        vim.cmd("norm zz")
                end
        },
        { -- HINT  PREV
                "H",
                function ()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.HINT })
                        vim.cmd("norm zz")
                end
        },

        -- FUNC and CALL
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
                "<C-S-F>",
                "<cmd>TSTextobjectGotoPreviousStart @function.inner<CR>zz",
                desc = " Goto prev function",
        },
        { -- FUNC INNER NEXT
                "<C-f>",
                "<cmd>TSTextobjectGotoNextStart @function.inner<CR>zz",
                desc = " Goto next function",
        },
        { -- CALL OUTER PREV
                "K",
                "<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>zz",
                desc = " Goto prev call",
        },
        { -- CALL OUTER NEXT
                "k",
                "<cmd>TSTextobjectGotoNextStart @call.outer<CR>zz",
                desc = " Goto next call",
        },
        { -- CALL OUTER PREV
                "<C-S-K>",
                "<cmd>TSTextobjectGotoPreviousStart @call.inner<CR>zz",
                desc = " Goto prev call",
        },
        { -- CALL OUTER NEXT
                "<C-k>",
                "<cmd>TSTextobjectGotoNextStart @call.inner<CR>zz",
                desc = " Goto next call",
        },

        -- LSP NAV
        { -- DEFINITION
                "<C-d>",
                function()
                        Snacks.picker.lsp_definitions()
                end,
        },
        { -- REFERENCE
                "r",
                function ()
                        Snacks.picker.lsp_references({
                                on_show = function() vim.cmd.stopinsert() end
                        })
                end
        },
}

return {
        "anuvyklack/hydra.nvim",
        lazy   = false,
        event  = "VeryLazy",
        config = function()
                local hydra = require("hydra")

                hydra({ -- FOLDMODE
                        name   = "FOLDMODE",
                        config = {
                                invoke_on_body = true,
                                on_key         = function()
                                        vim.wait(0, function() vim.cmd "redraw" end, 0, false) vim.cmd("norm zz")
                                end
                        },
                        mode   = { "n", "v" },
                        body   = "<leader>z",
                        heads  = fold,
                })
                hydra({ -- WINMODE
                        name   = "winmode",
                        config = {
                                invoke_on_body = true,
                                on_key         = function()
                                        vim.wait(0, function() vim.cmd "redraw" end, 30, false) vim.cmd("norm zz")
                                end
                        },
                        mode   = { "n", "v" },
                        body   = "<leader>w",
                        heads  = window
                })
                hydra({ -- TREEMODE
                        name   = "TREEMODE",
                        config = {
                                invoke_on_body = true,
                                on_key         = function()
                                        vim.wait(0, function() vim.cmd "redraw" end, 30, false) vim.cmd("norm zz")
                                end
                        },
                        mode   = { "n", "v" },
                        body   = "<leader>t",
                        heads  = tree
                })
                hydra({ -- LSPMODE
                        name   = "LSPMODE",
                        config = {
                                invoke_on_body = true,
                                on_key         = function()
                                        vim.wait(0, function() vim.cmd "redraw" end, 30, false) vim.cmd("norm zz")
                                end
                        },
                        mode   = { "n", "v" },
                        body   = "<leader>a",
                        heads  = lsp
                })
        end
}
