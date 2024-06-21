return {
    "stevearc/conform.nvim",
    config = function()
        local formatters = {
            { ft = { "python" },            fmt = { "black" } },
            { ft = { "html", "css" },       fmt = { "prettier" } },
            { ft = { "bash", "zsh", "sh" }, fmt = { "beautysh" } },
            { ft = { "ocaml" },             fmt = { "ocamlformat" } },
        }

        local formatters_expanded = {}
        for i = 1, #formatters do
            for _, ft in ipairs(formatters[i].ft) do
                formatters_expanded[ft] = formatters[i].fmt
            end
        end

        require("conform").setup({
            formatters_by_ft = formatters_expanded,
        })
    end
}
