floating_ip='91.123.203.36'
floating_ip2='192.169.0.6'
sudo apt update
chmod 400 openkey
apt install ca-certificates -y
##########################
ip link set ens7 up
apt install -y network-manager
sudo touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf
sudo service network-manager restart
#########################
sudo apt install -y python3-dev libffi-dev gcc libssl-dev
sudo apt install -y python3-pip
sudo apt install -y python3-testresources
pip install ansible-core==2.11.9
sudo pip3 install git+https://opendev.org/openstack/kolla-ansible@master
sudo mkdir -p /etc/kolla
sudo chown $USER:$USER /etc/kolla
cp -r /usr/local/share/kolla-ansible/etc_examples/kolla/* /etc/kolla
cp /usr/local/share/kolla-ansible/ansible/inventory/* .
git clone --branch master https://opendev.org/openstack/kolla-ansible
sudo pip3 install ./kolla-ansible
sudo mkdir -p /etc/kolla
sudo chown $USER:$USER /etc/kolla
cp -r kolla-ansible/etc/kolla/* /etc/kolla
cp kolla-ansible/ansible/inventory/* .
kolla-ansible install-deps
kolla-genpwd
eval `ssh-agent`
ssh-add openkey
echo $floating_ip' controller' >> /etc/hosts
echo $floating_ip2' nova' >> /etc/hosts
mv nmultinode multinode
pip install ansible
