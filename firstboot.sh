#!/bin/bash

# install some necessary packages
deb http://lib.stat.cmu.edu/R/CRAN//bin/linux/ubuntu trusty/ # add R repo
apt-add-repository -y "deb http://repository.spotify.com stable non-free" # add spotify repo
add-apt-repository -y ppa:chromium-daily/stable # add chromium repo
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 # add R key
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 # add spotify key
apt-get update
apt-get update
apt-get install vim-gtk r-base-dev littler conky tmux chromium-browser \
                arandr curl htop silversearcher-ag

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
cd ~/.vim/bundle
git clone https://github.com/altercation/vim-colors-solarized.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com:Lokaltog/vim-powerline.git
git clone https://github.com:derekwyatt/vim-scala.git

# customize bashrc
echo "source `pwd`/bashcustom" >> $HOME/.bashrc
