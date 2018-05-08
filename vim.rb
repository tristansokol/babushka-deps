dep 'vim' do
  # requires 'vimrc', 'vim-vue', 'vim-sensible', 'vim-color-fresh'
  met? do
    # See if vim version supports clipboard
  raw_shell('vim --version | grep +clipboard').stdout.empty?
  end
  meet do
        log_shell 'installing vim with homebrew', 'brew install vim'
    # log_shell 'cloning vim source', 'git clone https://github.com/vim/vim.git ~/Development/vim'
    # log_shell 'making and installing', 'cd ~/Development/vim/src && ./configure --enable-clipboard && make && sudo make install'
    # log_shell 'cleaning up sources', 'rm -rf ~/Development/vim '
  end
end

dep 'vimrc' do
  requires  'dotfiles'
  met? { '~/.vimrc'.p.exists? }
  meet do
    log_shell 'symlinking .vimrc from dotfiles repo', 'ln -s ~/dotfiles/vimrc ~/.vimrc'
  end
end

dep 'vim-vue' do
  met? { '~/.vim/pack/plugins/start/vim-vue'.p.exists? }
  meet do
    log_shell 'cloning vim-vue', 'git clone https://github.com/posva/vim-vue.git ~/.vim/pack/plugins/start/vim-vue'
  end
end

dep 'vim-sensible' do
  met? { '~/.vim/pack/plugins/start/vim-sensible'.p.exists? }
  meet do
    log_shell 'cloning vim-sensible', 'git clone https://github.com/tpope/vim-sensible.git ~/.vim/pack/plugins/start/vim-sensible'
  end
end
dep 'vim-colorschemes' do
  met? { '~/.vim/colors'.p.exists? }
  meet do
    log_shell 'cloning vim-colorschemes', 'git clone https://github.com/flazz/vim-colorschemes.git ~/tempvimcolorschemes'
    log_shell 'copying colors over', 'cp -R ~/tempvimcolorschemes/colors ~/.vim/colors'
    log_shell 'deleting temp files', 'rm -rf ~/tempvimcolorschemes'
  end
end
dep 'vim-color-fresh' do
  requires 'vim-colorschemes'
  met? { '~/.vim/colors/fresh.vim'.p.exists? }
  meet do
    log_shell 'cloning vim-fresh', 'git clone https://github.com/Alvarocz/vim-fresh.git ~/tempvimfresh'
    log_shell 'copying scheme over', 'cp  ~/tempvimfresh/colors/fresh.vim ~/.vim/colors/fresh.vim'
    log_shell 'deleting temp files', 'rm -rf ~/tempvimfresh'
  end
end
