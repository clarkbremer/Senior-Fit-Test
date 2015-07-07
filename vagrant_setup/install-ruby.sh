 #!/usr/bin/env bash

 source /home/vagrant/.rvm/scripts/rvm
  rvm use --default --install $1

 shift

 if (( $# ))
   then gem install $@
 fi
