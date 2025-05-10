local maps = {}

-- general behavior
maps[#maps + 1] = {
    {
        -- indenting lines
        { ">", ">gv" },
        { "<", "<gv" },
        mode = "v"
    },

    {
        -- jk move within wrapped line
        { "j",  "gj" },
        { "gj", "j" },
        { "k",  "gk" },
        { "gk", "k" },
        mode = { "n", "v" },
    }
}

-- general shortcuts
maps[#maps + 1] = {
    { "<leader>q", "<CMD>q<CR>",           desc = "quit" },
    { "<leader>w", "<CMD>w<CR>",           desc = "save" },
    { "<leader>c", "\"+",                  desc = "system clipboard",       mode = { "n", "v" } },
    { "<leader>O", "<CMD>OpenFinder<CR>",  desc = "open finder" },
    { "<leader>S", "<CMD>ToggleSpell<CR>", desc = "toggle spellcheck" },
    { "<leader>G", "<CMD>Lazygit<CR>",     desc = "lazygit" },
    { "<leader>F", "<CMD>Format<CR>",      desc = "format buffer or range", mode = { "n", "v" } },
}

-- telescope shortcuts
maps[#maps + 1] = {
    { "<leader>f",  group = "telescope" },
    { "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>",                desc = "files" },
    { "<leader>fa", "<CMD>Telescope find_files hidden=true no_ignore=true<CR>", desc = "files (no ignore)" },
    { "<leader>fg", "<CMD>Telescope live_grep<CR>",                             desc = "text" },
    { "<leader>fb", "<CMD>Telescope buffers<CR>",                               desc = "buffers" },
    { "<leader>fh", "<CMD>Telescope help_tags<CR>",                             desc = "help" },
    { "<leader>ft", "<CMD>Telescope builtin<CR>",                               desc = "builtins" },
}

-- lsp telescope shortcuts
maps[#maps + 1] = {
    { "<leader>l",  group = "lsp (telescope)" },
    { "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>",  desc = "document symbols" },
    { "<leader>lS", "<CMD>Telescope lsp_workspace_symbols<CR>", desc = "workspace symbols" },
}

-- filetree shortcuts
maps[#maps + 1] = {
    { "<leader>e",  group = "filetree" },
    { "<leader>ef", "<CMD>NvimTreeFindFile<CR>", desc = "show file" },
    { "<leader>eo", "<CMD>NvimTreeOpen<CR>",     desc = "open" },
    { "<leader>ec", "<CMD>NvimTreeClose<CR>",    desc = "close" },
}


-- luasnip insert mode bindings
maps[#maps + 1] = {
    { "<S-TAB>", function() require("luasnip").expand() end, mode = "i" },
    { "<C-f>",   function() require("luasnip").jump(1) end,  mode = { "i", "s" } },
    { "<C-b>",   function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    {
        "<C-e>",
        function()
            if require("luasnip").choice_active() then
                require("luasnip").change_choice(1)
            end
        end,
        mode = { "i", "s" }
    },
}


-- copilot chat shortcuts
local prompt_buffer = function()
    return {
        selection = require("CopilotChat.select").buffer,
        highlight_selection = false
    }
end

local prompt_visual = function()
    return {
        selection = require("CopilotChat.select").visual,
        context = "buffer"
    }
end


-- copilot insert mode bindings
maps[#maps + 1] = {
    { "<C-k>", "exists(\"*copilot#Accept\") ? copilot#Accept(\"\") : \"\"",     expr = true, replace_keycodes = false, },
    { "<C-l>", "exists(\"*copilot#AcceptWord\") ? copilot#AcceptWord() : \"\"", expr = true, replace_keycodes = false },
    { "<C-j>", "exists(\"*copilot#AcceptLine\") ? copilot#AcceptLine() : \"\"", expr = true, replace_keycodes = false },
    { "<C-h>", "exists(\"*copilot#Dismiss\") ? copilot#Dismiss() : \"\"",       expr = true, replace_keycodes = false },
    mode = "i"
}


maps[#maps + 1] = {
    { "<leader>i", group = "copilot chat" },
    {
        "<leader>it",
        function()
            require("CopilotChat").toggle()
        end,
        desc = "toggle chat"
    },
    {
        "<leader>iC",
        function()
            require("CopilotChat").ask("Add comments to the selected code. " ..
                "Only add comments if they enhance the readability of the code. " ..
                "Do not add comments to code which is already easy to understand " ..
                "Do not modify the existing code. " ..
                "Do not modify existing comments.",
                prompt_visual())
        end,
        desc = "add comments (visual selection)"
    },
    {
        "<leader>ii",
        function()
            require("CopilotChat").ask(
                "Write a code snippet which implements the selected comment. " ..
                "Do not keep the original comment. " ..
                "Do not add excessive additional comments.",
                prompt_visual())
        end,
        desc = "implement from comment (visual selection)"
    },
    {
        "<leader>id",
        function()
            require("CopilotChat").ask(
                "Analyze the current file and determine if there is a bug. " ..
                "If a bug exists, explain it and modify the code. " ..
                "If a bug does not exist, state this.",
                prompt_buffer())
        end,
        desc = "find and fix bugs"
    },

    mode = { "n", "v" }
}


require("which-key").add(maps)
