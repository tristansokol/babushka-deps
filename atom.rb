dep 'atom' do
  requires 'Atom.app', 'atom symlink'
end

dep 'Atom.app' do
  source 'https://github.com/atom/atom/releases/download/v1.23.3/atom-mac.zip'
end

dep 'atom symlink' do
  requires 'Atom.app'
  met? { which 'atom' }
  meet {shell "ln -sf /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin/atom"}
end
