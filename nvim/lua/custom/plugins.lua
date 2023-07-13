local plugins = {
    {
        "nvim-telescope/telescope-fzy-native.nvim"
    },
    {
        'dinhhuy258/git.nvim',
        config = function()
            require('git').setup({
                default_mappings = true, -- NOTE: `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`

                keymaps = {
                    -- Open blame window
                    blame = "<Leader>gb",
                    -- Close blame window
                    quit_blame = "q",
                    -- Open blame commit
                    blame_commit = "<CR>",
                    -- Open file/folder in git repository
                    browse = "<Leader>go",
                    -- Open pull request of the current branch
                    open_pull_request = "<Leader>gp",
                    -- Create a pull request with the target branch is set in the `target_branch` option
                    create_pull_request = "<Leader>gn",
                    -- Opens a new diff that compares against the current index
                    diff = "<Leader>gd",
                    -- Close git diff
                    diff_close = "<Leader>gD",
                    -- Revert to the specific commit
                    revert = "<Leader>gr",
                    -- Revert the current file to the specific commit
                    revert_file = "<Leader>gR",
                },
                -- Default target branch when create a pull request
                target_branch = "master",
            })

        end
    },
    { "junegunn/fzf", build = "./install --bin" },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({})
        end
    },
    {
        "mfussenegger/nvim-jdtls",
        event = "BufRead"
    },
    {
        "windwp/nvim-ts-autotag",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-ts-autotag').setup({
                -- your config
            })
        end,
        lazy = true,
        event = "VeryLazy"
    },
    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({
                ui = {
                    border = 'rounded',
                },
                symbol_in_winbar = {
                    enable = true,
                    separator = '  ',
                    hide_keyword = true,
                    show_file = true,
                    folder_level = 2,
                    respect_root = false,
                    color_mode = true,
                },
                request_timeout = 5000,
            })

        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                require "custom.configs.null-ls"
            end,
        },
    },
    {
        "https://gitlab.com/schrieveslaach/sonarlint.nvim",
        ft = { "python", "cpp", "java" },
        dependencies = {
            "mfussenegger/nvim-jdtls"
        },
        config = function()
            print("running up sonarlint --")
            require('sonarlint').setup({
                server = {
                    cmd = {
                        'sonarlint-language-server',
                        -- Ensure that sonarlint-language-server uses stdio channel
                        '-stdio',
                        '-analyzers',
                        -- paths to the analyzers you need, using those for python and java in this example
                        vim.fn.expand("/Users/syahrulataufik/.local/share/nvim/mason/share/sonarlint-analyzers/sonarpython.jar"),
                        vim.fn.expand("/Users/syahrulataufik/.local/share/nvim/mason/share/sonarlint-analyzers/sonarcfamily.jar"),
                        vim.fn.expand("/Users/syahrulataufik/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjava.jar"),
                    }
                },
                filetypes = {
                    -- Tested and working
                    'python',
                    'cpp',
                    -- Requires nvim-jdtls, otherwise an error message will be printed
                    'java',
                }
            })
        end

    },
    {
        "gen740/SmoothCursor.nvim",
        config = function()
            require('smoothcursor').setup({
                autostart = true,
                cursor = "", -- cursor shape (need nerd font)
                texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
                linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
                type = "default", -- define cursor movement calculate function, "default" or "exp" (exponential).
                fancy = {
                    enable = false, -- enable fancy mode
                    head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
                    body = {
                        { cursor = "", texthl = "SmoothCursorRed" },
                        { cursor = "", texthl = "SmoothCursorOrange" },
                        { cursor = "●", texthl = "SmoothCursorYellow" },
                        { cursor = "●", texthl = "SmoothCursorGreen" },
                        { cursor = "•", texthl = "SmoothCursorAqua" },
                        { cursor = ".", texthl = "SmoothCursorBlue" },
                        { cursor = ".", texthl = "SmoothCursorPurple" },
                    },
                    tail = { cursor = nil, texthl = "SmoothCursor" }
                },
                flyin_effect = nil, -- "bottom" or "top"
                speed = 25, -- max is 100 to stick to your current position
                intervals = 35, -- tick interval
                priority = 10, -- set marker priority
                timeout = 3000, -- timout for animation
                threshold = 3, -- animate if threshold lines jump
                disable_float_win = false, -- disable on float window
                enabled_filetypes = nil, -- example: { "lua", "vim" }
                disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
            })
        end
    },

}
return plugins
