local ok, mason_null_ls = pcall(require, "mason-null-ls")
if not ok then
  print("mason-null-ls is not installed")
  return
end

mason_null_ls.setup_handlers()

vim.keymap.set("n", "<Plug>(lsp)f", function()
  vim.lsp.buf.format({ name = "null-ls" })
end)
