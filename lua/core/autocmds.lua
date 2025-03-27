--------------------------------------------------------------------------------
-- AUTO-CD TO PROJECT ROOT

local autoCdConfig = {
        childOfRoot = {
                ".git",
                "Justfile",
                "info.plist",
                "biome.jsonc",
        },
        parentOfRoot = {
                ".config",
                "com~apple~CloudDocs",
                vim.fs.basename(vim.env.HOME),
                "Cellar",
        },
}
vim.api.nvim_create_autocmd("BufEnter", {
        desc     = "User: Auto-cd to project root",
        callback = function(ctx)
                local root = vim.fs.root(ctx.buf, function(name, path)
                        local parentName         = vim.fs.basename(vim.fs.dirname(path))
                        local dirHasParentMarker = vim.tbl_contains(autoCdConfig.parentOfRoot, parentName)
                        local dirHasChildMarker  = vim.tbl_contains(autoCdConfig.childOfRoot, name)
                        return dirHasChildMarker or dirHasParentMarker
                end)
                if root and root ~= "" then vim.uv.chdir(root) end
        end,
})

--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("FocusGained", {
        desc     = "User: FIX `cwd` being not available when it is deleted outside nvim.",
        callback = function()
                if not vim.uv.cwd() then vim.uv.chdir("/") end
        end,
})

vim.api.nvim_create_autocmd("FocusGained", {
        desc     = "User: Close all non-existing buffers on `FocusGained`.",
        callback = function()
                local closedBuffers = {}
                local allBufs       = vim.fn.getbufinfo { buflisted = 1 }
                vim.iter(allBufs):each(function(buf)
                        if not vim.api.nvim_buf_is_valid(buf.bufnr) then return end
                        local stillExists   = vim.uv.fs_stat(buf.name) ~= nil
                        local specialBuffer = vim.bo[buf.bufnr].buftype ~= ""
                        local newBuffer     = buf.name == ""
                        if stillExists or specialBuffer or newBuffer then return end
                        table.insert(closedBuffers, vim.fs.basename(buf.name))
                        vim.api.nvim_buf_delete(buf.bufnr, { force = false })
                end)
                if #closedBuffers == 0 then return end

                if #closedBuffers == 1 then
                        vim.notify(closedBuffers[1], nil, { title = "Buffer closed", icon = "󰅗" })
                else
                        local text = "- " .. table.concat(closedBuffers, "\n- ")
                        vim.notify(text, nil, { title = "Buffers closed", icon = "󰅗" })
                end

                -- If ending up in empty buffer, re-open the first oldfile that exists
                vim.defer_fn(function()
                        if vim.api.nvim_buf_get_name(0) ~= "" then return end
                        for _, file in ipairs(vim.v.oldfiles) do
                                if vim.uv.fs_stat(file) and vim.fs.basename(file) ~= "COMMIT_EDITMSG" then
                                        vim.cmd.edit(file)
                                        return
                                end
                        end
                end, 1)
        end,
})

--------------------------------------------------------------------------------
-- AUTO-NOHL & INLINE SEARCH COUNT

---@param mode? "clear"
local function searchCountIndicator(mode)
        local signColumnPlusScrollbarWidth = 2 + 3

        local countNs                      = vim.api.nvim_create_namespace("searchCounter")
        vim.api.nvim_buf_clear_namespace(0, countNs, 0, -1)
        if mode == "clear" then return end

        local row   = vim.api.nvim_win_get_cursor(0)[1]
        local count = vim.fn.searchcount()
        if count.total == 0 then return end
        local text     = (" %d/%d "):format(count.current, count.total)
        local line     = vim.api.nvim_get_current_line():gsub("\t", (" "):rep(vim.bo.shiftwidth))
        local lineFull = #line + signColumnPlusScrollbarWidth >= vim.api.nvim_win_get_width(0)
        local margin   = { (" "):rep(lineFull and signColumnPlusScrollbarWidth or 0) }

        vim.api.nvim_buf_set_extmark(0, countNs, row - 1, 0, {
                virt_text     = { { text, "IncSearch" }, margin },
                virt_text_pos = lineFull and "right_align" or "eol",
                priority      = 200,
        })
end

-- without the `searchCountIndicator`, this `on_key` simply does `auto-nohl`
vim.on_key(function(key, _typed)
        key                   = vim.fn.keytrans(key)
        local isCmdlineSearch = vim.fn.getcmdtype():find("[/?]") ~= nil
        local isNormalMode    = vim.api.nvim_get_mode().mode == "n"
        local searchStarted   = (key == "/" or key == "?") and isNormalMode
        local searchConfirmed = (key == "<CR>" and isCmdlineSearch)
        local searchCancelled = (key == "<Esc>" and isCmdlineSearch)
        if not (searchStarted or searchConfirmed or searchCancelled or isNormalMode) then return end

        -- works for RHS, therefore no need to consider remaps
        local searchMovement = vim.tbl_contains({ "n", "N", "*", "#" }, key)
        local shortPattern   = vim.fn.getreg("/"):gsub([[\V\C]], ""):len() <= 1 -- for `fF` function

        if searchCancelled or (not searchMovement and not searchConfirmed) then
                vim.opt.hlsearch = false
                searchCountIndicator("clear")
        elseif (searchMovement and not shortPattern) or searchConfirmed or searchStarted then
                vim.opt.hlsearch = true
                vim.defer_fn(searchCountIndicator, 1)
        end
end, vim.api.nvim_create_namespace("autoNohlAndSearchCount"))

--------------------------------------------------------------------------------
-- SKELETONS (TEMPLATES)

-- CONFIG
local templateDir = vim.fn.stdpath("config") .. "/templates"
local globToTemplateMap = {
        [vim.g.localRepos .. "/**/*.lua"]                    = "module.lua",
        [vim.fn.stdpath("config") .. "/lua/functions/*.lua"] = "module.lua",
        [vim.fn.stdpath("config") .. "/lua/plugins/*.lua"]   = "plugin-spec.lua",
        [vim.fn.stdpath("config") .. "/lsp/*.lua"]           = "lsp.lua",

        -- ["**/*.py"]                                          = "template.py",
        ["**/*.sh"]                                          = "template.zsh",
        ["**/*.*sh"]                                         = "template.zsh",
}

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
        desc     = "User: Apply templates (`BufReadPost` for files created outside of nvim.)",
        callback = function(ctx)
                vim.defer_fn(function()                                 -- defer, to ensure new files are written
                        local stats = vim.uv.fs_stat(ctx.file)
                        if not stats or stats.size > 10 then return end -- 10 bytes for file metadata
                        local filepath, bufnr = ctx.file, ctx.buf

                        -- determine template from glob
                        local matchedGlob = vim.iter(globToTemplateMap):find(function(glob)
                                local globMatchesFilename = vim.glob.to_lpeg(glob):match(filepath)
                                return globMatchesFilename
                        end)
                        if not matchedGlob then return end
                        local templateFile = globToTemplateMap[matchedGlob]
                        local templatePath = vim.fs.normalize(templateDir .. "/" .. templateFile)
                        if not vim.uv.fs_stat(templatePath) then return end

                        -- read template & move to cursor placeholder
                        local content = {}
                        local cursor
                        local row = 1
                        for line in io.lines(templatePath) do
                                local placeholderPos = line:find("%$0")
                                if placeholderPos then
                                        line = line:gsub("%$0", "")
                                        cursor = { row, placeholderPos - 1 }
                                end
                                table.insert(content, line)
                                row = row + 1
                        end
                        vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
                        if cursor then vim.api.nvim_win_set_cursor(0, cursor) end

                        -- adjust filetype if needed (e.g. when applying a zsh template to .sh files)
                        local newFt = vim.filetype.match { buf = bufnr }
                        if vim.bo[bufnr].ft ~= newFt then vim.bo[bufnr].ft = newFt end
                end, 100)
        end,
})

--------------------------------------------------------------------------------
-- ENFORCE SCROLLOFF AT EOF

vim.api.nvim_create_autocmd("CursorMoved", {
        desc     = "User: Enforce scrolloff at EoF",
        callback = function(ctx)
                if vim.bo[ctx.buf].buftype ~= "" then return end

                local winHeight           = vim.api.nvim_win_get_height(0)
                local visualDistanceToEof = winHeight - vim.fn.winline()
                local scrolloff           = math.min(vim.o.scrolloff, math.floor(winHeight / 2))

                if visualDistanceToEof < scrolloff then
                        local topline = vim.fn.winsaveview().topline
                        -- topline is inaccurate if it is a folded line, thus add number of folded lines
                        local toplineFoldAmount = vim.fn.foldclosedend(topline) - vim.fn.foldclosed(topline)
                        topline = topline + toplineFoldAmount
                        vim.fn.winrestview { topline = topline + scrolloff - visualDistanceToEof }
                end
        end,
})

-- FIX for some reason `scrolloff` sometimes being set to `0` on new buffers
local originalScrolloff = vim.o.scrolloff
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNew" }, {
        desc     = "User: FIX scrolloff on entering new buffer",
        callback = function(ctx)
                vim.defer_fn(function()
                        if not vim.api.nvim_buf_is_valid(ctx.buf) or vim.bo[ctx.buf].buftype ~= "" then return end
                        if vim.o.scrolloff == 0 then
                                vim.o.scrolloff = originalScrolloff
                                vim.notify("Triggered by [" .. ctx.event .. "]", nil, { title = "Scrolloff fix" })
                        end
                end, 150)
        end,
})
