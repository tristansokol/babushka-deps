dep 'mac-preferences' do
  requires 'dev-folder',
           'hotcorners',
           'duti',
           'menuExtras',
           'savePanel',
           'printPanel',
           'dl-script'
end
# FWIW, this `defaults find` is good at finding some set preferences.
# e.g.    defaults find com.apple.ActivityMonitor
# Sourced in part from .dotfiles of Paul Irish https://github.com/paulirish/dotfiles
#
#

dep "dl-script" do
 met?{"~/.babushka/deps/macPreferences.sh".p.exists?}
 meet{
   shell("curl -o ~/.babushka/deps/macPreferences.sh https://raw.githubusercontent.com/tristansokol/babushka-deps/master/macPreferences.sh")
   `chmod +x ~/.babushka/deps/macPreferences.sh && ~/.babushka/deps/macPreferences.sh`
 }
end


dep 'close-system-preferences' do
  # if the system prefereces pane is open, close it to prevent changes after the fact.
  met? { raw_shell('pgrep -x -- "System Preferences"').stdout.empty? }
  meet do
    shell("osascript -e 'tell application \"System Preferences\" to quit'
")
  end
end

dep 'menuExtras' do
  requires 'close-system-preferences'
  met? do
    raw_shell('defaults read com.apple.systemuiserver menuExtras').stdout.include? '(
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu",
    "/System/Library/CoreServices/Menu Extras/AirPort.menu",
    "/System/Library/CoreServices/Menu Extras/Battery.menu",
    "/System/Library/CoreServices/Menu Extras/Clock.menu"
)'
  end
  meet do
    shell('defaults write com.apple.systemuiserver menuExtras -array \
    	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
    	"/System/Library/CoreServices/Menu Extras/Clock.menu"')
  end
end
dep 'savePanel' do
  requires 'close-system-preferences'
  met? { shell('defaults read NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool') && shell('defaults read NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool') }
  meet do
    shell('defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true')
    shell('defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true')
  end
end
dep 'printPanel' do
  requires 'close-system-preferences'
  met? { shell('defaults read NSGlobalDomain PMPrintingExpandedStateForPrint -bool') && shell('defaults read NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool') }
  meet do
    shell('defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true')
    shell('defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true')
  end
end
dep 'hotcorners' do
  # make the top left hotcorner make the computer go to sleep.
  met? do
    raw_shell('sudo defaults read com.apple.dock.plist wvous-tl-corner').stdout.strip! == '5'
  end
  meet do
    # log_shell "Setting the top left corner to sleepify", "sudo defaults write com.apple.dock.plist wvous-tl-corner -int 5"
    # shell "sudo defaults write com.apple.dock.plist wvous-tl-modifier -int 0"
    # shell "sudo killall -hup cfprefsd"
    # shell "sudo killall -hup Dock"
  end
end

dep 'dev-folder' do
  met? { '~/Development'.p.exists? }
  meet do
    log_shell 'making you a development folder', 'mkdir ~/Development'
  end
end

dep 'exuberant ctags' do
  met? {}
end

dep 'duti' do
  met? { shell?('brew list | grep duti') }
  meet do
    log_shell 'installing duti', 'brew install duti'
    log_shell 'duti-ing the duti file in ~/dotfiles', 'duti ~/dotfiles/dutifile.duti'
  end
end
