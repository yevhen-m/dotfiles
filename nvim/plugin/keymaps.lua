-- Visual mode: moving lines
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Paste and keep pasting same thing
vim.keymap.set("v", "gp", '"_dP')

-- Delete to the end of the line in insert mode
vim.keymap.set("i", "<C-k>", "<C-o>D")

-- Change record/replay for macros
vim.keymap.set("n", "q", "<cmd>lclose<bar>close<cr>")
vim.keymap.set("n", "Q", "q")

-- Quit all
vim.keymap.set("n", "<leader>qq", "<cmd>:xa<cr>")

-- Move in insert mode
vim.keymap.set("i", "<A-j>", "<Down>")
vim.keymap.set("i", "<A-k>", "<Up>")

-- Switch buffers
vim.keymap.set("n", "H", "<cmd>bprev<CR>")
vim.keymap.set("n", "L", "<cmd>bnext<CR>")

-- Delete buffers
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>")
vim.keymap.set("n", "<leader>bD", "<cmd>bdelete!<CR>")

-- Use backslash to jump to the previous match
vim.keymap.set("n", "\\", ",")
--  See `:help vim.keymap.set()`
vim.keymap.set("n", "<leader><leader>", "<cmd>update<CR>")

-- Map U for undos
vim.keymap.set("n", "U", "<C-r>")

-- Location and quickfix lists
vim.keymap.set("n", "<leader>xl", "<cmd>copen<CR>")

vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>")
vim.keymap.set("n", "<leader>xl", "<cmd>lopen<CR>")

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Space>", "<cmd>nohlsearch<CR>")
vim.keymap.set({ "n", "i" }, "<Esc>", "<Esc><cmd>nohlsearch<CR>l")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize windows
vim.keymap.set("n", "<C-Up>", "<cmd>resize +5<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -5<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +5<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -5<CR>", { desc = "Decreasee window width" })

-- Add empty lines below / above the cursor
vim.keymap.set("n", "[<Space>", "<cmd>call append(line('.') - 1, '')<CR>")
vim.keymap.set("n", "]<Space>", "<cmd>call append(line('.'), '')<CR>")

-- Split windows
vim.keymap.set("n", "<C-w>-", "<C-w>s")
vim.keymap.set("n", "<C-w><C-->", "<C-w>s")
vim.keymap.set("n", '<C-w>"', "<C-w>s")
vim.keymap.set("n", '<C-w><C-">', "<C-w>s")
vim.keymap.set("n", "<C-w>\\", "<C-w>v")
vim.keymap.set("n", "<C-w><C-\\>", "<C-w>v")
vim.keymap.set("n", "<C-w>'", "<C-w>v")
vim.keymap.set("n", "<C-w><C-'>", "<C-w>v")

-- Tabs
vim.keymap.set("n", "<leader><C-i><C-i>", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader><C-i>f", "<cmd>tabfirst<CR>")
vim.keymap.set("n", "<leader><C-i>l", "<cmd>tablast<CR>")
vim.keymap.set("n", "<leader><C-i>]", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<leader><C-i>[", "<cmd>tabprev<CR>")
vim.keymap.set("n", "<leader><C-i>d", "<cmd>tabclose<CR>")
