local ok, luasnip = pcall(require, 'luasnip')
if not ok then print('luasnip is not installed') return end

-- load friendly-snippets
require('luasnip/loaders/from_vscode').lazy_load()
