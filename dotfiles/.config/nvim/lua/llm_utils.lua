local M = {}

local function prompt_and_output_code(system, input, start_row, end_row)
    vim.system({ "llm", "-s", system, "-x" }, { stdin = input, text = true },
        function(obj)
            vim.schedule(function()
                if obj.code == 0 then
                    local output_lines = vim.split(obj.stdout:gsub("\n+$", ""), "\n", { plain = true })
                    vim.api.nvim_buf_set_lines(0, start_row, end_row, false, output_lines)
                    vim.notify("llm successful")
                else
                    vim.notify("llm failed", vim.log.levels.ERROR)
                end
            end)
        end)
end

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

        prompt_and_output_code(system, table.concat(buffer_lines, "\n"), row, row);
    end)
end

function M.edit_selection()
    vim.ui.input({ prompt = "llm prompt: " }, function(input)
        if not input or input == "" then return end

        local start_row = vim.fn.line("v")
        local end_row = vim.fn.line(".")
        if start_row > end_row then
            start_row, end_row = end_row, start_row
        end

        local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        table.insert(buffer_lines, end_row + 1, "<<<EDIT END>>>")
        table.insert(buffer_lines, start_row, "<<<EDIT START>>>")

        -- deselect lines
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "n", false)

        local system = input ..
            "Output code in a markdown code block. " ..
            "Follow this prompt exactly, do not add anything extra. " ..
            "The code you output will replace the region between <<<EDIT START>>> and <<<EDIT END>>>. " ..
            "Do not rewrite any existing lines outside of this region."

        prompt_and_output_code(system, table.concat(buffer_lines, "\n"), start_row - 1, end_row)
    end)
end

return M
