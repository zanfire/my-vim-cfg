" Vim syntax file
" Language: Log file
" Maintainer:	Matteo Valdina

if exists("b:current_syntax")
	finish
endif

:set nospell

" :syn match pointer '0x[0-9a-f]*'
:syn match logSep '\v\|'


:syn keyword logDebug DEBUG
:syn keyword logInfo INFO
:syn keyword logWarn WARN
:syn keyword logError ERROR
:syn keyword logFatal FATAL



" This creates a match on the date and puts in the highlight group called logDate.  The nextgroup and skipwhite makes vim look for logTime after the match
:syn match logDate /^\d\{4}-\d\{2}-\d\{2}/ nextgroup=logTime skipwhite
:syn match logTime /\d\{2}:\d\{2}:\d\{2},\d\{3}/

:hi pointer     ctermfg=Blue
:hi logSep      ctermfg=Red
:hi logDebug    ctermfg=Green
:hi logInfo     ctermfg=Cyan
:hi logWarn     ctermfg=Yellow
:hi logError    ctermfg=Red
:hi link logFatal Error
" Def means default colour - colourschemes can override
:hi def logDate ctermfg=grey
:hi def logTime ctermfg=grey

let b:current_syntax = "log"
