dep 'config-files' do
  met? { File.exist?("#{ENV['HOME']}/.bash_profile") && File.exist?("#{ENV['HOME']}/.bashrc") }
  meet do
    message = <<-MESSAGE.gsub(/[\n\s]+/, ' ')
    Your home directory is missing either .bash_profile or .bashrc. You should install one.
    MESSAGE
    log_shell(message, 'echo') # echo serves no purpose here - just a dummy command
  end
end
