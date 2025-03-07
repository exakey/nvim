return {
        "chrisgrieser/nvim-tinygit",
        -- branch = "dev",  -- TEMP

        -----------------------------------------------------------------------------

        event  = "VeryLazy", -- load for status line component
        keys   = {
                -- stylua: ignore start
                { "<leader>qq", function() require("tinygit").smartCommit { pushIfClean = true } end, desc = "󰊢 Smart-commit & push", nowait = true },
                { "<leader>qc", function() require("tinygit").smartCommit { pushIfClean = false } end, desc = "󰊢 Smart-commit" },
                { "<leader>qn", function() require("tinygit").interactiveStaging() end, desc = "󰊢 Interactive staging" },
                { "<leader>qp", function() require("tinygit").push { pullBefore = true } end, desc = "󰊢 Pull & push" },
                { "<leader>qP", function() require("tinygit").createGitHubPr() end, desc = " Create PR" },
                { "<leader>qf", function() require("tinygit").fixupCommit { autoRebase = true } end, desc = "󰊢 Fixup-commit & rebase" },
                { "<leader>qm", function() require("tinygit").amendNoEdit { forcePushIfDiverged = true } end, desc = "󰊢 Amend-commit & f-push" },
                { "<leader>qM", function() require("tinygit").amendOnlyMsg { forcePushIfDiverged = true } end, desc = "󰊢 Amend message & f-push" },
                { "<leader>qi", function() require("tinygit").issuesAndPrs { state = "open" } end, desc = " Open issues" },
                { "<leader>qI", function() require("tinygit").issuesAndPrs { state = "closed" } end, desc = " Closed issues" },
                { "<leader>qh", function() require("tinygit").fileHistory() end, mode = { "n", "x" }, desc = "󰋚 File history" },
                { "<leader>qu", function() require("tinygit").githubUrl("file") end, mode = { "n", "x" }, desc = " GitHub line URL" },
                { "<leader>qU", function() require("tinygit").githubUrl("repo") end, mode = { "n", "x" }, desc = " GitHub repo URL" },
                { "<leader>q!", function() require("tinygit").githubUrl("blame") end, mode = { "n", "x" }, desc = "󰆽 GitHub blame" },
                { "<leader>qt", function() require("tinygit").stashPush() end, desc = "󰜦 Stash" },
                { "<leader>qT", function() require("tinygit").stashPop() end, desc = "󰜦 Stash pop" },

                { "qi", function() require("tinygit").openIssueUnderCursor() end, desc = " Open issue under cursor" },

                { "<leader>uc", function() require("tinygit").undoLastCommitOrAmend() end, desc = "󰊢 Undo last commit/amend" },
                -- stylua: ignore end
        },

        opts   = {
                stage      = {
                        moveToNextHunkOnStagingToggle = true,
                },

                commit     = {
                        keepAbortedMsgSecs = 60 * 10,  -- 10 mins
                        border             = vim.g.borderStyle,
                        spellcheck         = true,
                        subject            = {
                                noSentenceCase = true,
                                enforceType    = true,
                                -- stylua: ignore
                                types          = { -- add `improv`
                                        "fix", "feat", "chore", "docs", "refactor", "build", "test",
                                        "perf", "style", "revert", "ci", "break", "improv"
                                },
                        },
                },

                push       = {
                        openReferencedIssues = true,
                },

                history    = {
                        autoUnshallowIfNeeded = true,
                        diffPopup             = {
                                width  = 0.9,
                                height = 0.9,
                                border = vim.g.borderStyle,
                        },
                },

                statusline = {
                        blame = {
                                hideAuthorNames = { "Chris Grieser", "chrisgrieser" },
                                ignoreAuthors   = { "🤖 automated" },
                                maxMsgLen       = 55,
                        },
                },
        },

        config = function(_, opts)
                require("tinygit").setup(opts)
        end,
}
