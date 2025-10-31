require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright" }
vim.lsp.enable(servers)

vim.lsp.config("pyright", {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off", -- "off", "basic", "standard", "strict"
                diagnosticMode = "off", -- analyze all project files, not just open buffers
                autoImportCompletions = true, -- surface importable symbols in completion results
                autoSearchPaths = true, -- resolve packages by scanning common project roots
                useLibraryCodeForTypes = true, -- fall back to library code when type stubs are missing
                diagnosticSeverityOverrides = {
                    reportAny = "hint", -- downgrade "Type 'Any' is not allowed" to a low-priority hint
                },
            }
        }
    }
})
