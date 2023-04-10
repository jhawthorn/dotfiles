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

# Disable "natural" (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture type -string "png"

# Disable "force click"
defaults write NSGlobalDomain com.apple.mouse.forceClick -bool false
