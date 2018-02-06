dep 'config_files' do
  requires 'bash_profile-sourced',
  'bashrc-sourced'
end

# HAVNET GOTTEN THIS WORKING
dep 'bash_profile-sourced' do
  requires 'bash_profile-exists'
  met?{ log_shell "Checking if your .bash_profile sources dotfiles repo", "grep dotfiles ~/.bash_profile"}
  meet{
    log "\e[1m\e[31mWarning: It appears your ~/.bash_profile is missing a line to source ~/dotfiles/shell/bash_profile"
  }
end

dep 'bashrc-sourced'do
requires 'bashrc-exists'
met? { log_shell "Checking if your .bashrc sources dotfiles repo", "grep dotfiles ~/.bashrc"}
meet{
  log "\e[1m\e[31mWarning: It appears your ~/.bashrc is missing a line to source ~/dotfiles/shell/bashrc"
}
end

dep 'bash_profile-exists' do
  met? { File.exist?("#{ENV['HOME']}/.bash_profile") }
  meet do
    message = <<-MESSAGE.gsub(/[\n\s]+/, ' ')
    Your home directory is missing a .bash_profile  You should install one.
    MESSAGE
    log_shell(message, 'echo') # echo serves no purpose here - just a dummy command
  end
end

dep 'bashrc-exists' do
  met? {File.exist?("#{ENV['HOME']}/.bashrc") }
  meet do
  log_shell "Creating a .bashrc for you, but it probably isn't a good one", "echo 'source  ~/dotfiles/shell/bashrc' > ~/.bashrc"
  end
end
