local M = {}
--------------------------------------------------------------------------------

---1. start/stop with just one keypress
---2. add notification & sound for recording
---@param toggleKey string key used to trigger this function
---@param reg string vim register (single letter)
function M.startOrStopRecording(toggleKey, reg)
    if not reg:find("^%l$") then
        vim.notify("Invalid register: " .. reg, vim.log.levels.ERROR)
        return
    end
    local notRecording = vim.fn.reg_recording() == ""
    if notRecording then
        vim.cmd.normal { "q" .. reg, bang = true }
    else
        vim.cmd.normal { "q", bang = true }
        local macro = vim.fn.getreg(reg):sub(1, -(#toggleKey + 1)) -- as the key itself is recorded
        if macro ~= "" then
            vim.fn.setreg(reg, macro)
            local msg = vim.fn.keytrans(macro)
            vim.notify(msg, vim.log.levels.TRACE, { title = "Recorded", icon = "󰕧" })
        else
            vim.notify("Aborted.", vim.log.levels.TRACE, { title = "Recording", icon = "󰕧" })
        end
    end
    -- sound if on macOS
    if jit.os == "OSX" then
        local sound = "/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/system/"
            .. (notRecording and "begin_record.caf" or "end_record.caf")
        vim.system { "afplay", sound }
    end
end

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
return M
