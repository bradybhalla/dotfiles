M = {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
    },
    build = ":MasonUpdate"
}

function M.config()
    local function create_on_attach(server_name)
        return function(client, bufnr)

            -- custom mappings

            -- format
            if server_name == "pyright" then
                vim.keymap.set("n", "<leader>lf", function()
                    print("no format for python yet")
                end)
            else
                vim.keymap.set("n", "<leader>lf", function()
                    vim.lsp.buf.format()
                end)
            end

            -- go to definition
            vim.keymap.set("n", "<leader>ld", function()
                vim.lsp.buf.definition()
            end)


            -- disable highlighting from lsp
            client.server_capabilities.semanticTokensProvider = nil
        end
    end

    -- setup and config
    local handlers = {
        -- default handler
        function(server_name)
            require("lspconfig")[server_name].setup {
                on_attach = create_on_attach(server_name)
            }
        end,

        -- overrides
        ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup {
                on_attach = create_on_attach("lua_ls"),
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        }
                    }
                }
            }
        end
    }
    require("mason").setup()
    require("mason-lspconfig").setup({ handlers = handlers })
end

return M
