return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-omni",
        {
            "SirVer/ultisnips",
            config = function()
                vim.g.UltiSnipsSnippetDirectories = { "~/.config/nvim/UltiSnips" }
                vim.g.UltiSnipsExpandTrigger = "<S-TAB>" -- shift tab to override other completions
                -- <C-j> jump forward
                -- <C-k> jump backward
            end
        },
        "quangnguyen30192/cmp-nvim-ultisnips"
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup {
            snippet = {
                expand = function(args)
                    vim.fn["UltiSnips#Anon"](args.body)
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
                { name = "ultisnips" }
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
