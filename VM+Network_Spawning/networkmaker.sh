cd ./../../keys2
. openstack.sh
openstack network create net1 -f json
openstack router create router1
openstack subnet create --subnet-range 192.168.0.0/24 --allocation-pool start=192.168.0.2,end=192.168.0.20 --network net1 subnet1
openstack router add subnet router1 subnet1
openstack router set --external-gateway ext-net router1
openstack floating ip create ext-net -f json | jq -r '.floating_ip_address' > floating_ip
echo "Floating IP: $(cat floating_ip)"
# openstack floating ip delete $(cat floating_ip)
# openstack router unset --external-gateway router1
# openstack router remove subnet router1 subnet1
# openstack router delete router1
# openstack subnet delete subnet1
# openstack network delete net1


