on run argv
  tell application "iTerm"
      tell current window
          tell current session
              set background image to (item 1 of argv)
          end tell
      end tell
  end tell
end run
