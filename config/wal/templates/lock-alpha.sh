#!/bin/sh

B='#00000000'   # blank
C='#00000000'   # clear ish
D='#00000000'   # default
T='{color15}'   # text
W='#00000000'   # wrong
V='#00000000'   # verifying
S='30'          # text size
F="SF Pro Display"       # font

i3lock \
--insidever-color=$C        \
--ringver-color=$V          \
\
--insidewrong-color=$C      \
--ringwrong-color=$W        \
\
--inside-color=$B           \
--ring-color=$D             \
--line-color=$B             \
--separator-color=$D        \
\
--verif-color=$T            \
--wrong-color=$T            \
--time-color=$T             \
--date-color=$T             \
--layout-color=$T           \
--keyhl-color=$W            \
--bshl-color=$W             \
\
--screen 1                 \
--blur 10                  \
--clock                    \
--indicator                \
--ring-width 120           \
--radius 120               \
--time-str="%H:%M"          \
--date-str="%A, %m %Y"      \
--wrong-text="Wrong!"       \
--verif-text="..."   \
--noinput-text="Go ahead!"   \
--date-size=20              \
--greeter-size=$S           \
--layout-size=$S            \
--time-size=$S              \
--verif-size=$S             \
--wrong-size=$S             \
--date-font=$F             \
--greeter-font=$F          \
--layout-font=$F           \
--time-font=$F             \
--verif-font=$F            \

# --ignore-empty-password    \
