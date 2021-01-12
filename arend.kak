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
add-highlighter shared/arend/string region %{(?<!')"} (?<!\\)(\\\\)*"  fill string
add-highlighter shared/arend/raw_string region -match-capture %{(?<!')r(#*)"} %{"(#*)}  fill string
add-highlighter shared/arend/comment-block region \(\* \*\) fill comment
add-highlighter shared/arend/comment region '(?<!\$)(?<!\$\{)#' '$' fill comment

add-highlighter shared/arend/code/ regex \b(?:[0-9][_0-9]*(?:\.[0-9][_0-9]*|(?:\.[0-9][_0-9]*)?E[\+\-][_0-9]+)(?:f(?:32|64))?|(?:0x[_0-9a-fA-F]+|0o[_0-7]+|0b[_01]+|[0-9][_0-9]*)(?:(?:i|u|f)(?:8|16|32|64|128))?)\b 0:value
add-highlighter shared/arend/code/ regex \b(?:&&|\|\|)\b 0:operator

add-highlighter shared/arend/code/ regex (?:#!?\[.*?\]) 0:meta
add-highlighter shared/arend/code/ regex \b(?:true|false)\b 0:attribute
add-highlighter shared/arend/code/ regex \b(?:map|set|bool|nat|str)\b 0:type
add-highlighter shared/arend/code/ regex \$\w+\b 0:variable
add-highlighter shared/arend/code/ regex "'\\\\?.'" 0:value
add-highlighter shared/arend/code/ regex "('\w+)[^']" 1:meta
add-highlighter shared/arend/code/ regex \b(?:size|print|puts|strlen|substr|eys|get|lookup|entries|cross|compose|aggregate)\b 0:builtin
add-highlighter shared/arend/code/ regex \b(?:disc|mono|anti|type|val|fun|rel|fn|λ|let|in|case|fix|is|if|then|else|when|unless|for|empty|ε|lub)\b 0:keyword

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group arend-highlight global WinSetOption filetype=arend %{
    add-highlighter window/arend ref arend
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/arend }
}

hook global WinSetOption filetype=arend %[
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window arend-.+ }
]
