dep 'dotfiles' do
  requires 'dotfiles-atom',
           'make bash_completion.d',
           'inputrc',
           'gitdotfiles',
           'alias'
end

dep 'dotfiles-repo' do
  met? do
    log 'checking for dotfile repo'
    File.exist? File.expand_path('~/dotfiles')
  end
  meet do
    log_shell 'Cloning new your dotfile repo to ~/dotfiles', 'git clone git@github.com:tristansokol/dotfiles.git ~/dotfiles'
  end
end

dep 'dotfiles-up-to-date' do
  requires 'dotfiles-repo'
  met? do
    shell 'cd ~/dotfiles && git remote update && git status | grep "Your branch is up to date with"'
  end
  meet do
    log_shell 'copying outdated dotfiles to ~/dotfiles_old/ and updating dotfiles repo', 'cp -rf ~/dotfiles/ ~/dotfiles_old/ && cd ~/dotfiles && git fetch --all && git reset --hard origin/master'
  end
end

dep 'make bash_completion.d' do
  requires 'dotfiles-up-to-date'
  met? { '~/.bash_completion.d'.p.exists? }
  meet do
    log_shell 'making the bash_completion.d directory', 'mkdir ~/.bash_completion.d'
  end
end

dep 'alias' do
  # this probably doesn't have to do anything.
end
