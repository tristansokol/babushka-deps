dep 'mac-preferences' do
  requires 'dev-folder',
           'hotcorners',
           'duti'
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
    log_shell "installing duti","brew install duti"
    log_shell "duti-ing the duti file in ~/dotfiles","duti ~/dotfiles/dutifile.duti"
  end
end
