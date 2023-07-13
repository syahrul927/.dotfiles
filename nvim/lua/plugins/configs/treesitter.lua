local options = {
    ensure_installed = {
        "tsx",
        "toml",
        "fish",
        "php",
        "json",
        "yaml",
        "css",
        "html",
        "lua",
        "java",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },
    auto_install = true,
    autotag = {
        enable = true,
        filetypes = {
            'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
            'rescript',
            'css', 'lua', 'xml', 'php', 'markdown'
        },
    },
    indent = { enable = true },
}

return options
