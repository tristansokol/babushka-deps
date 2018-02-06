dep 'dotfiles' do
  requires 'dotfiles-atom',
  'bash-completion',
  'inputrc',
  'gitconfig',
  'git-completion',
  'git-prompt',
  'git-completion',
  'alias'
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

dep 'make bash_completion.d' do
  requires 'dotfiles-up-to-date'
  met?{
    '~/.bash_completion.d'.p.exists?
  }
  meet{
    log_shell "making the bash_completion.d directory","mkdir ~/.bash_completion.d"
  }
end

dep 'git-completion' do
  requires 'make bash_completion.d'
  met?{
    '~/.bash_completion.d/git-completion.bash'.p.exists?
  }
  meet{
    log_shell "Downloading git-completion from the source","curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.bash_completion.d/git-completion.bash"
  }
end
dep 'git-prompt' do
  requires 'make bash_completion.d'
  met?{
    '~/.bash_completion.d/git-prompt.sh'.p.exists?
  }
  meet{
    log_shell "Downloading git-prompt from the source","curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.bash_completion.d/git-prompt.sh"
  }
end

dep 'gitconfig' do

  log("FIGURE OUT HOW TO INSTALL GITCONFIG")
  met?{false}
end

dep 'alias' do
  # this probably doesn't have to do anything.
end
