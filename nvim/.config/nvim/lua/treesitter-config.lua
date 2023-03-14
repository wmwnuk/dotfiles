-- nvim-treesitter
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = {'php'},
        additional_vim_regex_highlighting = {'org'},
    },
    ensure_installed = {'org', 'lua', 'html', 'css', 'vim', 'php', 'phpdoc', 'javascript', 'elixir', 'v', 'rust'},
    indent = {
        enable = true,
        disable = {'php'}
    }
})
