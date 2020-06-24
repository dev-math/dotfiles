#!/bin/bash

background=000000AA
insidecolor=00000000
ringcolor=ffffffff
keyhlcolor=d23c3dff
bshlcolor=d23c3dff
separatorcolor=00000000
insidevercolor=00000000
insidewrongcolor=d23c3dff
ringvercolor=#4C566AFF
ringwrongcolor=ffffffff
verifcolor=fff28aff
wrongcolor=d23c3dff
timecolor=ffffffff
datecolor=ffffffff
loginbox=000000ff
font="Roboto:style=Bold"
locktext='This computer is locked.'
wrongsize=25
datesize=30

i3lock -e \
	--timepos='x+100:y+h-70' \
	--datepos='x+100:y+h-45' \
	--indpos='x+55:y+h-69' \
	--modifpos='x+100:y+h-25' \
	--clock --force-clock \
	--time-align 1 --modif-align 1 \
	--datestr "$locktext" --datesize=$datesize --date-align 1 \
	--color="$background" \
	--insidecolor="$insidecolor" \
	--ringcolor="$ringcolor" \
	--line-uses-inside \
	--wrongcolor="$wrongcolor" \
	--keyhlcolor="$keyhlcolor" \
	--bshlcolor="$bshlcolor" \
	--separatorcolor="$separatorcolor" \
	--insidevercolor="$insidevercolor" \
	--insidewrongcolor="$insidewrongcolor" \
	--ringvercolor="$ringvercolor" \
	--ringwrongcolor="$ringwrongcolor" \
	--verifcolor="$verifcolor" \
	--wrongcolor="$wrongcolor" \
	--timecolor="$timecolor" \
	--datecolor="$datecolor" \
	--radius=20 --ring-width=8 \
	--veriftext='' --wrongtext='' --noinputtext='' \
	--time-font="$font" --date-font="$font" \
	--layout-font="$font" --verif-font="$font" --wrong-font="$font" \
	--wrongsize=$wrongsize \
	--pass-media-keys --redraw-thread  "$@"
