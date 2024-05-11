local function call_with_saved_cursor(func)
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	func()
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end

local function trim_whitespace()
	call_with_saved_cursor(function()
		vim.cmd([[%s/\s\+$//e]])
	end)
end

local function delete_trailing_blank_lines()
	call_with_saved_cursor(function()
		vim.cmd([[silent! %s/\(\n\s*\)\+\%$//e]])
	end)
end

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Trim empty trailing lines and whitespace",
	group = vim.api.nvim_create_augroup("trim_and_clean", { clear = true }),
	pattern = "*",
	callback = function()
		trim_whitespace()
		delete_trailing_blank_lines()
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 300 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Move the cursor to the last change in the file",
	group = vim.api.nvim_create_augroup("last_location", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
