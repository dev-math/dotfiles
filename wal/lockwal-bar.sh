#!/bin/sh

B='#00000000'   # blank
C='#00000000'   # clear ish
D='{color2}'     # default
T='{color15}'     # text
W='{color3}'    # wrong
V='#00000000'   # verifying
S='30'          # text size
F="Arial"       # font

i3lock \
--insidevercolor=$C        \
--ringvercolor=$V          \
\
--insidewrongcolor=$C      \
--ringwrongcolor=$W        \
\
--insidecolor=$B           \
--ringcolor=$D             \
--linecolor=$B             \
--separatorcolor=$D        \
\
--verifcolor=$T            \
--wrongcolor=$T            \
--timecolor=$T             \
--datecolor=$T             \
--layoutcolor=$T           \
--keyhlcolor=$W            \
--bshlcolor=$W             \
\
--screen 1                 \
--blur 5                   \
--clock                    \
--indicator                \
--bar-indicator            \
--bar-step 50              \
--bar-color $B             \
--timestr="%H:%M"          \
--datestr="%A, %m %Y"      \
--wrongtext="Wrong!"       \
--veriftext="..."          \
--noinputtext="No input"   \
--datesize=20              \
--greetersize=$S           \
--layoutsize=$S            \
--timesize=$S              \
--verifsize=$S             \
--wrongsize=$S             \
--date-font=$F             \
--greeter-font=$F          \
--layout-font=$F           \
--time-font=$F             \
--verif-font=$F            \

# --ignore-empty-password    \
