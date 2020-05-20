status --is-interactive; and source (anyenv init - --no-rehash fish |psub)
# command -q (anyenv root)/plugins/anyenv-lazyload/bin/anyenv-lazyload
# and status -- is-interactive; and eval "(anyenv lazyload | psub)"

# php-build
set -x PHP_BUILD_EXTRA_MAKE_ARGUMENTS "-j4"
