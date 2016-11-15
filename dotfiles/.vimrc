syntax on


" 文字コードの設定
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8                          " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932   " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac                    " 改行コードの自動判別. 左側が優先される
set ambiwidth=double                            " □や○文字が崩れる問題解決


" 画面表示の設定
set number                                               " 行番号を表示する
set cursorline                                           " カーソル行の背景色を変える
set laststatus=2                                         " ステータス行を常に表示
set cmdheight=2                                          " メッセージ表示欄を2行確保
set showmatch                                            " 対応する括弧を強調表示
set helpheight=999                                       " ヘルプを画面いっぱいに開く
set list                                                 " 不可視文字を表示
set listchars=tab:»_,trail:_,extends:»,precedes:«,nbsp:% " 不可視文字の表示記号指定


" カーソル移動関連の設定
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う


" ファイル処理関連の設定
set confirm         " 保存されていないファイルがあるときは終了前に保存確認
set hidden          " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread        " 外部でファイルに変更がされた場合は読みなおす
set nobackup        " ファイル保存時にバックアップファイルを作らない
set noswapfile      " ファイル編集中にスワップファイルを作らない
set wildmenu        " コマンドモードの補完
set history=5000    " 保存するコマンド履歴の数


" 検索/置換の設定
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault   " 置換の時 g オプションをデフォルトで有効にする


" タブ/インデントの設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=4     " 画面上でタブ文字が占める幅
set shiftwidth=4  " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する


" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>


command T NERDTree
"
" NERDTreeの設定
"
if has('vim_starting')
  set nocompatible               " Be iMproved
 
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Yggdroot/indentLine' " インデントの可視化
NeoBundle 'Shougo/unite.vim' " ファイルオープンを便利に
NeoBundle 'Shougo/neomru.vim' " Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'tpope/vim-fugitive' "Gitを便利に使う

" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow

autocmd FileType python setlocal tabstop=4

" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
