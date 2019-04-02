dep 'ruby' do
  # Check if ruby is homebrewed not mac default of /usr/bin/ruby
  met?{"which ruby".inclue? "local"}
  meet{
    shell "brew install ruby"
  }
end
