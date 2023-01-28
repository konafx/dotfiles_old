local ok, _ = pcall(require, 'mason')
if not ok then
	print('mason is not installed')
	return
end

local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not ok then
	print('mson-lspconfig is not installed')
	return
end

local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
	print('nvim-lspconfig is not installed')
	return
end

-- https://scrapbox.io/vim-jp/better_K_for_neovim_lua
local function lua_help()
	if vim.bo.filetype ~= 'lua' then
		return false
	end
	local current_line = vim.api.nvim_get_current_line()
	local cursor_col = vim.api.nvim_win_get_cursor(0)[2] + 1
	-- vim.fn.foo
	local s, e, m = current_line:find([[fn%.([%w_]+)%(?]])
	if s and s <= cursor_col and cursor_col <= e then
		vim.cmd('h ' .. m)
		return true
	end
	-- vim.fn['foo']
	s, e, m = current_line:find([[fn%[['"]([%w_#]+)['"]%]%(?]])
	if s and s <= cursor_col and cursor_col <= e then
		vim.cmd('h ' .. m)
		return true
	end
	-- vim.api.foo
	s, e, m = current_line:find([[api%.([%w_]+)%(?]])
	if s and s <= cursor_col and cursor_col <= e then
		vim.cmd('h ' .. m)
		return true
	end
	-- other vim.foo (e.g. vim.tbl_map, vim.lsp.foo, ...)
	s, e, m = current_line:find([[(vim%.[%w_%.]+)%(?]])
	if s and s <= cursor_col and cursor_col <= e then
		vim.cmd('h ' .. m)
		return true
	end
	return false
end

-- Mappings. {{{
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
--- }}}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- format on save
	-- use null-ls format instead here
	-- if client.server_capabilities.documentFormattingProvider then
	--   vim.api.nvim_create_autocmd("BufWritePre", {
	--     group = vim.api.nvim_create_augroup("Format", { clear = true }),
	--     buffer = bufnr,
	--     callback = function() vim.lsp.buf.format({ async = true }) end
	--   })
	-- end

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '[lsp][', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', bufopts)
  vim.keymap.set('n', '[lsp]]', '<Cmd>Lspsaga diagnostic_jump_next<CR>', bufopts)
	vim.keymap.set('n', '[lsp]D', vim.lsp.buf.declaration, bufopts)
	-- vim.keymap.set('n', '[lsp]d', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', '[lsp]d', '<Cmd>Lspsaga peek_definition<CR>', bufopts)
	vim.keymap.set('n', '[lsp]i', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '[lsp]f', '<Cmd>Lspsaga lsp_finder<CR>', bufopts)
	vim.keymap.set('n', 'K', function() -- https://scrapbox.io/vim-jp/better_K_for_neovim_lua
		if not lua_help() then
			vim.lsp.buf.hover()
		end
	end, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	-- vim.keymap.set('n', '[lsp]tD', vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '[lsp]r', '<Cmd>Lspsaga rename<CR>', bufopts)
	-- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '[lsp]c', '<Cmd>Lspsaga code_action<CR>', bufopts)
	-- vim.keymap.set('n', '[lsp]r', vim.lsp.buf.references, bufopts)
	-- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end
--- }}}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers.. {{{
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
	print('cmp-nvim-lsp is not installed')
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
--- }}}

--- mason lspconfig {{{
mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
	['sumneko_lua'] = function()
		lspconfig.sumneko_lua.setup({
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { 'vim' } },
				},
			},
		})
	end,
	['tsserver'] = function()
		lspconfig.tsserver.setup({
			on_attach = on_attach,
			filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
			cmd = { 'typescript-language-server', '--stdio' },
			settings = {
				format = { enable = false },
			},
		})
	end,
	['eslint'] = function()
		lspconfig.tsserver.setup({
			settings = {
				format = { enable = true },
			},
		})
	end,
})
--- }}}
