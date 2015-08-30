#!/bin/bash

DFILEDIR=`pwd`
BASHRC=".bashrc"
# install some necessary packages
uname -a | grep -il darwin
if [ $? -eq 0 ]
then
  brew update
  brew upgrade
  brew install tmux
  brew install the_silver_searcher
  brew install findutils --default-names
  brew install gnu-sed --default-names
  brew install gnu-tar --default-names
  brew install gnu-which --default-names
  brew install gnutls --default-names
  brew install grep --default-names
  brew install coreutils
  brew install binutils
  brew install diffutils
  brew install gzip
  brew install wget
  brew install htop
  brew tap homebrew/science
  brew install gcc
  brew install Caskroom/cask/xquartz
  brew install r --with-openblas
  brew install vim --override-system-vi
  BASHRC=".bash_profile"
else
  sudo deb http://lib.stat.cmu.edu/R/CRAN//bin/linux/ubuntu trusty/ # add R repo
  sudo apt-add-repository -y "deb http://repository.spotify.com stable non-free" # add spotify repo
  sudo add-apt-repository -y ppa:chromium-daily/stable # add chromium repo
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 # add R key
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 # add spotify key
  sudo apt-get update
  sudo apt-get install vim-gtk r-base-dev littler conky tmux chromium-browser \
                       arandr curl htop silversearcher-ag
fi

# install rvm and ruby versions
\curl -sSL https://get.rvm.io | bash
rvm install ruby-1.9
rvm install jruby

# install git smart-pull
gem install git-smart

# install vim pathogen and packages
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle && \
  curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd $HOME/.vim/bundle
git clone https://github.com/altercation/vim-colors-solarized.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/Lokaltog/vim-powerline.git
git clone https://github.com/derekwyatt/vim-scala.git
git clone https://github.com/vim-ruby/vim-ruby.git

# customize bashrc
echo "source $DFILEDIR/aliases" >> $HOME/$BASHRC
echo "source $DFILEDIR/bashcustom" >> $HOME/$BASHRC
