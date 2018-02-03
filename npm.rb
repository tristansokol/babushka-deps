dep 'npm' do
  requires 'npm.install'
end

dep 'npm.install' do
  requires 'nodejs.install'
  met? {
    shell?('brew list npm &> /dev/null')
  }
  meet do
    log_shell('Installing npm', 'brew install npm')
  end
end

dep 'nodejs.install' do
  met? {
    shell?('brew list nodejs &> /dev/null')
  }
  meet do
    log_shell('Installing nodejs', 'brew install nodejs')
  end
end
