dep 'gpg' do
  met?{shell?('which gpg')}
  meet{
    log_shell "installing gpg","brew install gpg"
  }
end
