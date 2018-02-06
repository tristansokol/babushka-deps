dep 'imagemagick' do
  requires 'imagemagick.install'
end

dep 'imagemagick.install' do
  met? {
    shell?('brew list imagemagick &> /dev/null')
  }
  meet do
    log_shell('Installing imagemagick', 'brew install imagemagick')
  end
end
