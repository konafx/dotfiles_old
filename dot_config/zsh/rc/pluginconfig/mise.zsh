# TODO: Follow changes in mise
if [[ ! -r $ZHOMEDIR/completions.local/_mise ]]; then
	mise completion zsh > $ZHOMEDIR/completions.local/_mise
fi
