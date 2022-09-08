local keymap = vim.keymap

-- １文字貼り付け防止
keymap.set([[]], [[x]], [["_x]])

-- 水平移動
keymap.set('', [[H]], [[^]])
keymap.set('', [[L]], [[g_]])

-- インデントしても選択領域を保持
keymap.set([[v]], [[<]], [[<gv]])
keymap.set([[v]], [[>]], [[>gv]])
keymap.set([[v]], [[=]], [[=gv]])

-- `*`検索の初回移動無効
-- TODO: bug?
keymap.set([[n]], [[*]], function()
  return vim.v.count and [[*]] or [[<Cmd>sil exe "keepj norm! *" <Bar> call winrestview(]]..string(winsaveview())..[[)<CR>]]
end, { silent = true, expr = true })
