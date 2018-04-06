dep 'fortune' do
  met? {
    shell?('which fortune')
  }
  meet do
    log_shell('Installing fortune', 'brew install fortune')
  end
end
