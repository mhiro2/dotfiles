local keymap = vim.keymap.set

-- Move cursor by display line.
vim.keymap.set({ "n", "v" }, "j", "gj", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "k", "gk", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "gj", "j", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "gk", "k", { noremap = true, silent = true })

-- <C-a>, A: move to head.
keymap({ "n", "i", "c" }, "<C-a>", "<Home>", { noremap = true, silent = true })

-- <C-e>, E: move to end.
keymap({ "n", "i", "c" }, "<C-e>", "<End>", { noremap = true, silent = true })

-- <C-p>: previous history.
keymap("c", "<C-p>", "<Up>", { noremap = true, silent = true })

-- <C-n>: next history.
keymap("c", "<C-n>", "<Down>", { noremap = true, silent = true })

-- Move window.
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Centering search result and open fold.
keymap("n", "n", "nzzzv", { noremap = true, silent = true })
keymap("n", "N", "Nzzzv", { noremap = true, silent = true })
keymap("n", "*", "*zzzv", { noremap = true, silent = true })
keymap("n", "#", "#zzzv", { noremap = true, silent = true })
keymap("n", "g*", "g*zzzv", { noremap = true, silent = true })
keymap("n", "g#", "g#zzzv", { noremap = true, silent = true })

-- Clear highlight.
keymap("n", "<Esc><Esc>", ":set nohlsearch<CR>", { noremap = true, silent = true })

-- Disable "ZZ".
keymap("n", "ZZ", "<Nop>", { noremap = true, silent = true })

-- Swap ";" to ":".
keymap("n", ";", ":", { noremap = true })
keymap("n", ":", ";", { noremap = true })

-- Easy escape.
keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
keymap("c", "jj", "<BS><C-c>", { noremap = true, silent = true })
keymap({ "i", "c" }, "j<Space>", "j", { noremap = true, silent = true })

-- Select to end of line in visual mode.
keymap("v", "v", "$h", { noremap = true, silent = true })

-- Continuous indent block in visualmode
keymap("v", "<", "<gv", { noremap = true, silent = true })
keymap("v", ">", ">gv", { noremap = true, silent = true })
keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })
keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Yank to end of line.
keymap("n", "Y", "y$", { noremap = true, silent = true })

-- Don't store register.
keymap("n", "x", '"_x', { noremap = true, silent = true })
