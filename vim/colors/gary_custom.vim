" Vim color file
" Converted from Textmate theme Big Duo using Coloration v0.3.3 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "gary_custom"

hi Cursor ctermfg=16 ctermbg=15 cterm=NONE guifg=#212326 guibg=#ffffff gui=NONE
hi Visual ctermfg=NONE ctermbg=60 cterm=NONE guifg=NONE guibg=#613177 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#333436 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#333436 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#333436 gui=NONE
hi LineNr ctermfg=243 ctermbg=59 cterm=NONE guifg=#7a7976 guibg=#333436 gui=NONE
hi VertSplit ctermfg=240 ctermbg=240 cterm=NONE guifg=#545554 guibg=#545554 gui=NONE
hi MatchParen ctermfg=44 ctermbg=NONE cterm=underline guifg=#00d2e5 guibg=NONE gui=underline
hi StatusLine ctermfg=188 ctermbg=240 cterm=bold guifg=#d2cfc6 guibg=#545554 gui=bold
hi StatusLineNC ctermfg=188 ctermbg=240 cterm=NONE guifg=#d2cfc6 guibg=#545554 gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=60 cterm=NONE guifg=NONE guibg=#613177 gui=NONE
hi IncSearch ctermfg=16 ctermbg=149 cterm=NONE guifg=#212326 guibg=#bbe16c gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi Folded ctermfg=96 ctermbg=16 cterm=NONE guifg=#74717e guibg=#212326 gui=NONE

hi Normal ctermfg=188 ctermbg=16 cterm=NONE guifg=#d2cfc6 guibg=#212326 gui=NONE
hi Boolean ctermfg=74 ctermbg=NONE cterm=NONE guifg=#47aee8 guibg=NONE gui=NONE
hi Character ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi Comment ctermfg=96 ctermbg=NONE cterm=NONE guifg=#74717e guibg=NONE gui=NONE
hi Conditional ctermfg=185 ctermbg=NONE cterm=NONE guifg=#dbcd5d guibg=NONE gui=NONE
hi Constant ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi Define ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi DiffAdd ctermfg=188 ctermbg=64 cterm=bold guifg=#d2cfc6 guibg=#45820c gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8a0708 guibg=NONE gui=NONE
hi DiffChange ctermfg=188 ctermbg=23 cterm=NONE guifg=#d2cfc6 guibg=#213757 gui=NONE
hi DiffText ctermfg=188 ctermbg=24 cterm=bold guifg=#d2cfc6 guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=15 ctermbg=160 cterm=NONE guifg=#ffffff guibg=#cc0000 gui=NONE
hi WarningMsg ctermfg=15 ctermbg=160 cterm=NONE guifg=#ffffff guibg=#cc0000 gui=NONE
hi Float ctermfg=113 ctermbg=NONE cterm=NONE guifg=#99cc66 guibg=NONE gui=NONE
hi Function ctermfg=212 ctermbg=53 cterm=NONE guifg=#fb97d2 guibg=#541f3d gui=NONE
hi Identifier ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ec7967 guibg=NONE gui=NONE
hi Keyword ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi Label ctermfg=149 ctermbg=22 cterm=NONE guifg=#bbe16c guibg=#2b3a2f gui=NONE
hi NonText ctermfg=238 ctermbg=16 cterm=NONE guifg=#404040 guibg=#2a2c2e gui=NONE
hi Number ctermfg=113 ctermbg=NONE cterm=NONE guifg=#99cc66 guibg=NONE gui=NONE
hi Operator ctermfg=66 ctermbg=NONE cterm=NONE guifg=#3d8f9a guibg=NONE gui=NONE
hi PreProc ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi Special ctermfg=188 ctermbg=NONE cterm=NONE guifg=#d2cfc6 guibg=NONE gui=NONE
hi SpecialKey ctermfg=238 ctermbg=59 cterm=NONE guifg=#404040 guibg=#333436 gui=NONE
hi Statement ctermfg=185 ctermbg=NONE cterm=NONE guifg=#dbcd5d guibg=NONE gui=NONE
hi StorageClass ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ec7967 guibg=NONE gui=NONE
hi String ctermfg=149 ctermbg=22 cterm=NONE guifg=#bbe16c guibg=#2b3a2f gui=NONE
hi Tag ctermfg=216 ctermbg=NONE cterm=NONE guifg=#ffa686 guibg=NONE gui=NONE
hi Title ctermfg=188 ctermbg=NONE cterm=bold guifg=#d2cfc6 guibg=NONE gui=bold
hi Todo ctermfg=96 ctermbg=NONE cterm=inverse,bold guifg=#74717e guibg=NONE gui=inverse,bold
hi Type ctermfg=212 ctermbg=53 cterm=NONE guifg=#fb97d2 guibg=#541f3d gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=185 ctermbg=NONE cterm=NONE guifg=#dbcd5d guibg=NONE gui=NONE
hi rubyFunction ctermfg=212 ctermbg=53 cterm=NONE guifg=#fb97d2 guibg=#541f3d gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi rubyConstant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=149 ctermbg=22 cterm=NONE guifg=#bbe16c guibg=#2b3a2f gui=NONE
hi rubyBlockParameter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=74 ctermbg=NONE cterm=NONE guifg=#47aee8 guibg=NONE gui=NONE
hi rubyInclude ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=74 ctermbg=NONE cterm=NONE guifg=#47aee8 guibg=NONE gui=NONE
hi rubyRegexp ctermfg=149 ctermbg=22 cterm=NONE guifg=#bbe16c guibg=#2b3a2f gui=NONE
hi rubyRegexpDelimiter ctermfg=149 ctermbg=22 cterm=NONE guifg=#bbe16c guibg=#2b3a2f gui=NONE
hi rubyEscape ctermfg=104 ctermbg=NONE cterm=NONE guifg=#797be6 guibg=NONE gui=NONE
hi rubyControl ctermfg=185 ctermbg=NONE cterm=NONE guifg=#dbcd5d guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=66 ctermbg=NONE cterm=NONE guifg=#3d8f9a guibg=NONE gui=NONE
hi rubyException ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=74 ctermbg=NONE cterm=NONE guifg=#47aee8 guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bb95ef guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bb95ef guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bb95ef guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bb95ef guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment ctermfg=96 ctermbg=NONE cterm=NONE guifg=#74717e guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bb95ef guibg=NONE gui=NONE
hi htmlTag ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bd86fa guibg=NONE gui=NONE
hi htmlEndTag ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bd86fa guibg=NONE gui=NONE
hi htmlTagName ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bd86fa guibg=NONE gui=NONE
hi htmlArg ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bd86fa guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ec7967 guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bb95ef guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=216 ctermbg=NONE cterm=NONE guifg=#ffa686 guibg=NONE gui=NONE
hi yamlAnchor ctermfg=74 ctermbg=NONE cterm=NONE guifg=#47aee8 guibg=NONE gui=NONE
hi yamlAlias ctermfg=74 ctermbg=NONE cterm=NONE guifg=#47aee8 guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=149 ctermbg=22 cterm=NONE guifg=#bbe16c guibg=#2b3a2f gui=NONE
hi cssURL ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bb95ef guibg=NONE gui=NONE
hi cssColor ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=111 ctermbg=NONE cterm=NONE guifg=#8aa6ff guibg=NONE gui=NONE
hi cssClassName ctermfg=111 ctermbg=NONE cterm=NONE guifg=#8aa6ff guibg=NONE gui=NONE
hi cssValueLength ctermfg=113 ctermbg=NONE cterm=NONE guifg=#99cc66 guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=113 ctermbg=NONE cterm=NONE guifg=#99cc33 guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
