local M = {}
--------------------------------------------------------------------------------

---1. start/stop with just one keypress
---2. add notification & sound for recording
---@param toggleKey string key used to trigger this function
---@param reg string vim register (single letter)
function M.startOrStopRecording(toggleKey, reg)
        local notRecording = vim.fn.reg_recording() == ""

        if notRecording then
                vim.cmd.normal { "q" .. reg, bang = true }
        else
                vim.cmd.normal { "q", bang = true }
                local macro = vim.fn.getreg(reg):sub(1, -(#toggleKey + 1)) -- as the key itself is recorded
                if macro ~= "" then
                        vim.fn.setreg(reg, macro)
                        local msg = vim.fn.keytrans(macro)
                        vim.notify(msg, vim.log.levels.TRACE, { title = "Recorded", icon = "󰃽" })
                else
                        vim.notify("Aborted.", vim.log.levels.TRACE, { title = "Recording", icon = "󰜺" })
                end
        end
        -- sound if on macOS
        if jit.os == "OSX" then
                local sound =
                    "/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/system/"
                    .. (notRecording and "begin_record.caf" or "end_record.caf")
                vim.system { "afplay", sound } -- async
        end
end

function M.editMacro(reg)
        local macroContent = vim.fn.getreg(reg)
        local title = ("Edit macro [%s]"):format(reg)
        local icon = "󰃽"

        vim.ui.input({ prompt = icon .. " " .. title, default = macroContent }, function(input)
                if not input then return end
                vim.fn.setreg(reg, input)
                vim.notify(input, nil, { title = title, icon = icon })
        end)
end

--------------------------------------------------------------------------------

-- Simplified implementation of coerce.nvim
function M.camelSnakeToggle()
        local cword = vim.fn.expand("<cword>")
        local newWord
        local snakePattern = "_(%w)"
        local camelPattern = "([%l%d])(%u)"

        if cword:find(snakePattern) then
                newWord = cword:gsub(snakePattern, function(capture) return capture:upper() end)
        elseif cword:find(camelPattern) then
                newWord = cword:gsub(camelPattern, function(c1, c2) return c1 .. "_" .. c2:lower() end)
        else
                vim.notify("Neither a snake_case nor camelCase", vim.log.levels.WARN)
                return
        end

        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2] + 1
        local start, ending
        while true do
                start, ending = line:find(cword, ending or 1, true)
                if start <= col and ending >= col then break end
        end
        local newLine = line:sub(1, start - 1) .. newWord .. line:sub(ending + 1)
        vim.api.nvim_set_current_line(newLine)
end

-- UPPER -> lower -> Title -> UPPER -> …
function M.toggleWordCasing()
        local prevCursor = vim.api.nvim_win_get_cursor(0)

        local cword = vim.fn.expand("<cword>")
        local cmd
        if cword == cword:upper() then
                cmd = "guiw"
        elseif cword == cword:lower() then
                cmd = "guiwgUl"
        else
                cmd = "gUiw"
        end

        vim.cmd.normal { cmd, bang = true }
        vim.api.nvim_win_set_cursor(0, prevCursor)
end

--------------------------------------------------------------------------------

-- Simplified implementation of `coerce.nvim`
function M.camelSnakeLspRename()
        local cword = vim.fn.expand("<cword>")
        local snakePattern = "_(%w)"
        local camelPattern = "([%l%d])(%u)"

        if cword:find(snakePattern) then
                local camelCased = cword:gsub(snakePattern, function(c1) return c1:upper() end)
                vim.lsp.buf.rename(camelCased)
        elseif cword:find(camelPattern) then
                local snake_cased = cword
                    :gsub(camelPattern, function(c1, c2) return c1 .. "_" .. c2 end)
                    :lower()
                vim.lsp.buf.rename(snake_cased)
        else
                local msg = "Neither snake_case nor camelCase: " .. cword
                vim.notify(msg, vim.log.levels.WARN, { title = "LSP Rename" })
        end
end

function M.toggleTitleCase()
        local prevCursor = vim.api.nvim_win_get_cursor(0)
        local cword = vim.fn.expand("<cword>")
        local cmd = cword == cword:lower() and "guiwgUl" or "guiw"
        vim.cmd.normal { cmd, bang = true }
        vim.api.nvim_win_set_cursor(0, prevCursor)
end

--------------------------------------------------------------------------------

function M.smartDuplicate()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line = vim.api.nvim_get_current_line()

        -- FILETYPE-SPECIFIC TWEAKS
        if vim.bo.ft == "css" then
                local newLine = line
                if line:find("top:") then newLine = line:gsub("top:", "bottom:") end
                if line:find("bottom:") then newLine = line:gsub("bottom:", "top:") end
                if line:find("right:") then newLine = line:gsub("right:", "left:") end
                if line:find("left:") then newLine = line:gsub("left:", "right:") end
                line = newLine
        elseif vim.bo.ft == "javascript" or vim.bo.ft == "typescript" then
                line = line:gsub("^(%s*)if(.+{)$", "%1} else if%2")
        elseif vim.bo.ft == "lua" then
                line = line:gsub("^(%s*)if( .* then)$", "%1elseif%2")
        elseif vim.bo.ft == "zsh" or vim.bo.ft == "bash" then
                line = line:gsub("^(%s*)if( .* then)$", "%1elif%2")
        elseif vim.bo.ft == "python" then
                line = line:gsub("^(%s*)if( .*:)$", "%1elif%2")
        end

        -- INSERT DUPLICATED LINE
        vim.api.nvim_buf_set_lines(0, row, row, false, { line })

        -- MOVE CURSOR DOWN, AND TO VALUE/FIELD (IF EXISTS)
        local _, luadocFieldPos = line:find("%-%-%-@%w+ ")
        local _, valuePos       = line:find("[:=][:=]? ")
        local targetCol         = luadocFieldPos or valuePos or col
        vim.api.nvim_win_set_cursor(0, { row + 1, targetCol })
end

--------------------------------------------------------------------------------

-- `fF` work with `nN` instead of `;,` (inspired by tT.nvim)
---@param char "f"|"F"
function M.fF(char)
        local target  = vim.fn.getcharstr() -- awaits user input for a char
        local pattern = [[\V\C]] .. target
        vim.fn.setreg("/", pattern)
        vim.fn.search(pattern, char == "f" and "" or "b") -- move cursor
        vim.v.searchforward = 1                           -- `n` always forward, `N` always backward
end

--------------------------------------------------------------------------------

function M.formatWithFallback()
        local formattingLsps = vim.lsp.get_clients { method = "textDocument/formatting", bufnr = 0 }

        if #formattingLsps > 0 then
                -- save for efm-formatters that don't use stdin
                if vim.bo.ft == "markdown" then
                        -- saving with explicit name prevents issues when changing `cwd`
                        -- `:update!` suppresses "The file has been changed since reading it!!!"
                        local vimCmd = ("silent update! %q"):format(vim.api.nvim_buf_get_name(0))
                        vim.cmd(vimCmd)
                end
                vim.lsp.buf.format()
        else
                vim.cmd([[% substitute_\s\+$__e]])            -- remove trailing spaces
                vim.cmd([[% substitute _\(\n\n\)\n\+_\1_e]])  -- remove duplicate blank lines
                vim.cmd([[silent! /^\%(\n*.\)\@!/,$ delete]]) -- remove blanks at end of file
        end
end

--------------------------------------------------------------------------------
return M
