function configure_image_lists() {
    local image_index=1
    find "$HOME/OneDrive - simenyan/画像/background" -name "*.png" -o -name "*.jpg" -o -name "*.gif" | while read f; do
        image_list1[image_index]="$f"
        image_index=$(($image_index + 1))
    done
    image_index=1
    find "$HOME/OneDrive - simenyan/画像/background_e" -name "*.png" -o -name "*.jpg" -o -name "*.gif" | while read f; do
        image_list3[image_index]="$f"
        image_index=$(($image_index + 1))
    done
}

e() {
    if [[ "$PRIVATE_ENV" == 1 ]]; then
        local image_index=$(($RANDOM % ${#image_list3[@]} + 1))
        image_path=$image_list3[$image_index]
        (osascript ~/set_background_image.applescript $image_path &)
    fi
}

set_background() {
    if [ -z "$BUFFER" ]; then
        image_index=$(($RANDOM % ${#image_list1[@]} + 1))
        image_path=$image_list1[$image_index]
        (osascript ~/set_background_image.applescript $image_path &)
        zle reset-prompt
    fi

    zle accept-line
}
