dep 'dotfiles-atom' do
    requires 'dotfiles-up-to-date'
  met?{
    log "seeing if ~/.atom is symbolically linked"
    !raw_shell("find ~/.atom -type l").stdout.empty?
  }
  meet{
    if File.exist?('~/.atom')
        log_shell "moving ~/.atom → ~/dotfiles/atom", "mv ~/.atom ~/dotfiles/atom"
    end
    log_shell "symlinking ~/dotfiles/atom → ~/.atom", "ln -fs ~/dotfiles/atom ~/.atom"
  }
end
