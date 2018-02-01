dep 'dotfiles' do
  requires 'dotfiles-atom'
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
