dep 'yarn' do
  met? {
    shell?('which yarn')
  }
  meet do
    log_shell('Installing yarn', 'brew install yarn')
  end
end
