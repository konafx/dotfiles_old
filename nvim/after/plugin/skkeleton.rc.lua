-- access https://skk-dev.github.io/dict/
-- $ curl -OL https://skk-dev.github.io/dict/SKK-JISYO.L.gz
-- put /usr/share/skk/SKK-JISYO.L

vim.keymap.set({'i', 'c'}, '<C-j>', '<Plug>(skkeleton-toggle)', { noremap = false })

vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('skkeleton-initialize-pre', {}),
  pattern = 'skkeleton-initialize-pre',
  callback = function()
    vim.cmd([[
      call skkeleton#config({
        \ 'eggLikeNewline': v:true,
        \ 'debug': v:true,
        \ })
    ]])
  end
})
