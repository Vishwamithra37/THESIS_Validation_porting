floating_ip='89.46.80.73'
floating_ip2='91.123.203.36'
ip link set ens7 up
apt install -y network-manager
sudo touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf
sudo service network-manager restart
echo $floating_ip2' controller' >> /etc/hosts
apt update
apt install -y nova-compute
apt install -y neutron-linuxbridge-agent
mv ./computenodefiles/nova.conf /etc/nova/nova.conf
mv ./computenodefiles/neutron.conf /etc/neutron/neutron.conf
service nova-compute restart
service neutron-linuxbridge-agent restart





# sed -i '/^#/d' /etc/glance/glance-api.conf
# sed -i '/^$/d' /etc/glance/glance-api.conf