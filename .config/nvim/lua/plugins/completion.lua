return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        {
            "SirVer/ultisnips",
            config = function()
                vim.g.UltiSnipsSnippetDirectories = { "~/.config/nvim/UltiSnips" }
                vim.g.UltiSnipsExpandTrigger = "<tab>"
                vim.g.UltiSnipsJumpForwardTrigger = "<right>"
                vim.g.UltiSnipsJumpBackwardTrigger = "<left>"
            end
        },
        "quangnguyen30192/cmp-nvim-ultisnips"
    },
    config = function()
        local cmp = require("cmp")


        local mapping = cmp.mapping.preset.insert({
            ["<C-e>"] = cmp.mapping.confirm({ select = true }),
            ["<C-a>"] = cmp.mapping.abort()
        })

        -- sources of completions
        local default_sources = {
            { name = "nvim_lua" },
            { name = "nvim_lsp" }, -- lsp completions set up in lsp files
            { name = "ultisnips" },
            { name = "buffer" },
        }

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
