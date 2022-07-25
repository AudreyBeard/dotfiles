# Setup script for a new macOS installation.
# This script will require you to be present and agree to various packages when necessary
# If you want to change the machine name, do that and reboot before executing

HERE=$HOME/code/dotfiles/setup

# Create SSH key pair
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
ssh-keygen -t ed25519 -C "$USER@$(hostname)"


# Install Brew ----------------------------------------------------------------
# https://brew.sh
# NOTE if this command errors out, try to clone anything with Git and follow the system dialog boxes
#  Though if you've gotten this far you probably already have Git installed so it'll probably be fine
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all the required things
brew install tmux
brew install htop
brew install python
brew install vim

python3 -m pip install --upgrade pip
pip3 install flake8

# Install Oh My ZSH -----------------------------------------------------------
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Use Brew-installed binaries before others (specifically Vim)
echo "export PATH=/opt/homebrew/bin:\$PATH" >> ~/.zshrc

## cs function
echo "" >> ~/.zshrc
echo "# CS: combines cd and ls in one easy command" >> ~/.zshrc
echo "function cs () {" >> ~/.zshrc
echo "  cd \"$@\" && ls" >> ~/.zshrc
echo "}" >> ~/.zshrc

# Color schemes 
# https://github.com/lysyi3m/macos-terminal-themes
# Right now I'm digging Afterglow
git clone https://github.com/lysyi3m/macos-terminal-themes.git

# Vim -------------------------------------------------------------------------
## pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

## Vim Plugins
cd ~/.vim/bundle

## PEP8 linter
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic
cp -r ~/.vim/bundle/syntastic/autoload ~/.vim/autoload/syntastic

## Vimwiki!
git clone https://github.com/vimwiki/vimwiki.git ~/.vim/bundle/vimwiki
cp -r ~/.vim/bundle/vimwiki/autoload ~/.vim/autoload/vimwiki

# NERDTree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
cp -r ~/.vim/bundle/nerdtree/autoload ~/.vim/autoload/nerdtree

# Go back
cd $HERE

cp $HERE/../.vimrc ~/.vimrc