-- custom/configs/null-ls.lua
local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end
local sources = {
    formatting.prettierd,
    formatting.stylua,

    lint.shellcheck,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
    debug = true,
    sources = sources,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    lsp_formatting(bufnr)
                end,
            })
        end
    end
}
vim.api.nvim_create_user_command(
    'DisableLspFormatting',
    function()
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
    end,
    { nargs = 0 }
)
