return {
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip").config.setup({
                enable_autosnippets = true,
                update_events = "TextChanged,TextChangedI"
            })
            require("luasnip.loaders.from_lua").lazy_load() -- from luasnippets/
        end
    },

    -- autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-omni",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip"
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                mapping = {
                    ["<TAB>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }
                }, {
                    { name = "buffer" },
                })
            }

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end
    }
}
