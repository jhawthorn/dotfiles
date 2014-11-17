
# As of nokogiri 1.6, it will compile its own version of libxml2 and libxslt.
# While this is convenient, it is slower, and uses about 100MB for each
# install. For a development machine (many gemsets, bundle install often) this
# is a better default.
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

# Don't garbage collect as often. Sacrifice some ram.
export RUBY_GC_MALLOC_LIMIT=80000000

source $HOME/.local/share/chruby/chruby.sh
source $HOME/.local/share/chruby/auto.sh
source $HOME/.local/share/bundler-exec/bundler-exec.sh

# Read ~/.ruby-version to determine version
chruby_auto

