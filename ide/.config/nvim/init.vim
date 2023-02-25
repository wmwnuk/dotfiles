"    ____                            _    ___           ____      
"   / __ \____ ___  ___  ____ _____ | |  / (_)___ ___  / __ \_____
"  / / / / __ `__ \/ _ \/ __ `/ __ `/ | / / / __ `__ \/ /_/ / ___/
" / /_/ / / / / / /  __/ /_/ / /_/ /| |/ / / / / / / / _, _/ /__  
" \____/_/ /_/ /_/\___/\__, /\__,_/ |___/_/_/ /_/ /_/_/ |_|\___/  
"                     /____/                                      
"
" The ULTIMATE Vim config

if has('nvim')
    let g:sigma#use_lsp = 1
    let g:sigma#lsp_default = 1
else
    let g:sigma#use_coc = 1
    let g:sigma#coc_default = 1
endif

if has('nvim')
    call sigma#add('stevearc/dressing.nvim')
    call sigma#add('ziontee113/icon-picker.nvim')
    call sigma#add('nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' })
    call sigma#add('nvim-orgmode/orgmode')
    call sigma#add('akinsho/org-bullets.nvim')
    call sigma#add('ThePrimeagen/vim-be-good')
    call sigma#add('mhinz/vim-startify')

    call sigma#remove('glepnir/dashboard-nvim')

    call sigma#lsp_add('intelephense')
    call sigma#lsp_add('pyright')
    call sigma#lsp_add('tsserver') 
    call sigma#lsp_add('cssls')
    call sigma#lsp_add('jsonls')
    call sigma#lsp_add('bashls')
    call sigma#lsp_add('marksman')
    call sigma#lsp_add('lemminx')
    call sigma#lsp_add('elixirls')
endif

call sigma#init()

" General Plugin Config
let $FZF_DEFAULT_COMMAND = "rg -g '!{.git,node_modules,.composer}/' --hidden --no-ignore -l ''"
let $FZF_DEFAULT_OPTS = '--color=fg:#a9b1d6,bg:#1a1b26,hl:#7aa2f7 --color=fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff --color=info:#cfc9c2,prompt:#f7768e,pointer:#bb9af7 --color=marker:#9ece6a,spinner:#bb9af7,header:#73daca'

" nnn.vim
let g:nnn#command = 'nnn -a -H -Pp -o'

" vim-project
let g:vim_project_config = {
      \'config_home':                   '~/.vim/vim-project-config',
      \'project_base':                  ['~'],
      \'use_session':                   0,
      \'open_root_when_use_session':    0,
      \'check_branch_when_use_session': 0,
      \'project_root':                  './',
      \'auto_load_on_start':            1,
      \'include':                       ['./'],
      \'exclude':                       ['.git', 'node_modules', '.DS_Store'],
      \'search_include':                [],
      \'find_in_files_include':         [],
      \'search_exclude':                [],
      \'find_in_files_exclude':         [],
      \'auto_detect':                   'no',
      \'auto_detect_file':              ['.git', '.svn'],
      \'project_views':                 [],
      \'file_mappings':                 {},
      \'tasks':                         [],
      \'debug':                         0,
      \}

" suda.vim
let g:suda#nopass = 1

if has('nvim')
    " dashboard-nvim
    ":lua require('dashboard-config')
    " startify
    let g:startify_commands = [
                \ {'p': ['  Open project      SPC p p', 'ProjectList']},
                \ {'a': ['  Open org-agenda   SPC o a', 'lua require("orgmode").action("agenda.prompt")']},
                \ {'r': ['  Recent files      SPC f r', 'SigmaRecentFiles']},
                \ {'f': ['  Find files        SPC f f', 'SigmaFiles']},
                \ {'n': ['  File browser      SPC f b', 'NnnPicker']},
                \ {'z': ['  Find word         SPC r g', 'SigmaRg']},
                \ {'g': ['  Vim Be Good       SPC b g', 'VimBeGood']},
                \ {'s': ['烈 Update SigmaVimRc SPC u s', 'SigmaUpdate']},
                \ {'u': ['  Update plugins    SPC u p', 'PlugUpdate']},
                \ {'c': ['  Configure         SPC f P', 'SigmaConfig']},
                \ ]
    " dev icons for startify
    :lua function _G.webDevIcons(path) local filename = vim.fn.fnamemodify(path, ':t') local extension = vim.fn.fnamemodify(path, ':e') return require'nvim-web-devicons'.get_icon(filename, extension, { default = true }) end

    function! StartifyEntryFormat() abort
        return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
    endfunction
    " org-bullets.nvim
    :lua require('org-bullets').setup()
    " icon-picker.nvim
    :lua require("icon-picker").setup({ disable_legacy_commands = true })
    " orgmode
    :lua require("orgmode-config")
    " nvim-treesitter
    :lua require("treesitter-config")
    " lspconfig
    :lua require("lsp")
endif

" Mappings 
if has('nvim')
    nnoremap <leader>fg <Cmd>IconPickerNormal nerd_font<CR>
    nnoremap <leader>fe <Cmd>IconPickerNormal emoji<CR>
    nnoremap <leader>fs <Cmd>IconPickerNormal symbols<CR>
    nnoremap <leader>fa <Cmd>IconPickerNormal alt_font<CR>

    " Vim Be Good
    nnoremap <leader>bg <Cmd>VimBeGood<CR>
endif

" Autocmd
autocmd FileType * if &ft != 'startify' && &ft != 'dashboard' | :set cursorline | endif

" Magento 2 linters
nnoremap <silent><leader>md <Cmd>!phpmdm2 %<CR>
nnoremap <silent><leader>mc <Cmd>!phpcsm2 %<CR>
nnoremap <silent><leader>mb <Cmd>!phpcbfm2 %<CR>
nnoremap <silent><leader>mf <Cmd>!php-cs-fixer-m2 fix %<CR>
nnoremap <silent><leader>me <Cmd>!eslint %<CR>

" Pandoc
nnoremap <silent><leader>pop <Cmd>!pandoc -f org -t pdf -o %.pdf %<CR><C-j>
nnoremap <silent><leader>pom <Cmd>!pandoc -f org -t markdown -o %.md %<CR><C-j>
nnoremap <silent><leader>poh <Cmd>!pandoc -f org -t html -o %.html %<CR><C-j>
nnoremap <silent><leader>pmo <Cmd>!pandoc -f markdown -t org -o %.md %<CR><C-j>
nnoremap <silent><leader>pho <Cmd>!pandoc -f html -t org -o %.html %<CR><C-j>
