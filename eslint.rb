dep 'eslint' do
  requires "npm"
  met?{"which eslint"}
  meet{
    shell "npm install -g eslint"
  }
end
