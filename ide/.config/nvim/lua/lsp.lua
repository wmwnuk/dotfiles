local defaults = require('sigma.lsp.defaults')
defaults.init_options = {licenceKey = '/home/lanius/.vim/intelephense/licence.txt'}
require("lspconfig")['intelephense'].setup(defaults)
