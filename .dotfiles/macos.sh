# Disable Resume
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable smart quotes and smart dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Show all filename extensions:
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write -g AppleShowAllExtensions -bool true

# Show hidden files:
defaults write com.apple.finder AppleShowAllFiles YES;

# Show path at bottom of finder
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Columns by default
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# Disable "natural" (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Save screenshots to the desktop
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
defaults write com.apple.screencapture type -string "png"

# Disable "force click"
defaults write NSGlobalDomain com.apple.mouse.forceClick -bool false

# Ctrl+cmd+click anywhere to drag a window
defaults write -g NSWindowShouldDragOnGesture -bool true

# Really hide the dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 2000
defaults write com.apple.dock no-bouncing -bool true

# Disable window animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Hide all desktop icons
defaults write com.apple.finder "CreateDesktop" -bool "false"

killall Dock
killall Finder
