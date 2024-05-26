local ok, luasnip = pcall(require, 'luasnip')
if not ok then
	print('luasnip is not installed')
	return
end

-- load friendly-snippets
require('luasnip/loaders/from_vscode').lazy_load()

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets('markdown', {
	s('spotify', {
		t([[<iframe style="border-radius:12px" src="https://open.spotify.com/embed/track/]]),
		i(1),
		t(
		[[?utm_source=generator" width="100%" height="152" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>]]),
	}),
	s('album', {
		t([[https://open.spotify.com/album/]]),
		i(1),
	}),
	s('track', {
		t([[https://open.spotify.com/track/]]),
		i(1),
	}),
})
