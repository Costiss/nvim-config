local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        typescript = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
        svelte = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        xml = { "prettierd" },
        sql = { "sql_formatter" },
        -- elixir = { "lexical" },
        -- python = { "isort", "black" },
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
    },
})

-- Save without format
vim.keymap.set({ "n", "v" }, "<leader>s", function()
    vim.cmd([[:noautocmd w]])
end)
