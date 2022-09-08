vim.keymap.set('', '<S-t>', '<Cmd>Fern . -drawer -reveal=% -toggle<CR>')

vim.api.nvim_create_augroup('fern-no-number', {} )
vim.api.nvim_create_autocmd('filetype', {
  group = 'fern-no-number',
  pattern = 'fern',
  callback = function() vim.opt_local.number = false end,
})

vim.g['fern#renderer'] = 'nerdfont'
