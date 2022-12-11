# Setup script for a new macOS installation.
# This script will require you to be present and agree to various packages when necessary
# If you want to change the machine name, do that and reboot before executing

HERE=$HOME/code/dotfiles/setup

# Create SSH key pair
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
# ssh-keygen -t ed25519 -C "$USER@$(hostname)"


# Install all the required things
sudo apt-get install -y \
	tmux \
	htop \
	python3 \
	vim \
	git \
	curl \
	wget \
	pip \
	openssh-server \
    docker \
    docker-compose \
    cifs-utils \
	ffmpeg

python3 -m pip install --upgrade pip
pip3 install flake8 nox

# Install Oh My ZSH -----------------------------------------------------------
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Color schemes 
# https://github.com/lysyi3m/macos-terminal-themes
# Right now I'm digging Afterglow
# git clone https://github.com/lysyi3m/macos-terminal-themes.git

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

mkdir -p ~/.local/bin ~/.venv

cp $HERE/../bin/* ~/.local/bin

cat $HERE/aliases_functions_etc/common >> ~/.profile

# Set difftool
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
git config --global --add difftool.prompt false

# Mount my shit
sudo mkdir -p /media/nastyboi/home
sudo mkdir -p /media/nastyboi/share
