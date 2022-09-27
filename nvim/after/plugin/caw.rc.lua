-- 行の最初の文字の前にコメント文字をトグル
vim.keymap.set('n', '<Leader>c', '<Plug>(caw:hatpos:toggle)', { noremap = false });
vim.keymap.set('v', '<Leader>c', '<Plug>(caw:hatpos:toggle)', { noremap = false });
-- 行頭にコメントをトグル
vim.keymap.set('n', '<Leader>,', '<Plug>(caw:zeropos:toggle)', { noremap = false });
vim.keymap.set('v', '<Leader>,', '<Plug>(caw:zeropos:toggle)', { noremap = false });

-- Fix tsx, jsx commentout
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('SetJsxComment', {}),
  pattern = { 'javascriptreact', 'typescriptreact', 'react' },
  callback = function()
    vim.bo.commentstring = ''
    vim.api.nvim_buf_del_var(0, 'caw_oneline_comment')
    vim.api.nvim_buf_set_var(0, 'caw_wrap_oneline_comment', { '{/*', '*/}' })
  end,
})
