" vim: set foldmethod=marker foldmarker={,} foldlevel=0 :
set nocompatible
set background=dark     " Assume a dark background
call plug#begin('~/.vim/bundle/')
" Load Plugins {
    " General {
        if count(g:bundle_groups, 'general')
            " 编辑
            Plug 'jiangmiao/auto-pairs' " 自动配对括号
            Plug 'tpope/vim-surround'
            Plug 'tpope/vim-repeat'
            Plug 'tpope/vim-commentary'
            Plug 'godlygeek/tabular'   " 对齐文本
            Plug 'luochen1990/rainbow' " 以颜色区分括号层次
            " 语法检查
            if v:version >= 800
                Plug 'w0rp/ale'
            else
                Plug 'scrooloose/syntastic'
            endif
            " 搜索, 导航
            if executable('ctags')
                Plug 'majutsushi/tagbar'
            endif
            Plug 'vim-scripts/cscope.vim'
            Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
            Plug 'ctrlpvim/ctrlp.vim'     " 模糊搜索
            Plug 'tacahiroy/ctrlp-funky'  " ctrlp的函数搜索插件
            " 最快的搜索插件, --bin 只在vim中使用, --all 在系统中使用
            Plug 'junegunn/fzf', {'dir': '~/.vim/bundle/fzf', 'do': './install --bin'}
            Plug 'junegunn/fzf.vim'
            Plug 'easymotion/vim-easymotion'
            " git
            Plug 'airblade/vim-gitgutter'
        endif
    " }
    " AutoComplete {
        if count(g:bundle_groups, 'autocomplete')
            Plug 'vim-scripts/OmniCppComplete'
            Plug 'Shougo/neocomplete.vim'
            Plug 'Shougo/neosnippet'
            Plug 'Shougo/neosnippet-snippets'
        endif
    " }
    " UI {
        if count(g:bundle_groups, 'ui')
            Plug 'altercation/vim-colors-solarized'
            Plug 'vim-airline/vim-airline'
            Plug 'vim-airline/vim-airline-themes'
        endif
    " }
" }
call plug#end()

" General {
if count(g:bundle_groups, 'general')

    " CScope {
        nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
        nnoremap <leader>l  :call ToggleLocationList()<CR>
        nnoremap g[ :call cscope#find('c', expand('<cword>'))<CR>
        " s: Find this C symbol
            nnoremap <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
        " g: Find this definition
            nnoremap <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
        " d: Find functions called by this function
            nnoremap <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
        " c: Find functions calling this function
            nnoremap <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
        " t: Find this text string
            nnoremap <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
        " e: Find this egrep pattern
            nnoremap <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
        " f: Find this file
            nnoremap <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
        " i: Find files #including this file
            nnoremap <leader>fi :call cscope#find('i', expand('<cword>'))<CR>
        " 关闭更新CScope的提示信息
            let g:cscope_silent = 1
    " }

    " NerdTree {
        let g:NERDTreeWinPos="left"
        let g:NERDTreeShowHidden=1
        let g:NERDTreeQuitOnOpen=1
        let g:NERDTreeKeepTreeInNewTab=1
        let g:NERDTreeIgnore=['\.o$','\~$','\.tags$']
        "let g:NERDTreeWinSize=30
        map <F2> :NERDTreeToggle<cr>
        map <leader>nb :NERDTreeFromBookMark<cr>
        map <leader>nf :NERDTreeFind<cr>
    " }

    " CtrlP {
        if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
            let g:ctrlp_extensions=['funky']
            let g:ctrlp_funky_syntax_hilight=1
            nnoremap <leader>fu :CtrlPFunky<cr>
            nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<cr>
        endif
    " }

    " Tagbar {
        map <F3> :TagbarToggle<cr>
        let g:tagbar_autofocus=1
    " }

    " GitGutter {
        set updatetime=100
    " }

    " Rainbow {
        let g:rainbow_active=1
    " }

    " vim-commentary {
        " 修改注释风格
        autocmd FileType c setlocal commentstring=//\ %s
    " }
endif
" }

" AutoComplete {
    if count(g:bundle_groups, 'autocomplete')
        " OmniCppComplete {
            "set completeopt=menuone,menu
            set completeopt=longest,menu
            let OmniCpp_MayCompleteDot=1   ".后自动补全
            let OmniCpp_MayCompleteArrow=1 "->后自动补全
            let OmniCpp_MayCompleteScope=1 "::后自动补全
            let OmniCpp_NamespaceSearch=1
            let OmniCpp_GlobalScopeSearch=1
            let OmniCpp_ShowAccess=1
            let OmniCpp_ShowPrototypeInAbbr=1 "显示函数参数列表
            let OmniCpp_DefaultNamespaces=["std"]
        " }

        " neocomplete {
            " Disable AutoComplPop.
            let g:acp_enableAtStartup = 0
            let g:neocomplete#enable_at_startup = 1
            let g:neocomplete#enable_smart_case = 1
            let g:neocomplete#enable_auto_delimiter = 1
            let g:neocomplete#max_list = 15
            " AutoComplPop like behavior.
            "let g:neocomplete#enable_auto_select = 1

            " Define dictionary.
            let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

            " Define keyword.
            if !exists('g:neocomplete#keyword_patterns')
                let g:neocomplete#keyword_patterns = {}
            endif
            let g:neocomplete#keyword_patterns['default'] = '\h\w*'

            " Plugin key-mappings {
                " <C-k> 补全代码片段
                imap <C-k>     <Plug>(neosnippet_expand_or_jump)
                smap <C-k>     <Plug>(neosnippet_expand_or_jump)

                inoremap <expr><C-g>     neocomplete#undo_completion()
                inoremap <expr><C-l>     neocomplete#complete_common_string()

                " <CR>: close popup
                " <s-CR>: close popup and save indent.
                inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"
                function! CleverCr()
                    if pumvisible()
                        if neosnippet#expandable()
                            let exp = "\<Plug>(neosnippet_expand)"
                            return (exp . neocomplete#smart_close_popup())
                        else
                            return neocomplete#smart_close_popup()
                        endif
                    else
                        return "\<CR>"
                    endif
                endfunction
                " <CR> close popup and save indent or expand snippet
                imap <expr> <CR> CleverCr()

                " 退格后关闭补全栏
                inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
                inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

                " 空格(<C-y>)关闭补全窗口
                " Close popup by <Space>.
                "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

                " <TAB>: completion.
                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
                function! CleverTab()
                    if pumvisible()
                        return "\<C-n>"
                    endif
                    let substr = strpart(getline('.'), 0, col('.') - 1)
                    let substr = matchstr(substr, '[^ \t]*$')
                    if strlen(substr) == 0
                        " nothing to match on empty string
                        return "\<Tab>"
                    else
                        " existing text matching
                        if neosnippet#expandable_or_jumpable()
                            return "\<Plug>(neosnippet_expand_or_jump)"
                        else
                            return neocomplete#start_manual_complete()
                        endif
                    endif
                endfunction
                imap <expr> <Tab> CleverTab()

            " }

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

            " Enable heavy omni completion.
            if !exists('g:neocomplete#sources#omni#input_patterns')
              let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        " }
    endif

" }

" UI {
    if count(g:bundle_groups, 'ui')
        " vim-airline {
            "let g:airline_section_y = '%{strftime("%H:%M")}'
            let g:airline#extensions#tabline#enabled = 1
            let g:airline#extensions#tabline#buffer_nr_show = 1
            let g:airline#extensions#tabline#left_sep = ' '
            let g:airline#extensions#tabline#left_alt_sep = '|'
            "let g:airline_theme = 'solarized'
            "let g:airline_solarized_bg = 'dark'
        " }
        " solarized {
            let g:solarized_termcolors=256
            let g:solarized_termtrans=1
            let g:solarized_contrast="normal"
            let g:solarized_visibility="normal"
        " }
    endif
" }
