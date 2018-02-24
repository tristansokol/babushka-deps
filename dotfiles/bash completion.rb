dep 'bash-completion' do
  # if the bash version info variable is 3
  if raw_shell("echo $BASH_VERSINFO").stdout.strip! ==3.to_s
met?{shell?('brew list | grep bash-completion')}
meet{
   "brew install bash-completion"
 }
elsif raw_shell("echo $BASH_VERSINFO").stdout.strip! >=4.to_s
  met?{shell?('brew list | grep bash-completion2')}
  meet{
     shell "brew tap homebrew/versions"
     shell "brew install bash-completion2"
   }
  end
end

dep 'npm-completion' do
  requires 'make bash_completion.d','npm'
  met?{'~/.bash_completion.d/npm'.p.exists?}
  meet{
    log_shell "creating npm completion file","npm completion >>~/.bash_completion.d/npm"
  }
end
# met? { shell?('blah blah | grep b') }
