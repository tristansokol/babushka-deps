dep 'lolcommits' do
  requires 'imagemagick'
  met? {
    shell?('which lolcommits')
  }
  meet do
    log_shell('Installing lolcommits', 'sudo gem install lolcommits')
  end
end
