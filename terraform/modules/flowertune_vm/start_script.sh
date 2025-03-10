#!/bin/bash

FLAG_FILE="/etc/startup.flag"

# Check if the script has already been executed
if [ -f "$FLAG_FILE" ]; then
    echo "Startup script already executed."
    exit 0
fi

echo "Running startup script for the first time..."

# Create the flower user
adduser --gecos ""  --shell /bin/bash flower
usermod -aG sudo flower
passwd -d flower
chage -d 0 flower
echo 'flower  ALL=(ALL:ALL) ALL' >> /etc/sudoers

# Generate an SSH key pair for flower user non-interactively and move the root authorized_keys contents to flower's .ssh.
sudo -i -u flower bash << 'EOF'
mkdir -p ~/.ssh
chmod 700 ~/.ssh
# Generate a 4096-bit RSA key pair with an empty passphrase
ssh-keygen -q -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
EOF

# If root has an authorized_keys file, append its content to flower's, then remove from root
if [ -f /root/.ssh/authorized_keys ]; then
    cat /root/.ssh/authorized_keys >> /home/flower/.ssh/authorized_keys
    rm -f /root/.ssh/authorized_keys
fi

# Upgrade base system
apt-get update -y
apt-get upgrade -y

# Install Python Deps
apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils \
    tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    python-is-python3 python3-pip pipx g++

# Install CUDA 12.6
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.6.0/local_installers/cuda-repo-ubuntu2204-12-6-local_12.6.0-560.28.03-1_amd64.deb
dpkg -i cuda-repo-ubuntu2204-12-6-local_12.6.0-560.28.03-1_amd64.deb
cp /var/cuda-repo-ubuntu2204-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/
apt-get update -y
apt-get install -y cuda-toolkit-12-6
rm -f cuda-repo-ubuntu2204-12-6-local_12.6.0-560.28.03-1_amd64.deb

# Upgrade pip, wheel, setuptools
python -m pip install --upgrade pip wheel setuptools packaging

# Fix permissions for flower's .ssh
chown -R flower:flower /home/flower/.ssh
chmod 700 /home/flower/.ssh
chmod 600 /home/flower/.ssh/authorized_keys 2>/dev/null || true

# 4. Install and configure pyenv and eval deps for the flower user
sudo -i -u flower bash << 'EOF'
curl -fsSL https://pyenv.run | bash
export PATH="$HOME/.pyenv/bin:$PATH"

# Append pyenv config to .bashrc
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# Source .bashrc to have pyenv available immediately
source ~/.bashrc

# For Hugging Face Login
git config --global credential.helper store

# Install nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install 20

# Install Python 3.11.11 and set it global
pyenv install 3.11.11
pyenv global 3.11.11

# Install and activate flower venv
pyenv virtualenv flower
pyenv activate flower

# Upgrade pip, wheel and setuptools on flower venv.
python -m pip install --upgrade pip wheel setuptools packaging
EOF

# Clean up
apt-get -y autoremove
apt-get -y clean

# 5. Create a flag file to indicate the script has run
touch "$FLAG_FILE"
echo "Startup script execution completed."
