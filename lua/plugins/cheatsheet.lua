local cheatsheet_status, cheatsheet = pcall(require, "cheatsheet")


if not cheatsheet_status then
    return
end

cheatsheet.setup()
