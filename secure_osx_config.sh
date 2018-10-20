#!/usr/bin/sh
# 
# Secure configuration script for OSX

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

echo "Secure configuration complete"

#------END OF SCRIPT-------
#MANUAL STEPS THAT REQUIRE ADDITIONAL USER INPUT
#DO NOT UNCOMMENT THIS SECTION!!!

#Enable Disk Encryption
#fdesetup enable


