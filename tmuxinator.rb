dep 'tmuxinator' do
  met?{shell?('which tmuxinator')}
  meet{
    log_shell "installing tmuxinator","gem install tmuxinator --user-install"
  }
end
