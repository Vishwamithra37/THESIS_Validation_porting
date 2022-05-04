apt install ca-certificates
sudo apt-get update
sudo apt upgrade -y
sudo apt-get --allow-unauthenticated upgrade
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4528B6CD9E61EF26
git clone https://opendev.org/openstack/puppet-openstack-integration
git checkout -b remotes/origin/stable/wallaby
cd puppet-openstack-integration
./all-in-one.sh