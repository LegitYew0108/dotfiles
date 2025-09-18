cd ${HOME}
# install git
sudo apt install git gh
gh auth login
git clone git@github.com:LegitYew0108/dotfiles.git

# install fcitx5
sudo apt install fcitx5-mozc -y

# install neovim
sudo apt install curl zip xclip -y
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm -rf nvim-linux-x86_64.tar.gz

rm -rf ${HOME}/.config/nvim
ln -s ${HOME}/dotfiles/nvim ${HOME}/.config/nvim

# install nerd font
sudo mkdir -p /usr/local/share/fonts/
cd /usr/local/share/fonts/
sudo curl -LO -# https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip
sudo unzip 0xProto.zip -n
sudo rm -rf 0xProto.zip LICENSE README.md
fc-cache -f -v
cd ${HOME}

# install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install stable
nvm alias default stable

# install gemini-cli
pnpm install -g @google/gemini-cli

# install c env
sudo apt install gnupg build-essential -y
curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/llvm.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/llvm.gpg] http://apt.llvm.org/jammy/ llvm-toolchain-jammy main" | sudo tee /etc/apt/sources.list.d/llvm.list > /dev/nul
sudo apt install clang llvm lld lldb clang-format -y

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
export PATH="$PATH:$HOME/.cargo/bin"

# install zellij
cargo install --locked zellij

# install wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
sudo apt update
sudo apt install wezterm
ln -s ${HOME}/dotfiles/wezterm ${HOME}/.config/wezterm

# install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm -rf lazygit.tar.gz

# set default terminal emulator
sudo update-alternatives --config x-terminal-emulator

# install ROS 2
bash ${HOME}/dotfiles/install_ros2_humble.sh

# install discord
sudo snap install discord

# install vivaldi
curl -Lo vivaldi.deb https://downloads.vivaldi.com/stable/vivaldi-stable_7.6.3797.52-1_amd64.deb
sudo apt install ./vivaldi.deb
rm -rf vivaldi.deb

# install zsh
sudo apt install zsh
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm -rf ${HOME}/.zshrc
ln -s ${HOME}/dotfiles/.zshrc ${HOME}/.zshrc
# install p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# install fast-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

chsh -s /bin/zsh
zsh
