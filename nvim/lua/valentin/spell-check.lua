
---@diagnostic disable: undefined-global

vim.api.nvim_create_user_command("SpellCheckDir", function()
    local cwd = vim.fn.getcwd()

    local allowed_extensions = {
        txt = true,
        md = true,
        tex = true,
        typ = true,
        html = true,
    }

    local items = {}

    for name, typ in vim.fs.dir(cwd) do
        if typ == "file" then
            local ext = name:match("%.([^%.]+)$")

            if ext and allowed_extensions[ext:lower()] then
                local path = vim.fs.joinpath(cwd, name)
                local lines = vim.fn.readfile(path)

                for lnum, line in ipairs(lines) do
                    local col = 1

                    while col <= #line do
                        local result =
                            vim.fn.spellbadword(line:sub(col))

                        local word = result[1]
                        local kind = result[2]

                        if word == "" then
                            break
                        end

                        local start_col = line:find(word, col, true)

                        if not start_col then
                            break
                        end

                        table.insert(items, {
                            filename = path,
                            lnum = lnum,
                            col = start_col,
                            text = word .. " [" .. kind .. "]",
                        })

                        col = start_col + #word
                    end
                end
            end
        end
    end

    vim.fn.setqflist({}, "r", {
        title = "Spelling mistakes: " .. cwd,
        items = items,
    })

    vim.cmd("copen")

    vim.notify(
        string.format("Found %d spelling mistakes", #items),
        vim.log.levels.INFO
    )
end, {
    desc = "Spell check whitelisted files in current directory",
})

