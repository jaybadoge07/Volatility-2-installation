## Installation

To use this script, follow these steps:

### 1. Clone the Repository

Clone this repository to your local machine using Git:

```bash
git clone https://github.com/jaybadoge07/Volatility-2-installation.git
```

### 2. Make the Script Executable

Change the permissions of the installation script to make it executable:

```bash
chmod +x Installation.sh
```

### 3. Run the Script

Run the installation script to automatically check and install Volatility 2.6.1 and its required dependencies:

```bash
sudo ./Installation.sh
```

The script will install the required dependencies, including:

* Python 2.7
* `build-essential`
* `libcrypt-dev`
* `pycrypto`
* `distorm3`
* Volatility 2.6.1

After the installation completes, verify Volatility using:

```bash
cd /opt/volatility
python2 vol.py --info
```
