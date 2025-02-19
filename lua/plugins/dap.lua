---@param dir "next"|"prev"
local function gotoBreakpoint(dir)
        local breakpoints = require("dap.breakpoints").get()
        if #breakpoints == 0 then
                vim.notify("No breakpoints set", vim.log.levels.WARN)
                return
        end
        local points = {}
        for bufnr, bpData in pairs(breakpoints) do
                for _, bp in ipairs(bpData) do
                        table.insert(points, { bufnr = bufnr, line = bp.line })
                end
        end

        local current = {
                bufnr = vim.api.nvim_get_current_buf(),
                line  = vim.api.nvim_win_get_cursor(0)[1],
        }

        local nextPoint
        for i = 1, #points do
                local isAtBreakpointI = points[i].bufnr == current.bufnr and points[i].line == current.line
                if isAtBreakpointI then
                        local nextIdx = dir == "next" and i + 1 or i - 1
                        if nextIdx > #points then nextIdx = 1 end
                        if nextIdx == 0 then nextIdx = #points end
                        nextPoint = points[nextIdx]
                        break
                end
        end
        if not nextPoint then nextPoint = points[1] end

        vim.cmd(("buffer +%d %d"):format(nextPoint.line, nextPoint.bufnr))
end

return {
        "mfussenegger/nvim-dap",
        keys   = {
                { "<f5>", function() require("dap").toggle_breakpoint() end, desc = " Toggle breakpoint" },
                { "<f6>", function() require("dap").step_over() end, desc = " Step over" },
                { "<f7>", function() require("dap").continue() end, desc = " Continue" },

                { "]b", function() gotoBreakpoint("next") end, desc = " Goto next breakpoint" },
                { "[b", function() gotoBreakpoint("prev") end, desc = " Goto previous breakpoint" },

                { "<leader>do", function() require("dap").step_out() end, desc = "󰆸 Step out" },
                { "<leader>di", function() require("dap").step_in() end, desc = "󰆹 Step in" },
                { "<leader>dc", function() require("dap").run_to_cursor() end, desc = "󰆿 Run to cursor" },
                { "<leader>dr", function() require("dap").restart() end, desc = " Restart" },
                { "<leader>dt", function() require("dap").terminate() end, desc = " Terminate" },
                -- stylua: ignore
                { "<leader>dd", function() require("dap").clear_breakpoints() end, desc = "󰅗 Delete breakpoints" },
        },
        -- init   = function() vim.g.whichkeyAddSpec { "<leader>d", group = "󰃤 Debugger" } end,
        config = function()
                -- ICONS & HIGHLIGHTS
                vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
                vim.fn.sign_define("DapBreakpointCondition", { text = "󰇽", texthl = "DiagnosticInfo" })
                vim.fn.sign_define("DapLogPoint", { text = "󰍩", texthl = "DiagnosticInfo" })
                vim.fn.sign_define("DapLogRejected", { text = "", texthl = "DiagnosticInfo" })
                vim.fn.sign_define("DapStopped", {
                        text   = "󰳟",
                        texthl = "DiagnosticHint",
                        linehl = "DiagnosticVirtualTextHint",
                        numhl  = "DiagnosticVirtualTextHint",
                })

                -- LISTENERS
                local listeners                = require("dap").listeners.after
                -- start nvim-dap-virtual-text
                listeners.attach.dapVirtText   = function()
                        local installed, dapVirtText = pcall(require, "nvim-dap-virtual-text")
                        if installed then dapVirtText.enable() end
                end
                -- enable/disable diagnostics & line numbers
                listeners.attach.dapItself     = function()
                        vim.opt.number = true
                        vim.diagnostic.enable(false)
                end
                listeners.disconnect.dapItself = function()
                        vim.opt.number = false
                        vim.diagnostic.enable(true)
                end
                local dap                      = require("dap")
                dap.adapters.nlua              = function(callback, config)
                        callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
                end

                ----------------------------------------------------------------
                -- LUA

                dap.configurations.lua         = {
                        {
                                type    = 'nlua',
                                request = 'attach',
                                name    = "Attach to running Neovim instance",
                                program = function() pcall(require "osv".launch({ port = 8086 })) end,
                        }
                }

                ----------------------------------------------------------------
                -- C

                dap.adapters.codelldb          = {
                        type       = 'server',
                        port       = "${port}",
                        executable = {
                                command  = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
                                args     = { "--port", "${port}" },
                                detached = function() if is_windows then return false else return true end end,
                        }
                }
                dap.configurations.c           = {
                        {
                                name        = 'Launch',
                                type        = 'codelldb',
                                request     = 'launch',
                                program     = function() -- Ask the user what executable wants to debug
                                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/bin/program',
                                                'file')
                                end,
                                cwd         = '${workspaceFolder}',
                                stopOnEntry = false,
                                args        = {},
                        },
                }

                ----------------------------------------------------------------
                -- C++
                dap.configurations.cpp         = dap.configurations.c

                ----------------------------------------------------------------
                -- GO

                dap.adapters.delve             = {
                        type       = 'server',
                        port       = '${port}',
                        executable = {
                                command = vim.fn.stdpath('data') .. '/mason/packages/delve/dlv',
                                args    = { 'dap', '-l', '127.0.0.1:${port}' },
                        }
                }
                dap.configurations.go          = {
                        {
                                type    = "delve",
                                name    = "Compile module and debug this file",
                                request = "launch",
                                program = "./${relativeFileDirname}",
                        },
                        {
                                type    = "delve",
                                name    = "Compile module and debug this file (test)",
                                request = "launch",
                                mode    = "test",
                                program = "./${relativeFileDirname}"
                        },
                }

                ----------------------------------------------------------------
                -- BASH
                dap.adapters.bashdb            = {
                        type    = 'executable',
                        command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
                        name    = 'bashdb',
                }
                dap.configurations.sh          = {
                        {
                                type            = 'bashdb',
                                request         = 'launch',
                                name            = "Launch file",
                                showDebugOutput = true,
                                pathBashdb      = vim.fn.stdpath("data") ..
                                    '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
                                pathBashdbLib   = vim.fn.stdpath("data") ..
                                    '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
                                trace           = true,
                                file            = "${file}",
                                program         = "${file}",
                                cwd             = '${workspaceFolder}',
                                pathCat         = "cat",
                                pathBash        = "/bin/bash",
                                pathMkfifo      = "mkfifo",
                                pathPkill       = "pkill",
                                args            = {},
                                env             = {},
                                terminalKind    = "integrated",
                        }
                }
        end,
}
