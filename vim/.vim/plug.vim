if empty(glob("~/.vim/autoload/plug.vim"))
    exec '!mkdir -p ~/.vim/plugged'
    exec '!mkdir -p ~/.vim/autoload'
    exec '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Visual
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'nanotech/jellybeans.vim'
Plug 'michalbachowski/vim-wombat256mod'

" Language Support
Plug 'fatih/vim-go'

" Misc
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'sjl/splice.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'mhinz/vim-startify'

" Add plugins to &runtimepath
call plug#end()

