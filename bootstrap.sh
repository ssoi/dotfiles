#!/bin/bash

# install some necessary packages
sudo apt-get install git vim r-core-dev

# install rvm and ruby versions
\curl -sSL https://get.rvm.io | bash
rvm install ruby-1.9
rvm install jruby
rvm use ruby-1.9

# install git smart-pull
gem install git-smart

# install vim pathogen and packages
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
