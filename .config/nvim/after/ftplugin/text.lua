-- keymaps
require("which-key").add({
    -- only for current buffer
    buffer = 0,

    -- up/down inside a line
    {
        mode = { "n", "v" },
        { "j",  "gj" },
        { "k",  "gk" },
        { "gj", "j" },
        { "gk", "k" },
    }
})
