# TODO: Follow changes in mise
if [[ ! -r $ZHOMEDIR/completion.local/_mise ]]; then
	command -v $LOCAL_BIN_DIR/mise && \
		command $LOCAL_BIN_DIR/mise activate zsh \
		> $ZHOMEDIR/completion.local/_mise
fi
