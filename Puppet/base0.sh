apt install ca-certificates
sudo apt-get update
sudo apt upgrade -y
ifconfig ens7 up
apt-install python3-pip
wget https://apt.puppetlabs.com/puppet5-release-wheezy.deb
sudo dpkg -i puppet5-release-wheezy.deb
apt install puppet
puppet module install openstack-openstacklib --version 18.4.0
apt update -y
git clone https://opendev.org/openstack/puppet-openstack-integration
cd puppet-openstack-integration
./all-in-one.sh