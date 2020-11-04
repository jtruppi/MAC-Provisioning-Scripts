#!/usr/bin/sh
# 
# Bootstrap script for setting up a new OSX machine
# 
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
# - You don't need to run as root or sudo. You will be prompted in the script. 
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install gnu-sed
brew install gnu-tar
brew install gnu-indent
brew install gnu-which
brew install grep

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

PACKAGES=(
    ack
    autoconf
    automake
    awk
    gawk
    git
    htop
    hub
    jq
    nmap
    npm
    openssl
    pkg-config
    python
    python3
    jupyter
    rename
    terminal-notifier
    tmux
    tree
    vim
    watch
    wget
    wireshark
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

brew install curl-openssl

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install cask

CASKS=(
    1password
    amazon-workspaces
    brave-browser
    db-browser-for-sqlite
    dd-utility
    encryptme
    evernote
    gimp
    google-chrome
    gpg-suite
    istumbler
    knockknock
    licecap
    postman
    skitch
    skype
    slack
    sublime-text
    virtualbox
    vlc
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
    font-roboto
    font-clear-sans
)
brew cask install ${FONTS[@]}

#Install Pip
sudo python -m ensurepip

#Upgrade Pip
sudo pip install --upgrade pip

echo "Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Installing Ruby gems"
RUBY_GEMS=(
    bundler
    filewatcher
    cocoapods
)
sudo gem install ${RUBY_GEMS[@]}

echo "Installing global npm packages..."
npm install marked -g

#Install locatedb
launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

#echo "Creating folder structure..."
#[[ ! -d Workspace ]] && mkdir Workspace

echo "Bootstrapping complete"
