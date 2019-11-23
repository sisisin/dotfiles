function configure_image_lists() {
    local image_index=1
    find "$OneDrive/画像/background" -name "*.png" -o -name "*.jpg" -o -name "*.gif" | while read f; do
        image_list1[image_index]="$f"
        image_index=$(($image_index + 1))
    done
    image_index=1
    find "$OneDrive/画像/background_e" -name "*.png" -o -name "*.jpg" -o -name "*.gif" | while read f; do
        image_list3[image_index]="$f"
        image_index=$(($image_index + 1))
    done
}

function e() {
    if [[ "$PRIVATE_ENV" == 1 ]]; then
        local image_index=$(($RANDOM % ${#image_list3[@]} + 1))
        image_path=$image_list3[$image_index]
        (osascript $OneDrive/dotfiles/scripts/bg/set_background_image.applescript $image_path &)
    fi
}

function set_background() {
    if [ -z "$BUFFER" ]; then
        image_index=$(($RANDOM % ${#image_list1[@]} + 1))
        image_path=$image_list1[$image_index]
        (osascript $OneDrive/dotfiles/scripts/bg/set_background_image.applescript $image_path &)
        zle reset-prompt
    fi

    zle accept-line
}

function _set_image_interval() {
    local cmd=$1
    unset_image_interval
    watch -n 60 _set_bg $cmd &>/dev/null &
}

function set_image_interval_e() {
    _set_image_interval e
}

function set_image_interval() {
    _set_image_interval set_background
}

function unset_image_interval() {
    ps aux | grep _set_bg | grep -v grep | awk '{ print "kill -9", $2 }' | sh
}
