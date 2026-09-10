local opts = {
	shiftwidth = 4,
    tabstop = 4,
	expandtab = true,
	wrap = false,
	termguicolors = true,
	number = true,
	relativenumber = true,
    ignorecase = true,
    smartcase = true,
    cursorline = true,
    swapfile = true,
    signcolumn = "yes" -- always show the sign column so text doesn't shift
}

-- Set options from table
for opt, val in pairs(opts) do
	vim.o[opt] = val
end

-- Set colorscheme, fall back to default if it's not installed yet
if not pcall(vim.cmd.colorscheme, "kanagawa-dragon") then
	vim.cmd.colorscheme("default")
end

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)
