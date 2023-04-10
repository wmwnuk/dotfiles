--    ____                            _    ___           ____
--   / __ \____ ___  ___  ____ _____ | |  / (_)___ ___  / __ \_____
--  / / / / __ `__ \/ _ \/ __ `/ __ `/ | / / / __ `__ \/ /_/ / ___/
-- / /_/ / / / / / /  __/ /_/ / /_/ /| |/ / / / / / / / _, _/ /__
-- \____/_/ /_/ /_/\___/\__, /\__,_/ |___/_/_/ /_/ /_/_/ |_|\___/
--                     /____/
--
-- The ULTIMATE Vim config

local lsp_servers = require('sigma').lsp_servers
table.insert(lsp_servers, 'intelephense')
table.insert(lsp_servers, 'pyright')
table.insert(lsp_servers, 'tsserver')
table.insert(lsp_servers, 'cssls')
table.insert(lsp_servers, 'jsonls')
table.insert(lsp_servers, 'bashls')
table.insert(lsp_servers, 'marksman')
table.insert(lsp_servers, 'lemminx')
table.insert(lsp_servers, 'elixirls')
table.insert(lsp_servers, 'vls')
table.insert(lsp_servers, 'rust_analyzer')

require('sigma').setup({
    lsp_servers = lsp_servers
})

-- General Plugin Config
vim.env.FZF_DEFAULT_COMMAND = "rg -g '!{.git,node_modules,.composer}/' --hidden --no-ignore -l ''"
vim.env.FZF_DEFAULT_OPTS =
'--color=fg:#a9b1d6,bg:#1a1b26,hl:#7aa2f7 --color=fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff --color=info:#cfc9c2,prompt:#f7768e,pointer:#bb9af7 --color=marker:#9ece6a,spinner:#bb9af7,header:#73daca'

-- nnn.vim
if (vim.env.TERM == 'xterm-kitty') then
    vim.g['nnn#command'] = 'nnn -a -H -Pp -o'
else
    vim.g['nnn#command'] = 'nnn -a -H -o'
end

-- vim-project
vim.g.vim_project_config = {
    config_home = '~/.vim/vim-project-config',
    project_base = { '~' },
    use_session = 0,
    open_root_when_use_session = 0,
    check_branch_when_use_session = 0,
    project_root = './',
    auto_load_on_start = 1,
    include = { './' },
    exclude = { '.git', 'node_modules', '.DS_Store' },
    search_include = {},
    find_in_files_include = {},
    search_exclude = {},
    find_in_files_exclude = {},
    auto_detect = 'no',
    auto_detect_file = { '.git', '.svn' },
    project_views = {},
    file_mappings = {},
    tasks = {},
    debug = 0,
}

-- -- vim-skeleton
-- vim.cmd([[
-- if !exists('g:skeleton_find_template')
--     let g:skeleton_find_template = []
-- endif
--
-- function! SkelTemplate(path) abort
--     let s:filename = split(a:path, '/')[-1]
--     if filereadable('~/.vim/templates/' .. s:filename)
--         return s:filename
--     endif
--
--     return ''
-- endfunction
-- ]])
--
-- vim.g.skeleton_find_template.php = vim.cmd[[function('SkelTemplate')]]
-- vim.g.skeleton_find_template.php = vim.cmd[[function('SkelTemplate')]]

-- suda.vim
vim.g['suda#nopass'] = 1

-- nvim-treesitter
require("treesitter-config")
-- lspconfig
require("lsp")

-- Autocmd
vim.cmd [[autocmd FileType * if &ft != 'startify' && &ft != 'dashboard' | :set cursorline | endif]]
vim.cmd [[autocmd BufNewFile,BufRead *.v set filetype=vlang]]

local utils, opts = require('sigma.utils'), { silent = true }

-- Magento 2 linters
utils.noremap('n', '<leader>md', '<Cmd>!phpmdm2 %<CR>', opts)
utils.noremap('n', '<leader>mc', '<Cmd>!phpcsm2 %<CR>', opts)
utils.noremap('n', '<leader>mb', '<Cmd>!phpcbfm2 %<CR>', opts)
utils.noremap('n', '<leader>mf', '<Cmd>!php-cs-fixer-m2 fix %<CR>', opts)
utils.noremap('n', '<leader>me', '<Cmd>!eslint %<CR>', opts)

-- Pandoc
utils.noremap('n', '<leader>pop', '<Cmd>!pandoc -f org -t pdf -o %:r.pdf %<CR><C-j>', opts)
utils.noremap('n', '<leader>pmp', '<Cmd>!pandoc -f markdown -t pdf -o %:r.pdf %<CR><C-j>', opts)
utils.noremap('n', '<leader>pom', '<Cmd>!pandoc -f org -t markdown -o %:r.md %<CR><C-j>', opts)
utils.noremap('n', '<leader>poh', '<Cmd>!pandoc -f org -t html -o %:r.html %<CR><C-j>', opts)
utils.noremap('n', '<leader>pmh', '<Cmd>!pandoc -f markdown -t html -o %:r.html %<CR><C-j>', opts)
utils.noremap('n', '<leader>pmo', '<Cmd>!pandoc -f markdown -t org -o %:r.md %<CR><C-j>', opts)
utils.noremap('n', '<leader>pho', '<Cmd>!pandoc -f html -t org -o %:r.org %<CR><C-j>', opts)
utils.noremap('n', '<leader>phm', '<Cmd>!pandoc -f html -t markdown -o %:r.md %<CR><C-j>', opts)
