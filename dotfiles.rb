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

dep 'dotfiles-atom' do
    requires 'dotfiles-up-to-date'
  met?{
    log "seeing if ~./atom is symbolically linked"
    !raw_shell("find ~/.atom -type l").stdout.empty?
  }
  meet{
    log_shell "moving ~/.atom → ~/dotfiles/atom", "mv ~/.atom ~/dotfiles/atom"
    log_shell "symlinking ~/dotfiles/atom → ~/.atom", "ln -fs ~/dotfiles/atom ~/.atom"
  }
end

dep 'git' do
  requires 'bash-completion'
end


dep 'bash-completion' do
  # if the bash version info variable is 3
  if raw_shell("echo $BASH_VERSINFO").stdout.strip! ==3.to_s
met?{"brew list | grep bash-completion"}
meet{
   "brew install bash-completion"
 }
elsif raw_shell("echo $BASH_VERSINFO").stdout.strip! >=4.to_s
  met?{"brew list | grep bash-completion2"}
  meet{
     shell "brew tap homebrew/versions"
     shell "brew install bash-completion2"
   }
  end
end

dep 'inputrc' do
  requires 'dotfiles-up-to-date'
  met?{ '~/.inputrc'.p.exists?}
  meet{
    log_shell "symlinking .inputrc from dotfiles repo","ln -s ~/dotfiles/shell/inputrc ~/.inputrc"
  }
end

dep 'gitconfig' do
  log("FIGURE OUT HOW TO INSTALL GITCONFIG")
end

dep 'git-completion' do
  log("FIGURE OUT HOW TO INSTALL this bash completion")
  # https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
end
