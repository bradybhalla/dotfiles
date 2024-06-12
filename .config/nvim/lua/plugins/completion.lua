return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-omni",
        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            config = function()
                local ls = require("luasnip")

                vim.keymap.set({ "i" }, "<S-TAB>", function() ls.expand() end)
                vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1) end)
                vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end)
                vim.keymap.set({ "i", "s" }, "<C-l>", function()
                    if ls.choice_active() then
                        ls.change_choice(1)
                    end
                end)

                ls.config.setup({
                    store_selection_keys = "<S-TAB>", -- snippets using visual selection
                    enable_autosnippets = true,
                    update_events = "TextChanged,TextChangedI"
                })

                require("luasnip.loaders.from_lua").lazy_load()    -- from luasnippets/
            end
        }
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<TAB>"] = cmp.mapping.confirm({ select = true }),
                -- <C-e> to abort
                -- <C-n>/<C-p> to choose other completions
                -- down/up arrows also work
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "luasnip" }
            }, {
                { name = "buffer" },
            }),
            performance = {
                max_view_entries = 10
            },
            completion = {
                keyword_length = 2
            }
        }

        -- find
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" }
            }
        })

        -- vim commands
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" }
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" }
                    }
                }
            })
        })
    end
}
