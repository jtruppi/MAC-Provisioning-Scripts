#!/usr/bin/sh
# 
# Secure configuration script for OSX

# Set default user
USER="user"
# Version Check
MACVER=$(sw_vers | grep "ProductVersion:" | awk '{print $2}' | awk -F"." '{print $1"."$2}')
NOCONFIG="UNKNOWN CONFIG FOR"

if [ $MACVER=="10.14" ]
then
	echo "Mojave"
	#Insert OS-specific configs here
	
elif [ $MACVER=="10.13" ]
then
	echo "High Sierra"
	#Insert OS-specific configs here
	
elif [ $MACVER=="10.12" ]
then
	echo "Sierra"
	#Insert OS-specific configs here
	
elif [ $MACVER=="10.11" ]
then
	echo "El Capitan"
	#Insert OS-specific configs here
	
elif [ $MACVER=="10.10" ]
then
	echo "$NOCONFIG Yosemite"
else
	echo "$NOCONFIG Below OSX 10.10"
fi

##### UNIVERSAL COMMANDS #####
#
####POWER
echo "SETTING UNIVERSAL CONFIGURATIONS..."
# Set computer sleep time in minutes
systemsetup -setcomputersleep 30

# Set display sleep time in minutes
systemsetup -setdisplaysleep 15

# Set time servers
systemsetup -setnetworktimeserver pool.ntp.org
systemsetup -setusingnetworktime on

# Disable Wake on LAN
pmset -a womp 0


####SPEED
# Disable animations when opening from Dock
defaults write com.apple.dock launchanim -bool false

# Disable animation when opening Info inside Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# Disable animations when opening and closing windows
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false


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


####PRIVACY
# Disable Apple analytics
defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmit -int 0
defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist ThirdPartyDataSubmit -int 0


####AUDITING
# Update Auditd flags (requires restart)
sed -i '''' 's/flags.*/flags:lo,ad,fd,fm,-all/g' /etc/security/audit_control
sed -i '''' 's/expire-after.*/expire-after:1G/g' /etc/security/audit_control


####SECURITY
# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable screensaver sleep 10 min
defaults -currentHost write com.apple.screensaver idleTime -int 600

# Enable Automatic Updates
defaults write com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -int 1

# Enable App updates install
defaults write com.apple.commerce AutoUpdate -bool TRUE

# Disable Bluetooth by default
defaults write com.apple.Bluetooth ControllerPowerState -int 0

# Enable Find My Mac
defaults write com.apple.FindMyMac FMMEnabled -int 1

# Enable Gatekeeper for application code signing installs
spctl --master-enable

# Disable NFS
nfsd disable

# Disable remote Apple events
systemsetup -setremoteappleevents off

# Disable Apple Screen Sharing
defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist com.apple.screensharing -dict Disabled -bool TRUE

# Disable Apache Server
defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist org.apache.httpd -dict Disabled -bool TRUE

# Enable firewall for specific services
defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Enable firewall stealthmode (do not respond to ICMP)
defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1
/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Enable firewall logging
/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on

# Enable secure keyboard entry in Terminal App
defaults write com.apple.Terminal SecureKeyboardEntry -int 1

# Turn remote login (SSH) OFF or ON
systemsetup -setremotelogin off

echo "SECURE CONFIGURATION COMPLETE"

#------END OF SCRIPT-------
#MANUAL STEPS THAT REQUIRE ADDITIONAL USER INPUT
#DO NOT UNCOMMENT THIS SECTION!!!

# Enable Disk Encryption
#fdesetup enable

# Look for shared printers
#system_profiler SPPrintersDataType | egrep "Shared: Yes"

# Review Bluetooth sharing
#system_profiler SPBluetoothDataType | grep State

# List allowed firewall apps
#/usr/libexec/ApplicationFirewall/socketfilterfw --listapps

# List Apps using location services
#sudo defaults read /var/db/locationd/clients.plist


