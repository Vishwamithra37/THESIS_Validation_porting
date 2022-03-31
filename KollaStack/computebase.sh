sudo apt update
apt install ca-certificates -y
##########################
ip link set ens7 up
apt install -y network-manager
sudo touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf
sudo service network-manager restart