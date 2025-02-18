-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.hlsearch = true

-- Disable intro message
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Make line numbers default
vim.opt.number = true
vim.opt.numberwidth = 2
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Pause on long listings
vim.opt.more = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "auto"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
-- tab:\⋮\ ,extends:❯,precedes:❮,trail:·
vim.opt.listchars = { tab = "⋮ ", trail = "·", nbsp = "␣", extends = "❯", precedes = "❮" }
vim.opt.showbreak = "↪ "
vim.opt.linebreak = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

vim.opt.autowriteall = true
vim.opt.fileignorecase = true
vim.opt.swapfile = false
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.pumblend = 10

vim.opt.shiftround = true
vim.opt.shiftwidth = 2

vim.opt.wildmode = "longest:full,full"

vim.opt.winheight = 5
vim.opt.winminheight = 5

vim.opt.foldcolumn = '1'
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
