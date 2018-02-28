dep 'gitdotfiles' do
  requires 'git-completion',
           'git-prompt',
           'gitconfig',
           'gitignore'
end

dep 'git-completion' do
  requires 'make bash_completion.d'
  met? do
    '~/.bash_completion.d/git-completion.bash'.p.exists?
  end
  meet do
    log_shell 'Downloading git-completion from the source', 'curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.bash_completion.d/git-completion.bash'
  end
end
dep 'git-prompt' do
  requires 'make bash_completion.d'
  met? do
    '~/.bash_completion.d/git-prompt.sh'.p.exists?
  end
  meet do
    log_shell 'Downloading git-prompt from the source', 'curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.bash_completion.d/git-prompt.sh'
  end
end

dep 'gitconfig' do
  met?{
    log "seeing if ~/.gitconfig is symbolically linked"
    !raw_shell("find ~/.gitconfig -type l").stdout.empty?
  }
  meet{
     # apparently you can't use relative path for hidden files?
    if File.file?('/Users/tristansokol/.gitconfig')
      shell('mv ~/.gitconfig "/Users/tristansokol/.gitconfig$(date +"%m-%d-%y-%r")"')
    end
    log_shell "Symbolically linking gitconfig from dotfiles","ln -is ~/dotfiles/git/gitconfig ~/.gitconfig"
  }
end

dep 'gitignore' do
  met?{
    log "seeing if ~./gitignore is symbolically linked"
    !raw_shell("find ~/.gitignore -type l").stdout.empty?
  }
  meet{
    if File.file?('/Users/tristansokol/.gitignore')
      shell('mv ~/.gitignore "/Users/tristansokol/.gitignore$(date +"%m-%d-%y-%r")"')
    end
    log_shell "Symbolically linking gitignore from dotfiles","ln -is ~/dotfiles/git/gitignore ~/.gitignore"
  }
end
# this isn't needed since I updated the config
dep 'git-templates' do
  met?{
    log "seeing if ~./git-templates is symbolically linked"
    !raw_shell("find ~/.git_template -type l").stdout.empty?
  }
  meet{
    log_shell "Symbolically linking .git_template from dotfiles","ln -is ~/dotfiles/git/git_template ~/.git_template"
  }
end
