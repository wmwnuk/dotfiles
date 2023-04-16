local M = {
    setup = function()
        require('Comment').setup()
        local ft = require('Comment.ft')
        ft({ 'vlang' }, ft.get('c'))
    end
}

return M
