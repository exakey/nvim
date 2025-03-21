local config = {
        invoke_on_body = true,
        on_key         = function()
                vim.wait(0, function() vim.cmd "redraw" end, 30, false)
                vim.cmd("norm zz")
        end,
        color          = "pink"
}

local opts   = {
        silent = true,
        nowait = true,
        mode   = { "n", "x" }
}

local fold   = {

        { -- L1
                "1",
                function()
                        require("ufo").closeFoldsWith(1)
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- L2
                "2",
                function()
                        require("ufo").closeFoldsWith(2)
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- L3
                "3",
                function()
                        require("ufo").closeFoldsWith(3)
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- L4
                "4",
                function()
                        require("ufo").closeFoldsWith(4)
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- L5
                "5",
                function()
                        require("ufo").closeFoldsWith(5)
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- CLOSE ALL
                "H",
                function()
                        require("ufo").closeAllFolds()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- OPEN ALL
                "L",
                function()
                        require("ufo").openAllFolds()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { "h", "zczz", opts },
        { "l", "zozz", opts },
        { "j", "zjzz", opts },
        { -- GOTO PREV
                "k",
                function()
                        require("ufo").goPreviousStartFold()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { "J", "zOzz", opts },
        { -- PREVIEW
                "K",
                function()
                        local winid = require("ufo").peekFoldedLinesUnderCursor()
                        if not winid then vim.lsp.buf.hover() end
                end,
                opts
        },

        { -- CURSOR LEFT
                "<C-h>",
                function()
                        require("smart-splits").move_cursor_left()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- CURSOR DOWN
                "<C-j>",
                function()
                        require("smart-splits").move_cursor_down()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- CURSOR UP
                "<C-k>",
                function()
                        require("smart-splits").move_cursor_up()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- CURSOR RIGHT
                "<C-l>",
                function()
                        require("smart-splits").move_cursor_right()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- CURSOR PREVIOUS
                "<C-o>",
                function()
                        require("smart-splits").move_cursor_previous()
                        vim.cmd("norm zz")
                end,
                opts
        },

        { '<Esc>', nil,  { exit = true, desc = false }}
}

local window = {

        -- SHIFT
        { -- SHIFT LEFT
                "<C-h>", "<cmd>WinShift left<CR>", opts
        },
        { -- SHIFT DOWN
                "<C-j>", "<cmd>WinShift down<CR>", opts
        },
        { -- SHIFT UP
                "<C-k>", "<cmd>WinShift up<CR>", opts
        },
        { -- SHIFT RIGHT
                "<C-l>", "<cmd>WinShift right<CR>", opts
        },
        { -- SHIFT LEFT  FAR
                "<S-H>", "<cmd>WinShift far_left<CR>", opts
        },
        { -- SHIFT DOWN  FAR
                "<S-J>", "<cmd>WinShift far_down<CR>", opts
        },
        { -- SHIFT UP    FAR
                "<S-K>", "<cmd>WinShift far_up<CR>", opts
        },
        { -- SHIFT RIGHT FAR
                "<S-L>", "<cmd>WinShift far_right<CR>", opts
        },

        -- CURSOR
        { -- LEFT
                "h",
                function()
                        require("smart-splits").move_cursor_left()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- DOWN
                "j",
                function()
                        require("smart-splits").move_cursor_down()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- UP
                "k",
                function()
                        require("smart-splits").move_cursor_up()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- RIGHT
                "l",
                function()
                        require("smart-splits").move_cursor_right()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- PREVIOUS
                "u",
                function()
                        require("smart-splits").move_cursor_previous()
                        vim.cmd("norm zz")
                end,
                opts
        },

        -- RESIZE
        { -- LEFT
                "<A-h>",
                function() require("smart-splits").resize_left() end, opts
        },
        { -- DOWN
                "<A-j>",
                function() require("smart-splits").resize_down() end, opts
        },
        { -- UP
                "<A-k>",
                function() require("smart-splits").resize_up() end, opts
        },
        { -- RIGHT
                "<A-l>",
                function() require("smart-splits").resize_right() end, opts
        },

        -- SPLIT
        { -- VERTICAL
                "v", "<C-W>vzz", opts
        },
        { -- HORIZONTAL
                "s", "<C-W>szz", opts
        },
        { -- DELETE
                "d", "<C-W>czz", opts
        },

        { '<Esc>', nil,  { exit = true, desc = false }}
}

local tree   = {

        -- CRUSOR
        { -- CURSOR LEFT
                "<C-h>",
                function()
                        require("smart-splits").move_cursor_left()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- CURSOR DOWN
                "<C-j>",
                function()
                        require("smart-splits").move_cursor_down()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- CURSOR UP
                "<C-k>",
                function()
                        require("smart-splits").move_cursor_up()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- CURSOR RIGHT
                "<C-l>",
                function()
                        require("smart-splits").move_cursor_right()
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- CURSOR PREVIOUS
                "<C-o>",
                function()
                        require("smart-splits").move_cursor_previous()
                        vim.cmd("norm zz")
                end,
                opts
        },

        -- SWAP
        { -- ARG  INNER PREV
                "<A-S-P>",
                "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>zz",
                opts
        },
        { -- ARG  INNER NEXT
                "<A-p>",
                "<cmd>TSTextobjectSwapNext @parameter.inner<CR>zz",
                opts
        },

        -- MOVE
        { -- FUNC OUTER PREV
                "F",
                "<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>zz",
                opts
        },
        { -- FUNC OUTER NEXT
                "f",
                "<cmd>TSTextobjectGotoNextStart @function.outer<CR>zz",
                opts
        },
        { -- FUNC INNER PREV
                "<C-S-F>",
                "<cmd>TSTextobjectGotoPreviousStart @function.inner<CR>zz",
                opts
        },
        { -- FUNC INNER NEXT
                "<C-f>",
                "<cmd>TSTextobjectGotoNextStart @function.inner<CR>zz",
                opts
        },

        { -- COND OUTER PREV
                "I",
                "<cmd>TSTextobjectGotoPreviousStart @conditional.outer<CR>zz",
                opts
        },
        { -- COND OUTER NEXT
                "i",
                "<cmd>TSTextobjectGotoNextStart @conditional.outer<CR>zz",
                opts
        },
        { -- COND INNER PREV
                "<C-S-I>",
                "<cmd>TSTextobjectGotoPreviousStart @conditional.inner<CR>zz",
                opts
        },
        { -- COND INNER NEXT
                "<C-i>",
                "<cmd>TSTextobjectGotoNextStart @conditional.inner<CR>zz",
                opts
        },

        { -- LOOP OUTER PREV
                "W",
                "<cmd>TSTextobjectGotoPreviousStart @loop.outer<CR>zz",
                opts
        },
        { -- LOOP OUTER NEXT
                "w",
                "<cmd>TSTextobjectGotoNextStart @loop.outer<CR>zz",
                opts
        },
        { -- LOOP INNER PREV
                "<C-S-W>",
                "<cmd>TSTextobjectGotoPreviousStart @loop.inner<CR>zz",
                opts
        },
        { -- LOOP INNER NEXT
                "<C-w>",
                "<cmd>TSTextobjectGotoNextStart @loop.inner<CR>zz",
                opts
        },

        { -- ASGN OUTER PREV
                "A",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.outer<CR>zz",
                opts
        },
        { -- ASGN OUTER NEXT
                "a",
                "<cmd>TSTextobjectGotoNextStart @assignment.outer<CR>zz",
                opts
        },
        { -- ASGN INNER PREV
                "<C-S-A>",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.inner<CR>zz",
                opts
        },
        { -- ASGN INNER NEXT
                "<C-a>",
                "<cmd>TSTextobjectGotoNextStart @assignment.inner<CR>zz",
                opts
        },

        { -- CALL OUTER PREV
                "K",
                "<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>zz",
                opts
        },
        { -- CALL OUTER NEXT
                "k",
                "<cmd>TSTextobjectGotoNextStart @call.outer<CR>zz",
                opts
        },
        { -- CALL OUTER PREV
                "<C-S-K>",
                "<cmd>TSTextobjectGotoPreviousStart @call.inner<CR>zz",
                opts
        },
        { -- CALL OUTER NEXT
                "<C-k>",
                "<cmd>TSTextobjectGotoNextStart @call.inner<CR>zz",
                opts
        },

        { -- ARG  INNER PREV
                "P",
                "<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>zz",
                opts
        },
        { -- ARG  INNER NEXT
                "p",
                "<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>zz",
                opts
        },

        { -- COMM OUTER PREV
                "Q",
                "<cmd>TSTextobjectGotoPreviousStart @comment.outer<CR>zz",
                opts
        },
        { -- COMM OUTER NEXT
                "q",
                "<cmd>TSTextobjectGotoNextStart @comment.outer<CR>zz",
                opts
        },
        { -- COMM TODO  PREV
                "t",
                function()
                        require("todo-comments").jump_next()
                end,
                opts
        },
        { -- COMM TODO  NEXT
                "T",
                function()
                        require("todo-comments").jump_prev()
                end,
                opts
        },

        { -- NODE END
                "N",
                "<cmd>TSTextobjectGotoPreviousStart @_end<CR>zz",
                opts
        },
        { -- NODE START
                "n",
                "<cmd>TSTextobjectGotoNextStart @_start<CR>zz",
                opts
        },

        { '<Esc>', nil,  { exit = true, desc = false }}
}

local lsp    = {

        -- DIAGNOSTICS
        { -- DIAG NEXT
                "d",
                function()
                        vim.diagnostic.goto_next({ float = false })
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- DIAG PREV
                "D",
                function()
                        vim.diagnostic.goto_prev({ float = false })
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- ERROR  NEXT
                "e",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.ERROR })
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- ERROR  PREV
                "E",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.ERROR })
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- WARN  NEXT
                "w",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.WARN })
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- WARN  PREV
                "W",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.WARN })
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- INFO  NEXT
                "i",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.INFO })
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- INFO  PREV
                "I",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.INFO })
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- HINT  NEXT
                "h",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.HINT })
                        vim.cmd("norm zz")
                end,
                opts
        },
        { -- HINT  PREV
                "H",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.HINT })
                        vim.cmd("norm zz")
                end,
                opts
        },

        -- FUNC and CALL
        { -- FUNC OUTER PREV
                "F",
                "<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>zz",
                opts
        },
        { -- FUNC OUTER NEXT
                "f",
                "<cmd>TSTextobjectGotoNextStart @function.outer<CR>zz",
                opts
        },
        { -- FUNC INNER PREV
                "<C-S-F>",
                "<cmd>TSTextobjectGotoPreviousStart @function.inner<CR>zz",
                opts
        },
        { -- FUNC INNER NEXT
                "<C-f>",
                "<cmd>TSTextobjectGotoNextStart @function.inner<CR>zz",
                opts
        },
        { -- CALL OUTER PREV
                "K",
                "<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>zz",
                opts
        },
        { -- CALL OUTER NEXT
                "k",
                "<cmd>TSTextobjectGotoNextStart @call.outer<CR>zz",
                opts
        },
        { -- CALL OUTER PREV
                "<C-S-K>",
                "<cmd>TSTextobjectGotoPreviousStart @call.inner<CR>zz",
                opts
        },
        { -- CALL OUTER NEXT
                "<C-k>",
                "<cmd>TSTextobjectGotoNextStart @call.inner<CR>zz",
                opts
        },

        -- LSP NAV
        { -- DEFINITION
                "<C-d>",
                function()
                        Snacks.picker.lsp_definitions()
                end,
                opts
        },
        { -- REFERENCE
                "r",
                function()
                        Snacks.picker.lsp_references({
                                on_show = function() vim.cmd.stopinsert() end
                        })
                end,
                opts
        },

        { '<Esc>', nil,  { exit = true, desc = false }}
}

return {
        "anuvyklack/hydra.nvim",
        lazy   = false,
        event  = "VeryLazy",
        config = function()
                local hydra = require("hydra")

                hydra({ -- FOLDMODE
                        name   = "FOLDMODE",
                        config = config,
                        mode   = { "n", "v" },
                        body   = "<leader>z",
                        heads  = fold,
                })
                hydra({ -- WINMODE
                        name   = "winmode",
                        config = config,
                        mode   = { "n", "v" },
                        body   = "<leader>w",
                        heads  = window
                })
                hydra({ -- TREEMODE
                        name   = "TREEMODE",
                        config = config,
                        mode   = { "n", "v" },
                        body   = "<leader>t",
                        color  = "pink",
                        heads  = tree
                })
                hydra({ -- LSPMODE
                        name   = "LSPMODE",
                        config = config,
                        mode   = { "n", "v" },
                        body   = "<leader>a",
                        heads  = lsp
                })
        end
}
