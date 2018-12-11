" Vim syntax file
" Language:Emfrp

" 使い方(Linux)
" ~/.vim/syntax/ の中にコピーしてください
" .vimrcに
" au BufRead,BufNewFile *.mfrp set filetype=emfrp
" を追記してください

" すでに読まれていたら終了
if exists("b:current_syntax")
	finish
endif 

" 構文のマッチ
syntax keyword emfrpModule   module
syntax keyword emfrpType     Int Char Bool Maybe GF Array Float Double UInt UChar Long
syntax match   emfrpComment  /#.*\n/
syntax keyword emfrpKeyword  material in out use node newnode data func primfunc type primtype infix infixl infixr if then else of as from init skip continue -> =>
syntax match emfrpConstant /[A-Z][a-zA-Z_]*/
syntax match emfrpNumber   "\<-\=\d\(_\|\d\)*[l|L|n]\?\>"
syntax match emfrpNumber   "\<-\=0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syntax match emfrpNumber   "\<-\=0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syntax match emfrpNumber   "\<-\=0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syntax match emfrpFloat    "\<-\=\d\(_\|\d\)*\.\?\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"
syntax match emfrpFloat    "\<\d\+\.\d*\>"
syntax match emfrpFloat    "\.\d\+\>"
syntax match emfrpParens   "("
syntax match emfrpParens   ")"
syntax match emfrpBrackets "\["
syntax match emfrpBrackets "\]"
syntax match emfrpParenErr ")"
syntax match emfrpBracketErr "]"
syntax match emfrpOperator "+"
syntax match emfrpOperator "-"
syntax match emfrpOperator "*"
syntax match emfrpOperator "/"
syntax match emfrpOperator "%"
syntax match emfrpOperator "="
syntax match emfrpOperator "=="
syntax match emfrpOperator "!="
syntax match emfrpOperator "<"
syntax match emfrpOperator ">"
syntax match emfrpOperator "@last"

syntax match emfrpSpecialChar contained "\\."
syntax region emfrpString start=+"+ end=+"+ contains=emfrpSpecialChar

" 構文に対するハイライトの割り当て
highlight link emfrpModule   Function 
highlight link emfrpType     Type  
highlight link emfrpComment  Comment  
highlight link emfrpKeyword  Conditional 
highlight link emfrpConstant Constant
highlight link emfrpFloat    Float
highlight link emfrpNumber   Number
highlight link emfrpParens   SpecialChar
highlight link emfrpParenErr Error
highlight link emfrpBrackets SpecialChar
highlight link emfrpBracketErr Error
highlight link emfrpOperator Operator
highlight link emfrpString   String
highlight link emfrpSpecialChar String

" 余分な)]はエラー
syntax region emfrpInParens matchgroup=emfrpParens start=/(/ end=/)/ contains=TOP,emfrpParens,emfrpParenErr
syntax region emfrpInBrackets matchgroup=emfrpBrackets start=/\[/ end=/\]/ contains=TOP,emfrpBrackets,emfrpBracketErr

" ファイルタイプを指定
let b:current_syntax = "emfrp"
