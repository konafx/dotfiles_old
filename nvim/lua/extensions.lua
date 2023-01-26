local create_user_command = vim.api.nvim_create_user_command

-- json parser
if vim.fn.executable('jq') then
	create_user_command('Jq', function(opts)
		local arg = '.'
		if not opts.fargs[1] then
			arg = opts.fargs[1]
		end
		vim.cmd([[%! jq ']] .. arg .. [[']])
	end, { nargs = '?' })
end

-- QuickFixGrep {{{
-- require setting [[au QuickFixCmdPost make,*grep* cwindow]]
if vim.fn.executable('git') then
	create_user_command('Ggrep', function(opts)
		local current_grepprg = vim.o.grepprg
		vim.opt_local.grepprg = 'git grep -I --line-number'
		vim.cmd('silent grep! ' .. opts.args)
		vim.opt_local.grepprg = current_grepprg
		vim.cmd('redraw!')
	end, { nargs = 1 })
end

if vim.fn.executable('rg') then
	create_user_command('Rgrep', function(opts)
		local current_grepprg = vim.o.grepprg
		local current_grepformat = vim.o.grepformat
		vim.opt_local.grepprg = 'rg --vimgrep --hidden'
		vim.opt_local.grepformat = '%f:%l:%c:%m'
		vim.cmd('silent grep! ' .. opts.args)
		vim.opt_local.grepprg = current_grepprg
		vim.opt_local.grepformat = current_grepformat
		vim.cmd('redraw!')
	end, { nargs = 1 })
end

if vim.fn.executable('jvgrep') then
	create_user_command('Jvgrep', function(opts)
		local current_grepprg = vim.o.grepprg
		vim.opt_local.grepprg = 'jvgrep'
		vim.cmd('silent grep! ' .. opts.args .. ' ./*')
		vim.opt_local.grepprg = current_grepprg
		vim.cmd('redraw!')
	end, { nargs = 1 })
end
-- }}}
