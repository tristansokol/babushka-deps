#!/usr/bin/env bash

# loosly copied from Paul Irish's dotfiles.

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Edit: ALLOW automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool false


###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true
# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300


###############################################################################
# Screen                                                                      #
###############################################################################


# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true


###############################################################################
# Finder                                                                      #
###############################################################################

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show hidden files by default
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Show item info to the bottom of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist

# # Enable snap-to-grid for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
#
# # Increase grid spacing for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
#
# # Increase the size of icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
# defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Enable the MacBook Air SuperDrive on any Mac
sudo nvram boot-args="mbasd=1"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true


  ###############################################################################
  # Dock, Dashboard, and hot corners                                            #
  ###############################################################################

  # Enable highlight hover effect for the grid view of a stack (Dock)
  defaults write com.apple.dock mouse-over-hilite-stack -bool true

  # Set the icon size of Dock items to 72 pixels
  defaults write com.apple.dock tilesize -int 72

  # Change minimize/maximize window effect
  defaults write com.apple.dock mineffect -string "scale"

  # Minimize windows into their application’s icon
  defaults write com.apple.dock minimize-to-application -bool false

  # Enable spring loading for all Dock items
  defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

  # Show indicator lights for open applications in the Dock
  defaults write com.apple.dock show-process-indicators -bool true

  # Show only open applications in the Dock
  #defaults write com.apple.dock static-only -bool true

  # Don’t animate opening applications from the Dock
  defaults write com.apple.dock launchanim -bool false

  # Speed up Mission Control animations
  defaults write com.apple.dock expose-animation-duration -float 0.1

  # Don’t group windows by application in Mission Control
  # (i.e. use the old Exposé behavior instead)
  defaults write com.apple.dock expose-group-by-app -bool false

  # Disable Dashboard
  defaults write com.apple.dashboard mcx-disabled -bool true

  # Don’t show Dashboard as a Space
  defaults write com.apple.dock dashboard-in-overlay -bool true

  # Don’t automatically rearrange Spaces based on most recent use
  defaults write com.apple.dock mru-spaces -bool false

  # # Remove the auto-hiding Dock delay
  # defaults write com.apple.dock autohide-delay -float 0
  # # Remove the animation when hiding/showing the Dock
  # defaults write com.apple.dock autohide-time-modifier -float 0

  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  # Don't make Dock icons of hidden applications translucent
  defaults write com.apple.dock showhidden -bool false


  # Disable the Launchpad gesture (pinch with thumb and three fingers)
  #defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

  # Reset Launchpad, but keep the desktop wallpaper intact
  #find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

  # Add iOS Simulator to Launchpad
  #sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/iOS Simulator.app" "/Applications/iOS Simulator.app"

  # Hot corners
  # Possible values:
  #  0: no-op
  #  2: Mission Control
  #  3: Show application windows
  #  4: Desktop
  #  5: Start screen saver
  #  6: Disable screen saver
  #  7: Dashboard
  # 10: Put display to sleep
  # 11: Launchpad
  # 12: Notification Center


  # Top left screen corner → Put to sleep
  defaults write com.apple.dock wvous-tl-corner -int 10
  defaults write com.apple.dock wvous-tl-modifier -int 0
  # Top right screen corner → no-op
  defaults write com.apple.dock wvous-tr-corner -int 1
  defaults write com.apple.dock wvous-tr-modifier -int 1048576
  # Bottom left screen corner → no-op
  defaults write com.apple.dock wvous-bl-corner -int 1
  defaults write com.apple.dock wvous-bl-modifier -int 1048576
  # Bottom right screen corner → no-op
  defaults write com.apple.dock wvous-br-corner -int 1
  defaults write com.apple.dock wvous-br-modifier -int 1048576
  ###############################################################################
  # Spotlight                                                                   #
  ###############################################################################

  # Hide Spotlight tray-icon (and subsequent helper)
  #sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
  # Disable Spotlight indexing for any volume that gets mounted and has not yet
  # been indexed before.
  # Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
  sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
  # Change indexing order and disable some search results
  # Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
  # 	MENU_DEFINITION
  # 	MENU_CONVERSION
  # 	MENU_EXPRESSION
  # 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
  # 	MENU_WEBSEARCH             (send search queries to Apple)
  # 	MENU_OTHER
  defaults write com.apple.spotlight orderedItems -array \
  	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
  	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
  	'{"enabled" = 1;"name" = "PDF";}' \
  	'{"enabled" = 1;"name" = "FONTS";}' \
  	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
  	'{"enabled" = 0;"name" = "MESSAGES";}' \
  	'{"enabled" = 0;"name" = "CONTACT";}' \
  	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
  	'{"enabled" = 0;"name" = "IMAGES";}' \
  	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
  	'{"enabled" = 0;"name" = "MUSIC";}' \
  	'{"enabled" = 0;"name" = "MOVIES";}' \
  	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  	'{"enabled" = 0;"name" = "SOURCE";}' \
  	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
  	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
  # Load new settings before rebuilding the index
  killall mds > /dev/null 2>&1
  # Make sure indexing is enabled for the main volume
  sudo mdutil -i on / > /dev/null
  # Rebuild the index from scratch
  sudo mdutil -E / > /dev/null

  ###############################################################################
  # Terminal & iTerm 2                                                          #
  ###############################################################################

  # Only use UTF-8 in Terminal.app
  defaults write com.apple.terminal StringEncodings -array 4

  # Enable “focus follows mouse” for Terminal.app and all X11 apps
  # i.e. hover over a window and start typing in it without clicking first
  #defaults write com.apple.terminal FocusFollowsMouse -bool true
  #defaults write org.x.X11 wm_ffm -bool true

  # Enable Secure Keyboard Entry in Terminal.app
  # See: https://security.stackexchange.com/a/47786/8918
  defaults write com.apple.terminal SecureKeyboardEntry -bool true

  ###############################################################################
  # Activity Monitor                                                            #
  ###############################################################################

  # Show the main window when launching Activity Monitor
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

  # Visualize CPU usage in the Activity Monitor Dock icon
  defaults write com.apple.ActivityMonitor IconType -int 6

  # Show all processes in Activity Monitor
  defaults write com.apple.ActivityMonitor ShowCategory -int 0

  # Sets columns for all tabs
  defaults read com.apple.ActivityMonitor "UserColumnsPerTab v5.0" -dict \
      '0' '( Command, CPUUsage, CPUTime, Threads, PID, UID, Ports )' \
      '1' '( Command, ResidentSize, Threads, Ports, PID, UID,  )' \
      '2' '( Command, PowerScore, 12HRPower, AppSleep, UID, powerAssertion )' \
      '3' '( Command, bytesWritten, bytesRead, Architecture, PID, UID, CPUUsage )' \
      '4' '( Command, txBytes, rxBytes, PID, UID, txPackets, rxPackets, CPUUsage )'

  # Set sort column
  defaults write com.apple.ActivityMonitor UserColumnSortPerTab -dict \
      '0' '{ direction = 0; sort = CPUUsage; }' \
      '1' '{ direction = 0; sort = ResidentSize; }' \
      '2' '{ direction = 0; sort = 12HRPower; }' \
      '3' '{ direction = 0; sort = bytesWritten; }' \
      '4' '{ direction = 0; sort = rxBytes; }'
  defaults write com.apple.ActivityMonitor SortDirection -int 0

  # Show Data in the Disk graph (instead of IO)
  defaults write com.apple.ActivityMonitor DiskGraphType -int 1

  # Show Data in the Network graph (instead of packets)
  defaults write com.apple.ActivityMonitor NetworkGraphType -int 1

  ###############################################################################
  # Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
  ###############################################################################

  # Enable the debug menu in Address Book
  defaults write com.apple.addressbook ABShowDebugMenu -bool true

  # Enable Dashboard dev mode (allows keeping widgets on the desktop)
  defaults write com.apple.dashboard devmode -bool true

  # Enable the debug menu in iCal (pre-10.8)
  defaults write com.apple.iCal IncludeDebugMenu -bool true

  # Use plain text mode for new TextEdit documents
  defaults write com.apple.TextEdit RichText -int 0
  # Open and save files as UTF-8 in TextEdit
  defaults write com.apple.TextEdit PlainTextEncoding -int 4
  defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

  # Enable the debug menu in Disk Utility
  defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
  defaults write com.apple.DiskUtility advanced-image-options -bool true

  # Auto-play videos when opened with QuickTime Player
  defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

  ###############################################################################
  # Mac App Store                                                               #
  ###############################################################################

  # Enable the WebKit Developer Tools in the Mac App Store
  defaults write com.apple.appstore WebKitDeveloperExtras -bool true

  # Enable Debug Menu in the Mac App Store
  defaults write com.apple.appstore ShowDebugMenu -bool true

  ###############################################################################
  # Photos                                                                      #
  ###############################################################################

  # Prevent Photos from opening automatically when devices are plugged in
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

  ###############################################################################
  # Google Chrome & Google Chrome Canary                                        #
  ###############################################################################

  # Allow installing user scripts via GitHub Gist or Userscripts.org
  defaults write com.google.Chrome ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"

  # Use the system-native print preview dialog
  #defaults write com.google.Chrome DisablePrintPreview -bool true
  #defaults write com.google.Chrome.canary DisablePrintPreview -bool true

  # Expand the print dialog by default
  defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

  ###############################################################################
  # Transmission.app                                                            #
  ###############################################################################

  # Don’t prompt for confirmation before downloading
  # defaults write org.m0k.transmission DownloadAsk -bool false
  # defaults write org.m0k.transmission MagnetOpenAsk -bool false

  # Trash original torrent files
  # defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

  # Hide the donate message
  # defaults write org.m0k.transmission WarningDonate -bool false
  # Hide the legal disclaimer
  # defaults write org.m0k.transmission WarningLegal -bool false

  # IP block list.
  # Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
  # defaults write org.m0k.transmission BlocklistNew -bool true
  # defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
  # defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
  #
  echo "Done. Note that some of these changes require a logout/restart to take effect."
