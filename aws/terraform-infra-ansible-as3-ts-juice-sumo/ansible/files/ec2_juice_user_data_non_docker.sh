#!/bin/bash
# Send all command output to /var/log/user-data.log
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/var/log/user-data-out.log 2>&1

echo "--- START -- $(date) ---"
echo ""
echo "--- UPDATE YUM ---"
yum update -y
echo "--- wget https://github.com/bkimminich/juice-shop/releases/download/v11.0.1/juice-shop-11.0.1_node14_linux_x64.tgz --"
wget https://github.com/bkimminich/juice-shop/releases/download/v11.0.1/juice-shop-11.0.1_node14_linux_x64.tgz
echo "--- tar zxfv juice-shop-11.0.1_node14_linux_x64.tgz "
tar zxfv juice-shop-11.0.1_node14_linux_x64.tgz
echo "--- curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
echo " export NVM variables"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
echo "--- nvm install node"
nvm install node
echo "--- cd juice-shop_11.0.1/"
cd juice-shop_11.0.1/
echo "--- npm start"
npm start