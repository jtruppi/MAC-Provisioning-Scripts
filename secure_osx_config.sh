#!/usr/bin/sh
# 
# Secure configuration script for OSX
# Version Check
#MACVER=$(sw_vers)
MACVER=$(sw_vers | grep "ProductVersion:" | awk '{print $2}' | awk -F"." '{print $1"."$2}')

if [ $MACVER=="10.14" ]
then
	echo "Mojave"
elif [ $MACVER=="10.13" ]
then
	echo "High Sierra"
elif [ $MACVER=="10.12" ]
then
	echo "Sierra"
elif [ $MACVER=="10.11" ]
then
	echo "El Capitan"
elif [ $MACVER=="10.10" ]
then
	echo "Yosemite"
else
	echo "Below 10.10"
fi

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

##CONFIRMED FOR 10.14 CIS Benchmarks
#Enable Automatic Updates
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -int 1

#Enable App updates install
defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool TRUE

#Turn Bluetooth off by default
defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0

#Eanble Find My Mac
defaults write /Library/Preferences/com.apple.FindMyMac FMMEnabled -int 1

#------END OF SCRIPT-------
#MANUAL STEPS THAT REQUIRE ADDITIONAL USER INPUT
#DO NOT UNCOMMENT THIS SECTION!!!

#Enable Disk Encryption
#fdesetup enable


