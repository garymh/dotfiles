syntax match todoCheckbox '\v\s*(-? \[[ x\.!\*]\])' contains=finishedCheckbox,unfinishexCheckbox,flaggedCheckbox,starredCheckbox
syntax match finishedCheckbox '\v(-? \[[ \.]\])' conceal cchar=
syntax match unfinishexCheckbox '\v(-? \[x\])' conceal cchar=
syntax match flaggedCheckbox '\v(-? \[!\])' conceal cchar=
syntax match starredCheckbox '\v(-? \[\*\])' conceal cchar=

hi link todoCheckbox Todo

hi clear Conceal
