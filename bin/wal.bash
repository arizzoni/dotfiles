#!/usr/bin/env bash
# Pywal colorscheme and wallpaper selection

# If pywal is not executable, exit
if [[ ! -x "$(command -v wal)" ]] ; then {
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

# Use old cached wallpaper to generate a colorscheme
WAL_CACHE="$CACHE/wal_cache"
$WAL --saturate 0.4 --cols16 -nq -i "$($CAT "$WAL_CACHE")"

# Select new random wallpaper and cache it
WALLPAPER_DIR="$HOME/Pictures/wallpapers/4k/space"
WALLPAPER="$($LS "$WALLPAPER_DIR" --recursive | shuf | head -n 1)"
echo "$WALLPAPER_DIR/$WALLPAPER" >| "$WAL_CACHE"

# Copy the image to /usr/share/backgrounds so that LightDM can use it
WALLPAPER_CACHE="/usr/share/backgrounds/wal"
$CP "$WALLPAPER_DIR/$WALLPAPER" "$WALLPAPER_CACHE"

# Apply colorscheme to Alacritty
if [[ -x "$(command -v alacritty)" ]] &&                                       \
    [[ ! -e "$CONFIG/alacritty/alacritty.toml" ]] &&                           \
    [[ -e "$CACHE/alacritty.wal" ]] ; then {
        $LN "$CACHE/alacritty.wal" "$CONFIG/alacritty/alacritty.toml"
} fi

# Apply pywal colorscheme to Zathura 
if [[ -x "$(command -v zathura)" ]] &&                                         \
    [[ ! -e "$CONFIG/zathura/zathurarc" ]] &&                                  \
    [[ -e "$CACHE/zathurarc.wal" ]] ; then { 
        $LN "$CACHE/zathura.wal" "$CONFIG/zathura/zathurarc"
} fi

# Apply colorscheme to CAVA
if [[ -x "$(command -v cava)" ]] &&                                            \
    [[ ! -e "$CONFIG/cava/config" ]] &&                                        \
    [[ -e "$CACHE/cava.wal" ]] ; then {
        $LN "$CACHE/cava.wal" "$CONFIG/cava/config"
} fi

# Apply colorscheme to AERC
if [[ -x "$(command -v aerc)" ]] &&                                            \
    [[ ! -e "$CONFIG/aerc/stylesets/wal" ]] &&                                 \
    [[ -e "$CACHE/aerc.wal" ]] ; then {
        $LN "$CACHE/aerc.wal" "$CONFIG/aerc/stylesets/wal"
} fi

# Apply pywal colorscheme to Firefox
if [[ -x "$(command -v pywalfox)" ]] ; then {
    command pywalfox update
} fi

# Apply pywal colorscheme to KiCad
if [[ -f ~/Projects/kiwal/kiwal.py ]] ; then {
    command python ~/Projects/kiwal/kiwal.py
} fi
