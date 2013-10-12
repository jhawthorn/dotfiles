cd ruby-install
export NO_INSTALL_DEPS=1
export CFLAGS="-O3 -march=native -g"

bin/ruby-install ruby 2.0.0
bin/ruby-install ruby 1.9.3
bin/ruby-install ruby 2.1.0
