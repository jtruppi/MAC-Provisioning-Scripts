#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
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
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names

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
    gimp
    hub
    jq
    nmap
    npm
    openssl
    pkg-config
    python
    python3
    rename
    terminal-notifier
    tmux
    tree
    vim
    wget
    wireshark
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

brew install curl --with-openssl

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
    1password
    amazon-workspaces
    brave
    db-browser-for-sqlite
    dd-utility
    encryptme
    flux
    google-chrome
    gpgtools
    screen
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
    font-inconsolidata
    font-roboto
    font-clear-sans
)
brew cask install ${FONTS[@]}

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

echo "Configuring OSX to General and Security standard..."

####SPEED
# Disable animations when opening and closing windows
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable animations when opening from Dock
defaults write com.apple.dock launchanim -bool false

# Disable animation when opening Info inside Finder
defaults write com.apple.finder DisableAllAnimations -bool true

####POWER
#Set computer sleep time in minutes
systemsetup -setcomputersleep 30

#Set display sleep time in minutes
systemsetup -setdisplaysleep 15

####INPUTS
# Set fast key repeat rate
#defaults write NSGlobalDomain KeyRepeat -int 0

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable crash reporter
#defaults write com.apple.CrashReporter DialogType none

####UI
# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

####SECURITY
# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Turn remote login (SSH) OFF or ON
systemsetup -setremotelogin off

# Enable Gatekeeper for application code signing installs
spctl --master-enable



echo "Creating folder structure..."
[[ ! -d Workspace ]] && mkdir Workspace

echo "Bootstrapping complete"

#------END OF SCRIPT-------
#MANUAL STEPS THAT REQUIRE ADDITIONAL USER INPUT
#DO NOT UNCOMMENT THIS SECTION!!!

#Enable Disk Encryption
#fdesetup enable


