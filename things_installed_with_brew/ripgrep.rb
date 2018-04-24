dep 'ripgrep' do
  met? {
    shell?('which rg')
  }
  meet do
    log_shell('Installing ripgrep', 'brew install ripgrep')
  end
end
