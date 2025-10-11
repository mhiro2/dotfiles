-----------------------------------
-- Basic
-----------------------------------

vim.scriptencoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Don't create backup.
vim.opt.backup = false
vim.opt.writebackup = false

-- Don't create swap file.
vim.opt.swapfile = false

-- Auto reload when changed by external.
vim.opt.autoread = true

-- Display another buffer when current buffer isn't saved.
vim.opt.hidden = true

-- The number of milliseconds between stop typing and trigger CursorHold event. (default: 4000)
vim.opt.updatetime = 300

-- Disable bell.
vim.opt.visualbell = false

-- Free move in Visual mode blockwise.
vim.opt.virtualedit = "block"

-- Wrap conditions.
vim.opt.whichwrap = "b,s,<,>,[,]"

-- Highlight limit column for specific languages.
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "c", "cpp", "python" },
  callback = function()
    vim.opt_local.textwidth = 99
    vim.opt_local.colorcolumn = "+1"
  end,
})

-- Splitting a window will put the new window below the current one.
vim.opt.splitbelow = true
-- Splitting a window will put the new window right the current one.
vim.opt.splitright = true
-- Set minimal width for current window.
vim.opt.winwidth = 30
-- Set height of command line.
vim.opt.cmdheight = 0
-- Set maximam command line window.
vim.opt.cmdwinheight = 5
-- Adjust window size of preview and help.
vim.opt.previewheight = 8
vim.opt.helpheight = 12

-----------------------------------
-- Search
-----------------------------------

-- Searches wrap around the end of the file.
vim.opt.wrapscan = true

-- Enable incremental search.
vim.opt.incsearch = true

-- Ignore the case of normal letters.
vim.opt.ignorecase = true

-- If the search pattern contains upper case characters, override ignorecase option.
vim.opt.smartcase = true

-- Highlight search result.
vim.opt.hlsearch = true

-----------------------------------
-- Edit
-----------------------------------

-- Smart insert tab setting.
vim.opt.smarttab = true

-- Exchange tab to spaces.
vim.opt.expandtab = true

-- Enable break indent.
vim.opt.breakindent = true

-- Auto copy selected text to system clipboard.
vim.opt.clipboard = "unnamedplus"

-- Enable backspace delete indent and newline.
vim.opt.backspace = "indent,eol,start"

-- Enable modeline.
vim.opt.modeline = true

-- Ignore case on insert completion.
vim.opt.infercase = true

-- Disable automatically insert comment.
vim.opt.formatoptions:remove({ "r", "o" })
vim.opt.formatoptions:append({ "m", "M" })

-----------------------------------
-- Indent
-----------------------------------

-- Enable smart indent.
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Substitute <Tab> with blanks.
vim.opt.tabstop = 2
-- Spaces instead <Tab>.
vim.opt.softtabstop = 2
-- Autoindent width.
vim.opt.shiftwidth = 2

-- Round indent by shiftwidth.
vim.opt.shiftround = true

-----------------------------------
-- Appearance
-----------------------------------

-- Change colorscheme.
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.g.sonokai_style = "default"
vim.cmd("colorscheme sonokai")
vim.g.sonokai_better_performance = 1
vim.api.nvim_set_hl(0, "MatchParen", { fg = "white", bg = "#f85e84", bold = true })
vim.api.nvim_set_hl(0, "MatchParenCur", { fg = "#161821", bg = "#f85e84", bold = true })
vim.api.nvim_set_hl(0, "MatchWord", { bg = "#3b465b", bold = true, underline = true })
vim.api.nvim_set_hl(0, "MatchWordCur", { bg = "#46516a", bold = true, underline = true })

-- Enable syntax color.
vim.cmd("syntax enable")

-- Show title.
vim.opt.title = true
-- Show line number.
vim.opt.number = true
-- Always show the signcolumn.
vim.opt.signcolumn = "yes"
-- Show the line and column number of the cursor position.
vim.opt.ruler = true
-- Always display a status line at the bottom of the window.
vim.opt.laststatus = 3
-- Highlight Cursour Line
vim.opt.cursorline = true
-- Show command on statusline.
vim.opt.showcmd = false
-- Highlight parenthesis.
vim.opt.showmatch = true
-- Highlight a pair of < and >.
vim.opt.matchpairs:append("<:>")
-- Control cursor movement.
vim.opt.matchtime = 0

-- Enhanced mode.
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"

-- Display invisible characters.
vim.opt.list = true
vim.opt.listchars = {
  tab = "»-",
  trail = "-",
  extends = "»",
  precedes = "«",
  nbsp = "%",
  eol = "↲",
}
