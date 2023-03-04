local defaults = require('sigma.lsp.defaults')
defaults.init_options = {
    licenceKey = '/home/lanius/.vim/intelephense/licence.txt',
    globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense'
}
require("lspconfig")['intelephense'].setup(defaults)
