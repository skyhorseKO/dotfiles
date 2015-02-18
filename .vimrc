"設定の間だけoff
filetype off
filetype plugin indent off
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set ambw=double

set autoindent
set nocompatible
set expandtab
set incsearch
set smartindent
set smarttab
set shellslash
set grepprg=grep\ -nH\ $*
set imdisable
syntax on
set backspace=2
set helplang=ja
set shiftwidth=2
set tabstop=2
set wildmenu
set visualbell
set wildmode=longest,list,full
set number
set ruler
"actionscript,mxml setting
"set cursorline
set tw=0
" OSのクリップボードを使用する
"set clipboard+=unnamed,autoselect
" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"NeoBundleの設定
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle'))
endif 
    
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'anyakichi/skk.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/NeoComplCache.vim'

call neobundle#end()

let s:is_mac =  (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')
"!s:is_win &&
"macのクリップボードへ/からの入出力
if s:is_mac
 nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
 vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
 nnoremap <silent> <Space>p :r !pbpaste<CR>
 vnoremap <silent> <Space>p :r !pbpaste<CR>
endif

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap :set iminsert=0

" AutoComplPopを無効にする
let g:acp_enableAtStartup = 0
" NeoComplCacheを有効にする
let g:neocomplcache_enable_at_startup = 1

let g:neocomplcache_dictionary_filetype_lists = {
   \ 'default' : '',
   \ 'scala' : $HOME . '/.vim/dict/scala.dict',
   \ }

" ユーザー定義スニペット保存ディレクトリ
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

" スニペット
imap <C-y> <Plug>(neocomplcache_snippets_expand)
"smap <C-k> <Plug>(neocomplcache_snippets_expand)

"map <silent> sy :call YanktmpYank()<CR>
"map <silent> sp :call YanktmpPaste_p()<CR>
"map <silent> sP :call YanktmpPaste_P()<CR>

let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

"Tabキーによる補完
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<TAB>"
  else
    if pumvisible()
      return "\<C-n>"
    else
      return "\<C-n>\<C-p>"
    end
  endif
endfunction

inoremap <tab> <C-r>=InsertTabWrapper()<CR>

"補完途中でEnterで改行
 inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
" vim: set ft=vim :

if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

"新規作成テンプレートの読み込み
augroup SkeletonAu
		autocmd!
		autocmd BufNewFile *.html 0r ~/.vim/templates/skel.html
		autocmd BufNewFile *.pl 0r ~/.vim/templates/skel.pl
		autocmd BufNewFile *.pm 0r ~/.vim/templates/skel.pm
		autocmd BufNewFile *.rb 0r ~/.vim/templates/skel.rb
		autocmd BufNewFile *.java 0r ~/.vim/templates/skel.java
		autocmd BufNewFile *.c 0r ~/.vim/templates/skel.c
		autocmd BufNewFile *.as 0r ~/.vim/templates/skel.as
		autocmd BufNewFile *.mxml 0r ~/.vim/templates/skel.mxml
		autocmd BufNewFile *.hs 0r ~/.vim/templates/skel.hs
		autocmd BufNewFile *.scala 0r ~/.vim/templates/skel.scala
    autocmd BufNewFile,BufRead *.as set filetype=actionscript
    autocmd BufNewFile,BufRead *.mxml set filetype=mxml
augroup END

""" unite.vim
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> <C-j>b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <C-j>f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> <C-j>r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <C-j>m :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> <C-j>u :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> <C-j>a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q



"vimﾃﾞﾌｫﾙﾄのｴｸｽﾌﾟﾛｰﾗをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"ｾｰﾌﾓｰﾄﾞを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"現在開いているﾊﾞｯﾌｧのﾃﾞｨﾚｸﾄﾘを開く
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているﾊﾞｯﾌｧをIDE風に開く
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

"コンパイルや実行用
autocmd FileType perl :map <C-n> <ESC>:w<CR>:!perl -cw %<CR>
autocmd FileType perl :map <C-e> <ESC>:!perl %<CR>
autocmd FileType ruby :map <C-n> <ESC>:w<CR>:!ruby -cW %<CR>
autocmd FileType ruby :map <C-e> <ESC>:!ruby %<CR>
autocmd FileType java :map <C-n> <ESC>:w<CR>:!javac -J-Dfile.encoding=UTF-8 %<CR>
autocmd FileType java :map <C-e> <ESC>:!java %<<CR>
autocmd FileType c :map <C-n> <ESC>:w<CR>:!gcc -o %< %<CR>
autocmd FileType c :map <C-e> <ESC>:!./%<<CR>
autocmd FileType c :map ,<C-n> <ESC>:w<CR>:!make SRCS=%<CR>
autocmd FileType c :map ,<C-e> <ESC>:!wine /Applications/H8W/h8w.exe<CR>
autocmd FileType actionscript :map <C-n> <ESC>:w<CR>:!mxmlc %<CR>
autocmd FileType actionscript :map <C-e> <ESC>:!open %<.swf<CR>:!flashlog<CR>
autocmd FileType mxml :map <C-n> <ESC>:w<CR>:!mxmlc %<CR>
autocmd FileType mxml :map <C-e> <ESC>:!open %<.swf<CR>:!flashlog<CR>

"括弧を自動で閉じる
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

"skk.vimの設定
let skk_jisyo = '~/Library/Application Support/AquaSKK/skk-jisyo.utf8'
let skk_large_jisyo = '~/Library/Application\ Support/AquaSKK/SKK-JISYO.L' 
let skk_server_host = 'localhost'
let skk_server_portnum = '55100'
let skk_server_encoding = 'euc-jp'
let skk_auto_save_jisyo = 1

"元に戻す
filetype on
filetype indent plugin on
" reference
" http://subtech.g.hatena.ne.jp/cho45/20061010/1160459376
" http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing
"
" need 'set enc=utf-8' and
" below shell environment variable for UTF-8 characters
" export __CF_USER_TEXT_ENCODING='0x1F5:0x08000100:14'












