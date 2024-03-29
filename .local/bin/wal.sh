#!/usr/bin/sh
# Pywal colorscheme and wallpaper selection

# If pywal is not executable, exit
if [ ! -x "$(command -v wal)" ] ; then {
    echo "Error: wal not found"
    echo "Aborting script"
    exit 1
} fi

# Define directories
CACHE="$HOME/.cache/wal"
CONFIG="$HOME/.config"
        
# Define and protect command behavior
CAT="command cat"
CP="command cp --reflink=auto --no-preserve=mode,ownership"
LN="command ln -s"
LS="command ls"
WAL="command wal"

# Define cached wallpaper to use
WAL_CACHE="$CACHE/wal_cache"

# If feh is executable, set the desktop wallpaper
if [ -x "$(command -v feh)" ] ; then { 
    FEH="command feh --bg-fill --no-fehbg"
    $FEH "$($CAT "$WAL_CACHE")"
} fi

# Generate the colorscheme
$WAL --saturate 0.5 --cols16 -nq -i "$($CAT "$WAL_CACHE")"

# Select new random wallpaper and cache it
WALLPAPER_DIR="$HOME/pictures/wallpapers/selected"
WALLPAPER="$($LS "$WALLPAPER_DIR" --recursive | shuf | head -n 1)"
echo "$WALLPAPER_DIR/$WALLPAPER" >| "$WAL_CACHE"

# Copy the image to /usr/share/backgrounds so that LightDM can use it
WALLPAPER_CACHE="/usr/share/backgrounds/wal"
$CP "$WALLPAPER_DIR/$WALLPAPER" "$WALLPAPER_CACHE"

# Apply colorscheme to Alacritty
if [ -x "$(command -v alacritty)" ] &&                                         \
    [ ! -e "$CONFIG/alacritty/alacritty_colors.toml" ] &&                      \
    [ -e "$CACHE/alacritty_colors.toml" ] ; then {
        $LN "$CACHE/alacritty_colors.toml"                                     \
            "$CONFIG/alacritty/alacritty_colors.toml"
} fi

# Apply pywal colorscheme to Zathura 
if [ -x "$(command -v zathura)" ] &&                                           \
    [ ! -e "$CONFIG/zathura/zathurarc" ] &&                                    \
    [ -e "$CACHE/zathurarc.wal" ] ; then { 
        $LN "$CACHE/zathura.wal" "$CONFIG/zathura/zathurarc"
} fi

# Apply colorscheme to CAVA
if [ -x "$(command -v cava)" ] &&                                              \
    [ ! -e "$CONFIG/cava/config" ] &&                                          \
    [ -e "$CACHE/cava.wal" ] ; then {
        $LN "$CACHE/cava.wal" "$CONFIG/cava/config"
} fi

# Apply colorscheme to AERC
if [ -x "$(command -v aerc)" ] &&                                              \
    [ ! -e "$CONFIG/aerc/stylesets/wal" ] &&                                   \
    [ -e "$CACHE/aerc.wal" ] ; then {
        $LN "$CACHE/aerc.wal" "$CONFIG/aerc/stylesets/wal"
} fi

# Apply pywal colorscheme to Firefox
if [ -x "$(command -v pywalfox)" ] ; then {
    command pywalfox update
} fi

# Apply pywal colorscheme to KiCad
if [ -f ~/Projects/kiwal/kiwal.py ] ; then {
    command python ~/Projects/kiwal/kiwal.py
} fi

if [ -x "$(command -v xrdb)" ] ; then {
    xrdb -merge "$CACHE/colors.Xresources"
} fi

if [ "$XDG_SESSION_DESKTOP" = 'awesome' ] ; then {
    echo 'awesome.restart()' | awesome-client 1>&2
} fi
