local aerial = require "aerial"

aerial.setup {
    backends = { "lsp", "treesitter" },
    on_attach = function(bufnr)
        -- buffer-local navigation between outline symbols
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial previous symbol" })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial next symbol" })
    end,
}

vim.keymap.set("n", "<leader>tb", function()
    aerial.toggle { focus = false }
end, { desc = "Toggle Aerial outline" })
