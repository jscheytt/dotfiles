# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew bundle install
# RECOMMENDED: Install color schemes https://github.com/mbadolato/iTerm2-Color-Schemes
# RECOMMENDED: Copy settings from ./iterm2 to a location of your choice and use it as a starting point for your iTerm2 configuration

# Set up ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
upgrade_oh_my_zsh
# RECOMMENDED: Read the oh_my_zsh documentation and activate plugins that are relevant for you: https://github.com/ohmyzsh/ohmyzsh
# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
echo "ZSH_THEME=powerlevel10k/powerlevel10k" >> ~/.zshrc
# p10k configure

# Configure AWS CLI
# aws configure
# Configure Git
# git config --global user.name "Dein Name"
# git config --global user.email "du@company.de"
# You are now set to clone repositories

# Ruby
rbenv install 2.6.5
rbenv install 2.7.1
rbenv global 2.7.1
rbenv rehash
