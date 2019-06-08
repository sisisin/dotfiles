#!/bin/bash
set -Ceu

# alias: defaults write -g ...
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.clock DateFormat -string "M\\U6708d\\U65e5(EEE)  H:mm"

# hide Dock
defaults write com.apple.dock autohide -bool true

killall Dock

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXPreferredViewStyle Nlsv
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string 'file://${HOME}/'
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowTabView -bool true
killall Finder

mkdir -p ~/Pictures/ss
defaults write com.apple.screencapture location "~/Pictures/ss"
defaults write com.apple.screencapture name "ss_"
killall SystemUIServer

# don't make .DS_store at network directory
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "DragLock" -bool False
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadThreeFingerDrag" -bool True
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "Dragging" -bool False

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadThreeFingerVertSwipeGesture" -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadRotate" -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadTwoFingerFromRightEdgeSwipeGesture" -int 3
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "UserPreferences" -bool True
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadScroll" -bool True
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadThreeFingerHorizSwipeGesture" -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "Clicking" -bool True
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "version" -int 5
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadFourFingerPinchGesture" -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadCornerSecondaryClick" -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadMomentumScroll" -bool True
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadFourFingerVertSwipeGesture" -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadFourFingerHorizSwipeGesture" -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadHorizScroll" -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadRightClick" -bool True
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadTwoFingerDoubleTapGesture" -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadFiveFingerPinchGesture" -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "USBMouseStopsTrackpad" -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadThreeFingerTapGesture" -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadPinch" -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadHandResting" -bool True

defaults write "com.googlecode.iterm2" "PromptOnQuit" -bool False
defaults write "com.googlecode.iterm2" "OnlyWhenMoreTabs" -bool False

echo $(tput setaf 2)Deploy mac environment complete!. ✔︎$(tput sgr0)
