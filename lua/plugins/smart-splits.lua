return {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
        keys  = {
                { -- MOVE LEFT
                        "<C-h>",
                        function()
                                require("smart-splits").move_cursor_left()
                        end
                },
                { -- MOVE DOWN
                        "<C-j>",
                        function()
                                require("smart-splits").move_cursor_down()
                        end
                },
                { -- MOVE UP
                        "<C-k>",
                        function()
                                require("smart-splits").move_cursor_up()
                        end
                },
                { -- MOVE RIGHT
                        "<C-l>",
                        function()
                                require("smart-splits").move_cursor_right()
                        end
                },
                { -- MOVE PREVIOUS
                        "<C-S-o>",
                        function()
                                require("smart-splits").move_cursor_previous()
                        end
                },
                { -- RESIZE LEFT
                        "<C-left>",
                        function()
                                require("smart-splits").resize_left()
                        end
                },
                { -- RESIZE DOWN
                        "<C-down>",
                        function()
                                require("smart-splits").resize_down()
                        end
                },
                { -- RESIZE UP
                        "<C-up>",
                        function()
                                require("smart-splits").resize_up()
                        end
                },
                { -- RESIZE RIGHT
                        "<C-right>",
                        function()
                                require("smart-splits").resize_right()
                        end
                },
        },
}
