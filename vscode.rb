dep 'vscode' do
  requires 'Visual Studio Code.app', 'vscode-settings-symlinked'
end

dep 'Visual Studio Code.app' do
  source 'https://vscode-update.azurewebsites.net/latest/darwin/stable'
end

dep 'vscode-settings-symlinked' do
  met? do
    log('seeing if vscode settings is symbolically linked')
    !raw_shell('find ~/Library/Application\ Support/Code/User/settings.json -type l').stdout.empty?
  end
  meet do
    log_shell('copying old settings', 'cp -va $HOME/Library/Application\ Support/Code/User/settings.json "$HOME/Library/Application Support/Code/User/settings-$(date +"%Y%m%d-%H%M%S").json"')
        log_shell 'Deleting old settings', 'rm -rf $HOME/Library/Application\ Support/Code/User/settings.json'
    log_shell 'symlinking settings from dotfiles', 'ln -sf $HOME/dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json'
  end
end
