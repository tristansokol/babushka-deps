dep 'inputrc' do
  requires 'dotfiles-up-to-date'
  met? { '~/.inputrc'.p.exists? }
  meet do
    log_shell 'symlinking .inputrc from dotfiles repo', 'ln -s ~/dotfiles/shell/inputrc ~/.inputrc'
  end
end
