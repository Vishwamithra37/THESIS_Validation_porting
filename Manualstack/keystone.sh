floating_ip='91.123.203.36'
sudo apt update
ip link set ens7 up
apt install -y network-manager
sudo touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf
sudo service network-manager restart
add-apt-repository -y cloud-archive:wallaby
sudo apt install ca-certificates
sudo apt update
apt install -y rabbitmq-server
rabbitmqctl add_user openstack RABBIT_PASS
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
# apt install etcd
sudo apt install -y mariadb-server
# Use sed -i to bind to 0.0.0.0.
sed -i 's/bind-address.*/bind-address =0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb
sudo mysql < keystone.sql
sudo apt install -y keystone
sudo sed -i 's/sqlite\:\/\/\/\/var\/lib\/keystone\/keystone.db/mysql+pymysql\:\/\/keystone\:KEYSTONE_DBPASS@192.168.0.5\/keystone/g' /etc/keystone/keystone.conf
sudo sed -i 's/\#provider/provider/g' /etc/keystone/keystone.conf
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
sudo keystone-manage db_sync
echo $floating_ip' controller' >> /etc/hosts
keystone-manage bootstrap --bootstrap-password ADMIN_PASS \
--bootstrap-admin-url http://$floating_ip:5000/v3/ \
--bootstrap-internal-url http://$floating_ip:5000/v3/ \
--bootstrap-public-url http://$floating_ip:5000/v3/ \
--bootstrap-region-id RegionOne
service apache2 restart
export OS_USERNAME=admin
export OS_PASSWORD=ADMIN_PASS
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://$floating_ip:5000/v3
export OS_IDENTITY_API_VERSION=3
sudo apt install -y python3-openstackclient
# Stop here.
echo "############################################Keystone is supposed to be done.#########################################################"
openstack project create service --domain default --description "Service Project"
openstack user create --domain default --password ubuntu glance
openstack role add --project service --user glance admin
openstack service create --name glance \
--description "OpenStack Image" image
openstack endpoint create --region RegionOne \
image public http://$floating_ip:9292
openstack endpoint create --region RegionOne \
image internal http://$floating_ip:9292
openstack endpoint create --region RegionOne \
image admin http://$floating_ip:9292
sudo apt install -y glance
mv glance.conf /etc/glance/glance-api.conf
glance-manage db_sync
service glance-api restart
echo '############################################Glance has been successfully Installed#####################################################'
openstack user create --domain default --password ubuntu placement
openstack role add --project service --user placement admin
openstack service create --name placement --description "Placement API" placement
openstack endpoint create --region RegionOne placement public http://$floating_ip:8778
openstack endpoint create --region RegionOne placement internal http://$floating_ip:8778
openstack endpoint create --region RegionOne placement admin http://$floating_ip:8778
apt install -y placement-api
mv placement.conf /etc/placement/placement.conf
placement-manage db sync
service apache2 restart
echo '############################################Placement has been successfully Installed#####################################################'
openstack user create --domain default --password ubuntu nova
openstack role add --project service --user nova admin
openstack service create --name nova --description "OpenStack Compute" compute
openstack endpoint create --region RegionOne compute public http://$floating_ip:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://$floating_ip:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://$floating_ip:8774/v2.1
apt install -y nova-api nova-conductor nova-novncproxy nova-scheduler
mv nova.conf /etc/nova/nova.conf
nova-manage api_db sync
nova-manage cell_v2 map_cell0
nova-manage cell_v2 create_cell --name=cell1 --verbose
nova-manage cell_v2 list_cells
service nova-api restart
service nova-scheduler restart
service nova-conductor restart
service nova-novncproxy restart
echo '############################################Nova controller has been successfully Installed#####################################################'
openstack user create --domain default --password ubuntu neutron
openstack role add --project service --user neutron admin
openstack service create --name neutron --description "OpenStack Networking" network
openstack endpoint create --region RegionOne network public http://$floating_ip:9696
openstack endpoint create --region RegionOne network internal http://$floating_ip:9696
openstack endpoint create --region RegionOne network admin http://$floating_ip:9696
networkctl
apt install -y neutron-server neutron-plugin-ml2 \
neutron-linuxbridge-agent neutron-l3-agent neutron-dhcp-agent \
neutron-metadata-agent
mv dhcp_agent.ini /etc/neutron/dhcp_agent.ini
mv l3_agent.ini /etc/neutron/l3_agent.ini
mv linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini
mv metadata_agent.ini /etc/neutron/metadata_agent.ini
mv ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini
neutron-db-manage --config-file /etc/neutron/neutron.conf   --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head
service nova-api restart
service neutron-server restart
service neutron-linuxbridge-agent restart
service neutron-dhcp-agent restart
service neutron-metadata-agent restart
echo '############################################Neutron controller has been successfully Installed#####################################################'









# sudo sed -i 's/\[keystone_authtoken\]/\[keystone_authtoken\]\n'$toinsertintoglanceapiconf'/g' /etc/glance/glance-api.conf
# sed -i '/^#/d' /etc/glance/glance-api.conf
# sed -i '/^$/d' /etc/glance/glance-api.conf
# sudo sed -i 's/connection = sqlite:\/\/\/\/var\/lib\/glance\/glance.sqlite/connection = mysql+pymysql:\/\/glance:GLANCE_DBPASS@localhost\/glance/g' /etc/glance/glance-api.conf
# toinsertintoglanceapiconf="""
# www_authenticate_uri = http://controller:5000
# auth_url = http://controller:5000
# memcached_servers = controller:11211
# auth_type = password
# project_domain_name = Default
# user_domain_name = Default
# project_name = service
# username = glance
# password = ubuntu
# """
# service neutron-server restart
# service neutron-linuxbridge-agent restart
# service neutron-dhcp-agent restart
# service neutron-metadata-agent restart