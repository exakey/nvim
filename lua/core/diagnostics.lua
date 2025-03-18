-- HANDLERS

-- `vim.lsp.buf.rename`: add notification & writeall to renaming
local originalRenameHandler = vim.lsp.handlers["textDocument/rename"]
vim.lsp.handlers["textDocument/rename"] = function(err, result, ctx, config)
	originalRenameHandler(err, result, ctx, config)
	if err or not result then return end

	-- count changes
	local changes = result.changes or result.documentChanges or {}
	local changedFiles = vim.iter(vim.tbl_keys(changes))
		:filter(function(file) return #changes[file] > 0 end)
		:map(function(file) return "- " .. vim.fs.basename(file) end)
		:totable()
	local changeCount = 0
	for _, change in pairs(changes) do
		changeCount = changeCount + #(change.edits or change)
	end

	-- notification
	local pluralS = changeCount > 1 and "s" or ""
	local msg = ("[%d] instance%s"):format(changeCount, pluralS)
	if #changedFiles > 1 then
		msg = ("**%s in [%d] files**\n%s"):format(
			msg,
			#changedFiles,
			table.concat(changedFiles, "\n")
		)
	end
	vim.notify(msg, nil, { title = "Renamed with LSP", icon = "󰑕" })

	-- save all
	if #changedFiles > 1 then vim.cmd.wall() end
end

-- `vim.lsp.buf.signature_help`
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = vim.g.borderStyle,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = vim.g.borderStyle,
	title = " LSP hover ",
	max_width = 75,
})

--------------------------------------------------------------------------------
-- LSP PROGRESS

-- lightweight replacement for `fidget.nvim`
-- (uses vim.notify opts tailored to `snacks.nvim`, but should in general work
-- for other notifiers as well)
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress                          = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local value  = ev.data.params
                    .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
                if not client or type(value) ~= "table" then
                        return
                end
                local p = progress[client.id]

                for i = 1, #p + 1 do
                        if i == #p + 1 or p[i].token == ev.data.params.token then
                                p[i] = {
                                        token = ev.data.params.token,
                                        msg   = ("[%3d%%] %s%s"):format(
                                                value.kind == "end" and 100 or value.percentage or 100,
                                                value.title or "",
                                                value.message and (" **%s**"):format(value.message) or ""
                                        ),
                                        done  = value.kind == "end",
                                }
                                break
                        end
                end

                local msg = {} ---@type string[]
                progress[client.id] = vim.tbl_filter(function(v)
                        return table.insert(msg, v.msg) or not v.done
                end, p)

                local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                vim.notify(table.concat(msg, "\n"), "info", {
                        id    = "lsp_progress",
                        title = client.name,
                        opts  = function(notif)
                                notif.icon = #progress[client.id] == 0 and "■"
                                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                        end,
                })
        end,
})
--------------------------------------------------------------------------------

-- `vim.lsp.buf.signature_help()`
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = vim.g.borderStyle,
})

-- `vim.lsp.buf.hover()`
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border    = vim.g.borderStyle,
        title     = " LSP Hover ",
        max_width = 75,
})

--------------------------------------------------------------------------------

vim.api.nvim_create_user_command("LspCapabilities", function(ctx)
        local client = vim.lsp.get_clients({ name = ctx.args })[1]
        local newBuf = vim.api.nvim_create_buf(true, true)
        local info   = {
                capabilities        = client.capabilities,
                server_capabilities = client.server_capabilities,
                config              = client.config,
        }
        vim.api.nvim_buf_set_lines(newBuf, 0, -1, false, vim.split(vim.inspect(info), "\n"))
        vim.api.nvim_buf_set_name(newBuf, client.name .. " capabilities")
        vim.bo[newBuf].filetype = "lua" -- syntax highlighting
        vim.cmd.buffer(newBuf)          -- open
        vim.keymap.set("n", "q", vim.cmd.bdelete, { buffer = newBuf })
end, {
        nargs = 1,
        complete = function()
                return vim.iter(vim.lsp.get_clients { bufnr = 0 })
                    :map(function(client) return client.name end)
                    :totable()
        end,
})

--------------------------------------------------------------------------------
-- DIAGNOSTICS

local numbers = {
                text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN]  = "",
                        [vim.diagnostic.severity.INFO]  = "",
                        [vim.diagnostic.severity.HINT]  = "",
                },

                numhl = {
                        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                        [vim.diagnostic.severity.WARN]  = "WarningMsg",
                        [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
                        [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
                },
        }

local icons = {
                text = {
                        [vim.diagnostic.severity.ERROR] = "󰨓",
                        [vim.diagnostic.severity.WARN]  = "󰨓",
                        [vim.diagnostic.severity.INFO]  = "󰨓",
                        [vim.diagnostic.severity.HINT]  = "󰨓",
                },
        }

vim.diagnostic.config {
        signs            = numbers,
        jump             = { float = false },
        virtual_text     = false,
        update_in_insert = false,
        severity_sort    = true,
}
