local M = {}

function M.insert_below_cursor()
    vim.ui.input({ prompt = "llm prompt: " }, function(input)
        if not input or input == "" then return end

        local row = vim.api.nvim_win_get_cursor(0)[1]
        local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false);
        table.insert(buffer_lines, row + 1, "<<<INSERT HERE>>>")

        local system = input ..
            "Output code in a markdown code block. " ..
            "Follow this prompt exactly, do not add anything extra." ..
            "The code you output will be inserted at <<<INSERT HERE>>>. " ..
            "Do not rewrite any existing lines. "

        vim.system({ "llm", "-s", system, "-x" }, { stdin = table.concat(buffer_lines, "\n"), text = true },
            function(obj)
                vim.schedule(function()
                    if obj.code == 0 then
                        local output_lines = vim.split(obj.stdout:gsub("\n+$", ""), "\n", { plain = true })
                        vim.api.nvim_buf_set_lines(0, row, row, false, output_lines)
                        vim.notify("llm successful")
                    else
                        vim.notify("llm failed: " .. (obj.stderr or ""), vim.log.levels.ERROR)
                    end
                end)
            end)
    end)
end


function M.edit_selection()
    vim.ui.input({ prompt = "llm prompt: " }, function(input)
        if not input or input == "" then return end

        local s_row = vim.fn.line("v")
        local e_row = vim.fn.line(".")
        if s_row > e_row then s_row, e_row = e_row, s_row end

        local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        table.insert(buffer_lines, e_row + 1, "<<<EDIT END>>>")
        table.insert(buffer_lines, s_row, "<<<EDIT START>>>")

        -- deselect lines
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "n", false)

        local system = input ..
            "Output code in a markdown code block. " ..
            "Follow this prompt exactly, do not add anything extra. " ..
            "The code you output will replace the region between <<<EDIT START>>> and <<<EDIT END>>>. " ..
            "Do not rewrite any existing lines outside of this region."

        vim.system({ "llm", "-s", system, "-x" }, { stdin = table.concat(buffer_lines, "\n"), text = true },
            function(obj)
                vim.schedule(function()
                    if obj.code == 0 then
                        local output_lines = vim.split(obj.stdout:gsub("\n+$", ""), "\n", { plain = true })
                        vim.api.nvim_buf_set_lines(0, s_row - 1, e_row, false, output_lines)
                        vim.notify("llm successful")
                    else
                        vim.notify("llm failed", vim.log.levels.ERROR)
                    end
                end)
            end)
    end)
end

return M
