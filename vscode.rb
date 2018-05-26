dep 'vscode' do
  requires 'Visual Studio Code.app',
           'vscode-settings-symlinked',
           'vscode-keybindings-symlinked',
           'Duplicate.vscodeextension',
           'Ruby.vscodeextension',
           'Markdownlint.vscodeextension',
           'Spell.vscodeextension',
           'importCost.vscodeextension',
           'python.vscodeextension',
           'vetur.vscodeextension'
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
dep 'vscode-keybindings-symlinked' do
  met? do
    log('seeing if vscode keybindings is symbolically linked')
    !raw_shell('find ~/Library/Application\ Support/Code/User/keybindings.json -type l').stdout.empty?
  end
  meet do
    log_shell('copying old keybindings', 'cp -va $HOME/Library/Application\ Support/Code/User/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings-$(date +"%Y%m%d-%H%M%S").json"')
    log_shell 'Deleting old keybindings', 'rm -rf $HOME/Library/Application\ Support/Code/User/keybindings.json'
    log_shell 'symlinking keybindings from dotfiles', 'ln -sf $HOME/dotfiles/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json'
  end
end

meta :vscodeextension do
  accepts_value_for :name
  template do
    requires 'Visual Studio Code.app'
    met? do
      log_shell "seeing if the Visual Studio Code extension #{name} is intalled", "code --list-extensions | grep -i #{name}"
    end
    meet do
      log_shell "installing the #{name} extension", "code --install-extension #{name}"
    end
  end
end

dep 'Duplicate.vscodeextension' do
  name 'mrmlnc.vscode-duplicate'
end

dep 'Ruby.vscodeextension' do
  name 'rebornix.ruby'
end
dep 'Spell.vscodeextension' do
  name 'streetsidesoftware.code-spell-checker'
end

dep 'vetur.vscodeextension' do
  name 'octref.vetur'
end

dep 'importCost.vscodeextension' do
  name 'wix.vscode-import-cost'
end

dep 'python.vscodeextension' do
  name 'ms-python.python'
end


dep 'Markdownlint.vscodeextension' do
  name 'DavidAnson.vscode-markdownlint'
end
