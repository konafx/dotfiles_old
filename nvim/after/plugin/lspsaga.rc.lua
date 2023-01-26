local ok, lspsaga = pcall(require, 'lspsaga')
if not ok then
	print('lspsaga is not installed')
	return
end

lspsaga.setup()
