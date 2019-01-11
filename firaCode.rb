dep 'FiraCode' do
  requires 'FiraCode-font', 'terminal preferences'
end

# I do not understand how this works, need to test on new machine?
dep 'FiraCode-font' do
  met? shell 'system_profiler SPFontsDataType | grep FiraCode'
  meet {
    shell 'git clone ~/Downloads/firacode'
    shell 'cp ~/Downloads/firacode/dist/ttf/*.ttf /Library/Fonts/'
   }
end

#dep 'atom preferences' do
#  met? File.read(File.expand_path('~/.atom/config.cson')).include? 'fontFamily: "FiraCode-Light"'
#end

# doesn't seem to permanently change it? Also met? doesn't make any sense.
dep 'terminal preferences' do
  met? shell 'defaults read com.apple.Terminal'
  meet do
    log_shell 'changing Terminal font to Fira Code', "osascript -e 'tell application" + ' "Terminal" to set the font name of window 1' + " to \"Fira Code Retina\"'"
  end
end
