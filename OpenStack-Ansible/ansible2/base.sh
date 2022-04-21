apt update
apt install build-essential git chrony openssh-server python3-dev sudo #do ssh
git clone -b 23.1.0 https://opendev.org/openstack/openstack-ansible /opt/openstack-ansible
./opt/openstack-ansible/scripts/bootstrap-ansible.sh
ssh devA
apt update
apt install bridge-utils debootstrap openssh-server tcpdump vlan python3
cp -a /opt/openstack-ansible/etc/openstack_deploy/. /etc/openstack_deploy/
cd /etc/openstack_deploy/
cp openstack_user_config.yml.example /etc/openstack_deploy/openstack_user_config.yml


