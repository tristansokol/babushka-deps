dep 'quicklook' do
 requires 'qlcolorcode.qlplugin',
 'qlstephen.qlplugin',
 'qlmarkdown.qlplugin',
 'quicklook-json.qlplugin'
end

meta :qlplugin do
  accepts_value_for :name

  template do
    met? do
      log_shell "seeing if the QuickLook plugin #{name} is intalled", "brew cask list | grep #{name}"
    end
    meet do
      log_shell "installing #{name} with brew", "brew cask install #{name}"
    end
  end
end

dep 'qlcolorcode.qlplugin' do
  # https://github.com/anthonygelibert/QLColorCode
  name 'qlcolorcode'
end

dep 'qlstephen.qlplugin' do
  # https://github.com/whomwah/qlstephen
  name 'qlstephen'
end

dep 'qlmarkdown.qlplugin' do
  # https://github.com/toland/qlmarkdown
  name 'qlmarkdown'
end

dep 'quicklook-json.qlplugin' do
  # http://www.sagtau.com/quicklookjson.html
  name 'quicklook-json'
end
