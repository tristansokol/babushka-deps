dep 'dotfiles' do
  requires 'dotfiles-atom',
  'bash-completion',
  'inputrc',
  'gitconfig',
  'git-completion'
end

dep 'dotfiles-repo' do
  met? {
    log "checking for dotfile repo"
    File.exists? File.expand_path('~/dotfiles')
}
  meet{
    log_shell "Cloning new your dotfile repo to ~/dotfiles","git clone git@github.com:tristansokol/dotfiles.git ~/dotfiles"
  }
end

dep 'dotfiles-up-to-date' do
  requires 'dotfiles-repo'
  met?{
    shell "cd ~/dotfiles && git remote update && git status | grep \"Your branch is up to date with\""
  }
  meet{
    log_shell "copying outdated dotfiles to ~/dotfiles_old/ and updating dotfiles repo", "cp -rf ~/dotfiles/ ~/dotfiles_old/ && cd ~/dotfiles && git fetch --all && git reset --hard origin/master"
  }
end

dep 'symlink-bash_completion.d' do
  requires 'dotfiles-up-to-date'
  met?{
    '~/.bash_completion.d'.p.exists?
  }
  meet{
    log_shell "symlinking the .bash_completion.d directory","ln -s ~/dotfiles/bash_completion.d ~/bash_completion"
  }
end

# Add the git completion to the the local folder, but this might not work
dep 'git-completion' do
  requires 'symlink-bash_completion.d'
  met?{
    '~/.bash_completion.d/git-completion.bash'.p.exists?
  }
  meet{
    log_shell "Downloading git-completion from the source","curl -o ~/dotfiles/bash-completion.d/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
  }
end


dep 'gitconfig' do
  log("FIGURE OUT HOW TO INSTALL GITCONFIG")
end
