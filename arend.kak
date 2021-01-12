# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.]ard %{
    set-option buffer filetype arend
    
    set-option buffer comment_line '--'
    set-option buffer comment_block_begin '{-'
    set-option buffer comment_block_end '-}'
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/arend regions
add-highlighter shared/arend/code default-region group

add-highlighter shared/arend/comment region '-- ' '$' fill comment
add-highlighter shared/arend/comment-block region \{- -\} fill comment
add-highlighter shared/arend/code/ regex \b(?<!`)[A-z0-9'~!@#$%^&*\-+=<>?/\|[\]:_]+ 0:function #variable
add-highlighter shared/arend/code/ regex \\(?:open|import|hiding|as|using|truncated|data|cons|func|lemma|sfunc|class|record|classifying|noclassifying|strict|alias|field|property|override|extends|module|instance|use|coerce|level|levels|eval|peval|with|elim|cowith|where|infix|infixl|infixr|fix|fixl|fixr|new|this|Pi|Sigma|lam|let|let!|in|case|scase|return|lp|lh|suc|max|oo|Prop|Set|Type)\b 0:keyword
add-highlighter shared/arend/code/ regex \W(-?)[0-9]+ 0:value
add-highlighter shared/arend/code/ regex \s(?:->|=>|_|:|\|) 0:Default
add-highlighter shared/arend/code/ regex `[A-z0-9'~!@#$%^&*\-+=<>?/\|[\]:_]+` 0:meta

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group arend-highlight global WinSetOption filetype=arend %{
    add-highlighter window/arend ref arend
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/arend }
}

hook global WinSetOption filetype=arend %[
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window arend-.+ }
]
