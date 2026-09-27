#!/bin/bash

# ==========================================
# Volatility 2.6.1 Installation Script
# ==========================================

echo -e "\033[35m[*] Updating package repositories...\033[0m"
sudo apt update

# ==========================================
# Install system dependencies
# ==========================================

echo -e "\033[35m[*] Installing system dependencies...\033[0m"

sudo apt install -y \
    build-essential \
    libcrypt-dev \
    python2 \
    python2-dev \
    curl \
    git

# ==========================================
# Install pip2
# ==========================================

echo -e "\033[35m[*] Installing pip2...\033[0m"

if command -v pip2 >/dev/null 2>&1; then
    echo -e "\033[32m[+] pip2 is already installed.\033[0m"
else
    curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
    python2 get-pip.py
    rm -f get-pip.py
fi

# pip2 may be installed in /usr/local/bin
export PATH="/usr/local/bin:$PATH"

# ==========================================
# Verify Python 2 and pip2
# ==========================================

echo -e "\033[35m[*] Checking Python 2...\033[0m"
python2 --version

echo -e "\033[35m[*] Checking pip2...\033[0m"
/usr/local/bin/pip2 --version

# ==========================================
# Install Python dependencies
# ==========================================

echo -e "\033[35m[*] Installing Volatility Python dependencies...\033[0m"

/usr/local/bin/pip2 install pycrypto
/usr/local/bin/pip2 install distorm3==3.4.4
/usr/local/bin/pip2 install Pillow
/usr/local/bin/pip2 install yara-python==3.7.0

# ==========================================
# Find existing Volatility installation
# ==========================================

search_dir=/opt
volatility_found=false

file_path=$(grep -rl "Volatility Foundation Volatility Framework" \
    "$search_dir" \
    --include="vol.py" \
    2>/dev/null | head -n 1)

if [ -n "$file_path" ]; then

    dir_path=$(dirname "$file_path")

    echo -e "\033[32m[+] Found Volatility at: $file_path\033[0m"

    cd "$dir_path"
    volatility_found=true

else

    echo -e "\033[31m[-] Volatility not found. Cloning repository...\033[0m"

    cd /opt

    git clone https://github.com/volatilityfoundation/volatility.git

    echo -e "\033[32m[+] Volatility cloned to /opt/volatility\033[0m"

    cd /opt/volatility
fi

# ==========================================
# Verify Python dependencies
# ==========================================

echo -e "\033[35m[*] Checking Python dependencies...\033[0m"

python2 -c "from Crypto.Hash import MD5; print('[+] Crypto OK')"

python2 -c "import distorm3; print('[+] distorm3 OK')"

# ==========================================
# Run Volatility
# ==========================================

echo -e "\033[35m[*] Testing Volatility...\033[0m"

python2 vol.py --info

# ==========================================
# Installation complete
# ==========================================

if [ "$volatility_found" = true ]; then
    echo -e "\033[32m[+] Volatility is already installed at $dir_path\033[0m"
else
    echo -e "\033[32m[+] Volatility is installed at /opt/volatility\033[0m"
fi

echo -e "\033[32m[+] Volatility 2.6.1 installation completed successfully.\033[0m"
