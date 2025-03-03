_G.dd = function(...)
        Snacks.debug.inspect(...)
end
_G.bt = function()
        Snacks.debug.backtrace()
end
vim.print = _G.dd

-- FIX broken `:Inspect` https://github.com/neovim/neovim/issues/31675
-- can be removed on the version after 0.10.3
vim.hl = vim.highlight

--------------------------------------------------------------------------------

if vim.env.PROF then
        local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
        vim.opt.rtp:append(snacks)
        require("snacks.profiler").startup({
                startup = {
                        event = "VimEnter",
                        -- event = "UIEnter",
                        -- event = "VeryLazy",
                },
        })
end
--------------------------------------------------------------------------------

-- CONFIG
vim.g.mapleader      = " "
vim.g.maplocalleader = "<Nop>"  -- disable `\` being default local leader
-- vim.g.borderStyle    = NONE
vim.g.localRepos     = vim.fs.normalize("~/Documents/Code/")

--------------------------------------------------------------------------------

---@param module string
local function safeRequire(module)
        local success, errmsg = pcall(require, module)
        if not success then
                local msg = ("Error loading `%s`: %s"):format(module, errmsg)
                vim.defer_fn(function() vim.notify(msg, vim.log.levels.ERROR) end, 1000)
        end
end

safeRequire("core.options")

if not vim.env.NO_PLUGINS then
        -- INFO only load plugins when `NO_PLUGINS` is not set.
        -- This is for security reasons, e.g., when editing a password with `pass`.
        safeRequire("core.lazy")
        if vim.g.setColorscheme then vim.g.setColorscheme("init") end
end

safeRequire("core.autocmds")
safeRequire("core.diagnostics")
safeRequire("core.keymaps")
safeRequire("core.yank-paste")
safeRequire("core.highlights")

-- lazy-load spellfixes
vim.api.nvim_create_autocmd("InsertEnter", {
        desc     = "User (once): Load spellfixes",
        once     = true,
        callback = function() safeRequire("core.spellfixes") end,
})
