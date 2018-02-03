
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
