"    ____                            _    ___           ____
"   / __ \____ ___  ___  ____ _____ | |  / (_)___ ___  / __ \_____
"  / / / / __ `__ \/ _ \/ __ `/ __ `/ | / / / __ `__ \/ /_/ / ___/
" / /_/ / / / / / /  __/ /_/ / /_/ /| |/ / / / / / / / _, _/ /__
" \____/_/ /_/ /_/\___/\__, /\__,_/ |___/_/_/ /_/ /_/_/ |_|\___/
"                     /____/
"
" The ULTIMATE Vim config

let g:sigma#use_coc = 1
let g:sigma#coc_default = 1

" call sigma#add('sigmavim/vimrc', {'branch': '6-update-plugins'})
call sigma#remove('mcchrish/nnn.vim')

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
