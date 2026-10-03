local M = {}

function M.open_file_folder()
    vim.ui.open(vim.fn.expand("%:p:h"))
end

function M.lazygit()
    local dir = vim.fn.expand("%:h")
    if vim.fn.isdirectory(dir) == 0 then
        dir = "."
    end
    require("toggleterm.terminal").Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        dir = dir,
        count = 99
    }):toggle()
end

function M.toggle_spellcheck()
    vim.opt_local.spell = not vim.opt_local.spell:get()
    vim.notify("spellcheck: " .. (vim.opt_local.spell:get() and "on" or "off"))
end

function M.toggle_diagnostic_virtual_text()
    local val = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = val })
    vim.notify("diagnostic virtual text: " .. (val and "on" or "off"))
end

return M
