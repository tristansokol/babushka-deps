dep 'dotfiles' do
  requires 'dotfiles-atom',
           'make bash_completion.d',
           'inputrc',
           'gitdotfiles',
           'bash_profile-sourced',
           'bashrc-sourced'
end

dep 'dotfiles-repo' do
  met? do
    log 'checking for dotfile repo'
    File.exist? File.expand_path('~/dotfiles')
  end
  meet do
    log_shell 'Cloning new your dotfile repo to ~/dotfiles', 'git clone git@github.com:tristansokol/dotfiles.git ~/dotfiles'
  end
end

dep 'dotfiles-up-to-date' do
  requires 'dotfiles-repo'
  shell('cd ~/dotfiles && git remote update')
  met? do
    raw_shell('git fetch --dry-run').stdout.empty?
  end
  meet do
    log_shell "pulling dotfiles", 'cd ~/dotfiles && git pull'
  end
end

dep 'make bash_completion.d' do
  requires 'dotfiles-up-to-date'
  met? { '~/.bash_completion.d'.p.exists? }
  meet do
    log_shell 'making the bash_completion.d directory', 'mkdir ~/.bash_completion.d'
  end
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
    log_shell("Your home directory is missing a .bash_profile  You should install one.", 'echo') # echo serves no purpose here - just a dummy command
  end
end

dep 'bashrc-exists' do
  met? {File.exist?("#{ENV['HOME']}/.bashrc") }
  meet do
  log_shell "Creating a .bashrc for you, but it probably isn't a good one", "echo 'source  ~/dotfiles/shell/bashrc' > ~/.bashrc"
  end
end
