local keymap = vim.keymap

-- １文字貼り付け防止
keymap.set('', 'x', '"_x')

-- 水平移動
keymap.set('', 'H', '^')
keymap.set('', 'L', 'g_')

-- インデントしても選択領域を保持
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')
keymap.set('v', '=', '=gv')

-- `*`検索の初回移動無効
keymap.set('n', '*', function()
  return vim.v.count >= 1 and '*'
      or [[<Cmd>sil exe "keepj norm! *" <Bar> call winrestview(]] .. vim.fn.string(vim.fn.winsaveview()) .. ')<CR>'
end, { silent = true, expr = true })

-- save
keymap.set('n', '<Leader>w', '<Cmd>w<CR>', { silent = true })

-- clear hylight
keymap.set('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>', { noremap = false })

-- Make inputting a character by code easily.
keymap.set('i',
  '<Plug>(vimrc-input-char-by-code)',
  [[<C-r>=nr2char(eval(input('char? ', '0x')))<CR>]],
  { noremap = true }
)
keymap.set('i', '<C-v>x', '<Plug>(vimrc-input-char-by-code)', { noremap = false })
keymap.set('i', '<C-v>u', '<Plug>(vimrc-input-char-by-code)', { noremap = false })
keymap.set('i', '<C-v>U', '<Plug>(vimrc-input-char-by-code)', { noremap = false })

-- [tab] {{{
keymap.set('', '[tab]', '<Nop>')
keymap.set('n', 't', '[tab]', { remap = true })

keymap.set('n', '[tab]n', '<Cmd>tabnext<CR>', { silent = true })
keymap.set('n', '[tab]p', '<Cmd>tabprevious<CR>', { silent = true })
keymap.set('n', '[tab]e', '<Cmd>tabedit<CR>', { silent = true })
keymap.set('n', '[tab]c', '<Cmd>tabclose<CR>', { silent = true })
keymap.set('n', '[tab]o', '<Cmd>tabonly<CR>', { silent = true })
-- }}}
