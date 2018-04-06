dep 'lolcat' do
  met? {
    shell?('which lolcat')
  }
  meet do
    log_shell('Installing lolcat', 'gem install lolcat')
  end
end
