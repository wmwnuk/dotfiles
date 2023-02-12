-- orgmode
require('orgmode').setup_ts_grammar()

require('orgmode').setup({
    org_agenda_files = {'~/Projects/Org/*'},
    org_default_notes_file = '~/Projects/Org/inbox.org',
})
vim.cmd[[autocmd FileType org setlocal indentexpr=]]
