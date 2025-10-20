require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "basedpyright" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic", -- "off", "basic", "standard", "strict"
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly", -- or "workspace"
            }
        }
    }
})
