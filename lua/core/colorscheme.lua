local status, _ = pcall(vim.cmd, "colorscheme kanagawa-dragon")
if not status then
    print("colorscheme not found!")
    return
end

