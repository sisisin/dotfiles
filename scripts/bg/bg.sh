function update_current_image() {
    local current_image=$1

    echo $current_image >$OneDrive/dotfiles/scripts/bg/.current_image
}

function configure_image_lists() {
    local image_index=1
    find "$OneDrive/画像/background" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" \) | while read f; do
        image_list1[image_index]="$f"
        image_index=$(($image_index + 1))
    done
    image_index=1
    find "$OneDrive/画像/background_e" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" \) | while read f; do
        image_list3[image_index]="$f"
        image_index=$(($image_index + 1))
    done
}

function e() {
        local image_index=$(($RANDOM % ${#image_list3[@]} + 1))
        image_path=$image_list3[$image_index]

        (osascript -l JavaScript $OneDrive/dotfiles/scripts/bg/set_bg_image.jxa "$image_path" &)
        update_current_image "$image_path"
}

function unset_bg() {
          (osascript -l JavaScript $OneDrive/dotfiles/scripts/bg/set_bg_image.jxa "" &)
          update_current_image ""
}
function u() {
    unset_bg
}

function set_current_image() {
    local image_path=$(cat $OneDrive/dotfiles/scripts/bg/.current_image)
    echo $image_path
    (osascript -l JavaScript $OneDrive/dotfiles/scripts/bg/set_bg_image.jxa "$image_path" &)
}

function set_background_random() {
    if [ -z "$BUFFER" ]; then
        image_index=$(($RANDOM % ${#image_list1[@]} + 1))
        image_path=$image_list1[$image_index]
        update_current_image "$image_path"
        (osascript -l JavaScript $OneDrive/dotfiles/scripts/bg/set_bg_image.jxa $image_path &)
        zle reset-prompt
    fi

    zle accept-line
}
