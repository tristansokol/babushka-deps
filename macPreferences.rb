dep "mac-preferences" do
  requires "dev-folder"
end
dep "hotcorners" do
  #make the top left hotcorner make the computer go to sleep.
  met?{
     raw_shell("sudo defaults read com.apple.dock.plist wvous-tl-corner").stdout.strip! == "5"
}
  meet{
    log_shell "Setting the top left corner to sleepify", "sudo defaults write com.apple.dock.plist wvous-tl-corner -int 5"
    shell "sudo defaults write com.apple.dock.plist wvous-tl-modifier -int 0"
    shell "sudo killall -hup cfprefsd"
    shell "sudo killall -hup Dock"
  }
end

dep 'dev-folder'do
  met?{'~/Development'.p.exists?}
  meet{
    log_shell "making you a development folder",'mkdir ~/Development'
  }
end

dep 'exuberant ctags'do
  met?{}
end
