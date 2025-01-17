local o = vim.opt

-- GENERAL

o.spelloptions:append("noplainbuffer")

o.undofile    = true
o.undolevels  = 10000
o.swapfile    = false

o.spell       = false
-- o.spellfile
o.spelllang   = "en_us"

o.splitright  = true
o.splitbelow  = true

o.cursorline  = true
-- o.colorcolumn = "+1"
o.signcolumn  = "yes:2"
-- o.signcolumn  = "yes"

o.wrap        = false
o.breakindent = true

o.shortmess:append({ W = true, I = true, c = true, C = true })
o.report = 9901

o.iskeyword:append("-")
-- o.nrformats = {}

o.autowrite     = false
o.autowriteall  = false

o.jumpoptions   = { "stack" }
o.startofline   = true

-- o.timeoutlen     = 666

o.scrolloff     = 12
o.sidescrolloff = 4

--------------------------------------------------------------------------------------------------------------------------------------------
-- EDITORCONFIG

o.textwidth     = 80

o.expandtab     = true
-- o.tabstop = 3
o.shiftwidth    = 8

o.shiftround    = true
o.smartindent   = true

--------------------------------------------------------------------------------
-- FILETYPES

vim.filetype.add {
    filename = {
        [".ignore"] = "gitignore", -- ignore files for fd/rg
    },
}

--------------------------------------------------------------------------------
-- SEARCH & CMDLINE

o.ignorecase   = true
o.smartcase    = true
o.cmdheight    = 0

--------------------------------------------------------------------------------
-- INVISIBLE CHARS

o.list         = true
o.conceallevel = 3
o.fillchars:append {
    fold      = " ",
    vert      = "▕",
    -- vert      = "█",
    -- horiz     = "▄",
    -- horizup   = "█",
    -- horizdown = "█",
    -- vertleft  = "█",
    -- vertright = "█",
    -- verthoriz = "█",
    eob       = " ",
    foldclose = "",
    foldopen  = "",
    foldsep   = " ",
    diff      = "╱",
}
vim.opt.listchars = {
    nbsp       = " ",
    precedes   = "…",
    extends    = "…",
    multispace = " ",
    lead       = " ",
    trail      = " ",
    tab        = "  ",
}

o.completeopt     = "menu,menuone,noselect"
o.conceallevel    = 0
o.confirm         = true
o.grepformat      = "%f:%l:%c:%m"
o.grepprg         = "rg --vimgrep"
o.inccommand      = "nosplit"
o.incsearch       = true
o.linebreak       = false
o.list            = true
o.mouse           = "a"
o.number          = true
o.pumblend        = 10
o.pumheight       = 20
o.relativenumber  = true
o.sessionoptions  = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
o.showmode        = false
o.termguicolors   = true
o.termsync        = true
o.updatetime      = 50
o.virtualedit     = "block"
o.wildmode        = "longest:full,full"
o.winminwidth     = 5
o.wrapmargin      = 120
o.syntax          = "on"

if vim.fn.has("nvim-0.10") == 1 then
    o.smoothscroll = true
    o.foldexpr     = "v:lua.require'lazyvim.util'.ui.foldexpr()"
    o.foldmethod   = "expr"
    o.foldtext     = ""
else
    o.foldmethod = "indent"
    o.foldtext   = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

vim.g.markdown_recommended_style = 0

vim.cmd("autocmd BufEnter * set fo-=c fo-=r fo-=o")

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
    group = vim.api.nvim_create_augroup("Color", {}),
    pattern = "*",
    callback = function() end,
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { focusable = false }
)
