# Shell variables
# Generated by 'wal'
wallpaper="{wallpaper}"

# Special
background='{background}'
foreground='{foreground}'
cursor='{cursor}'

# Colors
color0='{color0}'
color1='{color1}'
color2='{color2}'
color3='{color3}'
color4='{color4}'
color5='{color5}'
color6='{color6}'
color7='{color7}'
color8='{color8}'
color9='{color9}'
color10='{color10}'
color11='{color11}'
color12='{color12}'
color13='{color13}'
color14='{color14}'
color15='{color15}'

# Colors
scolor0='{color0.strip}'
scolor1='{color1.strip}'
scolor2='{color2.strip}'
scolor3='{color3.strip}'
scolor4='{color4.strip}'
scolor5='{color5.strip}'
scolor6='{color6.strip}'
scolor7='{color7.strip}'
scolor8='{color8.strip}'
scolor9='{color9.strip}'
scolor10='{color10.strip}'
scolor11='{color11.strip}'
scolor12='{color12.strip}'
scolor13='{color13.strip}'
scolor14='{color14.strip}'
scolor15='{color15.strip}'

# FZF colors
export FZF_DEFAULT_OPTS="
    $FZF_DEFAULT_OPTS
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1
"

# Fix LS_COLORS being unreadable.
export LS_COLORS="${{LS_COLORS}}:su=30;41:ow=30;42:st=30;44:"
