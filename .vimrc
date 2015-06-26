set nocompatible " vi互換モードをoffに
filetype off

" neobundle を有効化
if has('vim_starting')
  filetype plugin off
  filetype indent off
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
endif
call neobundle#rc(expand('~/.vim/bundle'))

" プラグインのバンドル
NeoBundle 'Shougo/neobundle.vim' " プラグイン管理
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin'  : 'make -f make_cygwin.mak',
    \ 'mac'     : 'make -f make_mac.mak',
    \ 'unix'    : 'make -f make_unix.mak',
  \ },
\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplete.vim'
"NeoBundle 'marcus/rsense'
"NeoBundle 'supermomonga/neocomplete-rsense.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree' " ツリー型エクスプローラー
NeoBundle 'scrooloose/syntastic' " シンタックスチェック
NeoBundle 'Townk/vim-autoclose' " 対となる記号などを自動補完してくれる
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive' " Gitを便利に使う
NeoBundle 'tpope/vim-endwise' " Ruby向けにendを自動挿入してくれる
NeoBundle 'jistr/vim-nerdtree-tabs' "NERDTreeの拡張
NeoBundle 'thinca/vim-ref' " ドキュメント参照
NeoBundle 'yuku-t/vim-ref-ri' " ドキュメント参照
NeoBundle 'szw/vim-tags' "メソッド定義元へのジャンプ


" プラグインの有効化とvim起動時の更新チェック
filetype indent on
filetype plugin on
NeoBundleCheck

syntax on " シンタックスハイライトを有効にする
set cursorline " カーソル行をハイライト
set vb t_vb= " ピープ音を鳴らさない
set autoread
set shortmess+=I
set noswapfile  " swpファイルを作成しない
set number   " 行番号を表示する。
set showcmd " コマンドを表示
set ruler  " 行数を表示する
set showmode " 現在のモードを表示
set hidden " 変更中のファイルでも、保存しないで他のファイルを表示
set title " ファイル名を表示
"set list " 不可視文字を表示
"set listchars=tab:»-,trail:-,extends:»,precedes:«   " 不可視文字の表示設定
set infercase  " 補完の際の大文字小文字の区別しない
set scrolloff=5 " ファイルの末尾の途中でスクロールする
set laststatus=2 " ステータスを複数行にする
set statusline=%t       " ファイル名を表示
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " ファイルエンコーディングを表示
set statusline+=%{&ff}] "ファイルフォーマットを表示
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file"
set matchpairs& matchpairs+=<:> "<と>をペアとして認識させる
set softtabstop=2     " タブのインデント数
set expandtab         " タブを空白に
set shiftwidth=2      " タブのインデント数
" コメント行以降に挿入する際、勝手にコメントアウトされないようにする。
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END
set incsearch " インクリメンタルサーチを有効にする
set wildmenu wildmode=list:full " 補完時の一覧表示機能有効化
set showmatch
scriptencoding utf-8
set fileformat=unix
set ffs=unix,mac,dos
set mouse=a  " マウスの有効化
set ttymouse=xterm2 " xtermとscreen対応
autocmd BufWritePre * :%s/\s\+$//e " 行末の空白を保存時に自動削除
":e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
    \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

"## plugin:NERDTree の個別設定 ##
"autocmd VimEnter  *  NERDTree " vim起動時にNERDTreeも起動する
" vim起動時にNERDTreeも起動する(ファイルが指定されていない場合のみ)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"最後に残ったウィンドウがNERDTREEのみのときはvimを閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden=1 "隠しファイルを表示する。

"## plugin:vim-fugitiveの個別設定 ##
set statusline+=%{fugitive#statusline()} "ステータス行に現在のgitブランチを表示する


"## plugin:Rsense個別設定 ##
"let g:rsenseHome = '/usr/local/lib/rsense-0.3'
"let g:rsenseUseOmniFunc = 1


" neocomplete.vim
"let g:acp_enableAtStartup = 0
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#enable_smart_case = 1
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

" --------------------------------
" rubocop
" --------------------------------
" syntastic_mode_mapをactiveにするとバッファ保存時にsyntasticが走る
" active_filetypesに、保存時にsyntasticを走らせるファイルタイプを指定する
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"## key mapping ##
" ; と : を入れ替える (多用する":"をホームポジションから手を離さずに利用できる)
" #実行環境との差異が好ましくないため削除
"noremap ;  :
"noremap :  ;
