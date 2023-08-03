return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-omni",
        {
            "SirVer/ultisnips",
            config = function()
                vim.g.UltiSnipsSnippetDirectories = { "~/.config/nvim/UltiSnips" }
                vim.g.UltiSnipsExpandTrigger = "<S-TAB>"      -- shift tab to override other completions
                vim.g.UltiSnipsJumpForwardTrigger = "<RIGHT>" -- arrows to jump to fields
                vim.g.UltiSnipsJumpBackwardTrigger = "<LEFT>"
            end
        },
        "quangnguyen30192/cmp-nvim-ultisnips"
    },
    config = function()
        local cmp = require("cmp")

        local mapping = cmp.mapping.preset.insert({
            ["<TAB>"] = cmp.mapping.confirm({ select = true }),
            ["<CR>"] = cmp.mapping.confirm({ select = false }), -- enter only when explicitly selected
            ["<C-a>"] = cmp.mapping.abort()
            -- up/down arrows to choose other completions
        })

        -- sources of completions
        local default_sources = cmp.config.sources({
            { name = "nvim_lua",  keyword_length = 2 },
            { name = "nvim_lsp",  keyword_length = 2 }, -- lsp completions set up in lsp files
            { name = "ultisnips", keyword_length = 2 }
        }, {
            { name = "buffer", keyword_length = 3 },
        })



        cmp.setup {
            snippet = {
                expand = function(args)
                    vim.fn["UltiSnips#Anon"](args.body)
                end,
            },
            mapping = mapping,
            sources = default_sources,
            experimental = {
                ghost_text = false -- makes phantom text
            },
            performance = {
                max_view_entries = 10
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
