dep 'tmux' do
  met? {
    shell?('which tmux')
  }
  meet do
    log_shell('Installing tmux', 'brew install tmux')
  end
end

dep 'tmux-conf' do
  requires  'dotfiles'
  met? { '~/.tmux.conf'.p.exists? }
  meet do
    log_shell 'symlinking .tmux.conf from dotfiles repo', 'ln -s ~/dotfiles/tmux.conf ~/.tmux.conf'
  end
end

dep 'tmuxinator' do
  requires  'tmux'
  met? { 'which tmuxinator' }
  meet do
    log_shell 'installing tmuxinator', 'gem install tmuxinator'
  end
end

dep 'tmuxinator-storage' do
  met? { '~/.tmuxinator'.p.exists? }
  meet do
    log_shell 'symlinking ~/.tmuxinator from dotfiles repo', 'ln -s ~/dotfiles/tmuxinator ~/.tmuxinator'
  end
end
