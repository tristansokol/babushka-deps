dep 'atom' do
  requires 'apm',
           'atom symlink',
           'minimap.atompackage',
           'pigments.atompackage',
           'linter.atompackage',
           'intentions.atompackage',
           'busy-signal.atompackage',
           'color-picker.atompackage',
           'highlight-line.atompackage',
           'teletype.atompackage',
           'atom-beautify.atompackage',
           'atom-live-server.atompackage',
           'linter-csslint.atompackage',
           'linter-htmlhint.atompackage',
           'linter-ruby.atompackage',
           'linter-jshint.atompackage',
           'linter-ui-default.atompackage',
           'atom-material-ui.atompackage',
           'autoclose-html.atompackage',
           'minimap-cursorline.atompackage',
           'minimap-git-diff.atompackage',
           'atom-material-syntax.atompackage',
           'highlight-selected.atompackage',
           'minimap-highlight-selected.atompackage',
           'minimap-pigments.atompackage',
           'symbols-view.atompackage',
           'autocomplete-snippets.atompackage',
           'copy-path.atompackage',
           'linter-eslint.atompackage',
           'docblockr.atompackage',
           'file-icons.atompackage',
           'tree-view-git-status.atompackage',
           'project-view.atompackage',
           'linter-php.atompackage'

end

meta :atompackage do
  accepts_value_for :name

  template do
    requires 'apm'
    met? do
      # change from `apm view` to ls for ludicris speed increase!
      log_shell "seeing if the atom package #{name} is intalled", "ls ~/.atom/packages | grep #{name}"
    end
    meet do
      log_shell "installing #{name} and dependencies", "apm install #{name}"
    end
  end
end

dep 'Atom.app' do
  source 'https://github.com/atom/atom/releases/download/v1.23.3/atom-mac.zip'
end

dep 'atom symlink' do
  requires 'Atom.app'
  met? { which 'atom' }
  meet do
    log_shell 'symlinking atom', 'ln -sf /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin/atom'
  end
end

dep 'apm' do
  requires 'Atom.app'
  met? { which 'apm' }
end
# keeping this pre-template one to remember more about how to do it.
# dep 'atom-package-teletype' do
#   requires 'apm'
#   met? do
#     log_shell 'seeing if the atom package teletype is intalled', 'apm list | grep teletype'
#   end
#   meet do
#     log_shell 'installing teletype', 'apm install teletype'
#   end
# end

dep 'rubocop' do
  met? do
    log_shell 'checking if rubocop is installed', 'gem list rubocop -i'
  end
  meet do
    log_shell 'installing rubocop', 'sudo gem install rubocop'
  end
end

dep 'atom-beautify.atompackage' do
  requires 'rubocop'
  name 'atom-beautify'
end
dep 'atom-live-server.atompackage' do
  name 'atom-live-server'
end
dep 'teletype.atompackage' do
  name 'teletype'
end
dep 'atom-material-syntax.atompackage' do
  name 'atom-material-syntax'
end
dep 'atom-material-ui.atompackage' do
  name 'atom-material-ui'
end
dep 'autoclose-html.atompackage' do
  name 'autoclose-html'
end
dep 'busy-signal.atompackage' do
  name 'busy-signal'
end
dep 'color-picker.atompackage' do
  name 'color-picker'
end
dep 'highlight-line.atompackage' do
  name 'highlight-line'
end
dep 'highlight-selected.atompackage' do
  name 'highlight-selected'
end
dep 'intentions.atompackage' do
  name 'intentions'
end
dep 'linter-csslint.atompackage' do
  name 'linter-csslint'
end
dep 'linter-htmlhint.atompackage' do
  name 'linter-htmlhint'
end
dep 'linter-jshint.atompackage' do
  name 'linter-jshint'
end
dep 'linter-ruby.atompackage' do
  name 'linter-ruby'
end
dep 'linter-ui-default.atompackage' do
  name 'linter-ui-default'
end
dep "pip"do
  met?{shell?"which pip"}
  meet{log("you don't have pip, try reinstalling python with brew")}
end
dep "beautysh" do
  met?{shell?"which beautysh"}
  meet{
    log_shell "installing beautysh with pip","pip install beautysh"
  }
end
dep 'linter.atompackage' do
  requires "beautysh"
  name 'linter'
end
dep 'minimap-cursorline.atompackage' do
  name 'minimap-cursorline'
end
dep 'minimap-git-diff.atompackage' do
  name 'minimap-git-diff'
end
dep 'minimap-highlight-selected.atompackage' do
  name 'minimap-highlight-selected'
end
dep 'minimap-pigments.atompackage' do
  name 'minimap-pigments'
end
dep 'minimap.atompackage' do
  name 'minimap'
end
dep 'pigments.atompackage' do
  name 'pigments'
end
dep 'symbols-view.atompackage' do
  name 'symbols-view'
end
dep 'autocomplete-snippets.atompackage' do
  name 'autocomplete-snippets'
end
dep 'copy-path.atompackage' do
  name 'copy-path'
end
dep 'linter-eslint.atompackage' do
  name 'linter-eslint'
end
dep 'docblockr.atompackage' do
  name 'docblockr'
end
dep 'file-icons.atompackage' do
  name 'file-icons'
end
dep 'tree-view-git-status.atompackage' do
  name 'tree-view-git-status'
end
dep 'project-view.atompackage' do
  name 'project-view'
end
dep 'linter-php.atompackage' do
  name 'linter-php'
end
