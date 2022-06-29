#Works only in Virtual BOX. Specs: 6GB RAM, 2 Cores, 40 GB HDD, 2 NICs. Provide the ip of the controller. Using OSI ubuntu 20.04.
sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
sudo su - stack
git clone https://opendev.org/openstack/devstack
chmod 777 devstack
cd devstack
git checkout stable/wallaby
cp samples/local.conf .
HOST_IP=$1
echo "HOST_IP=${HOST_IP}" >> local.conf
sudo apt purge python3-simplejson
sudo apt purge python3-pyasn1-modules
# pip install pyasn1-modules

# systemctl restart "devstacl@*"