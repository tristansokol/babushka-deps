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
  shell('cd ~/dotfiles && git remote update')
  met? do
    raw_shell('git fetch --dry-run').stdout.empty?
  end
  meet do
    log_shell "pulling dotfiles", 'cd ~/dotfiles && git pull'
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
