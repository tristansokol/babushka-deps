dep 'apps' do
  requires 'Postman.app',
        'Spectacle.app',
        'LastPass.app',
        'Hex Fiend.app',
        'Disk Inventory X.app',
        'iTerm.app',
        'Visual Studio Code.app'
end

dep 'Postman.app' do
  source 'https://dl.pstmn.io/download/latest/osx'
end

dep 'Spectacle.app' do
  source 'https://s3.amazonaws.com/spectacle/downloads/Spectacle+1.2.zip'
end


dep 'LastPass.app' do
  source 'https://download.cloud.lastpass.com/mac/lpmacosx.zip'
end

dep 'Hex Fiend.app'do
  source 'http://ridiculousfish.com/hexfiend/files/Hex_Fiend_2.5.dmg'
end

dep 'Disk Inventory X.app' do
  source 'http://www.derlien.com/download.php?file=DiskInventoryX'
end

dep 'Visual Studio Code.app' do
  source 'https://go.microsoft.com/fwlink/?LinkID=620882'
end

dep 'iTerm.app' do
  source "https://iterm2.com/downloads/stable/latest"
end
