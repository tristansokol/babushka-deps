dep 'FiraCode' do
  requires 'FiraCode-font', 'atom preferences', 'terminal preferences'
end

# I do not understand how this works, need to test on new machine?
dep 'FiraCode-font' do
  # source 'https://github.com/tonsky/FiraCode.git'
end

dep 'atom preferences' do
  met? File.read(File.expand_path('~/.atom/config.cson')).include? "fontFamily: \"FiraCode-Light\""
end

# doesn't seem to permanently change it? Also met? doesn't make any sense.
dep 'terminal preferences' do
  met? shell "defaults read com.apple.Terminal"
  meet {log "changing font to Didot"
    shell "osascript -e 'tell application"+" \"Terminal\" to set the font name of window 1"+" to \"Fira Code Retina\"'"
  }

end
