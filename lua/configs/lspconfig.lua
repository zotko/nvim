require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "basedpyright" }
vim.lsp.enable(servers)

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic", -- "off", "basic", "standard", "strict"
                diagnosticMode = "workspace", -- analyze all project files, not just open buffers
                autoImportCompletions = true, -- surface importable symbols in completion results
                autoSearchPaths = true, -- resolve packages by scanning common project roots
                useLibraryCodeForTypes = true, -- fall back to library code when type stubs are missing
            }
        }
    }
})
