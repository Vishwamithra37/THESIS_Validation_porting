floating_ip='91.123.203.36'
add-apt-repository cloud-archive:wallaby
sudo apt update
sudo apt install ca-certificates
sudo apt install -y mariadb-server
sudo mysql < keystone.sql
sudo apt install -y keystone
sudo sed -i 's/sqlite\:\/\/\/\/var\/lib\/keystone\/keystone.db/mysql+pymysql\:\/\/keystone\:KEYSTONE_DBPASS@localhost\/keystone/g' /etc/keystone/keystone.conf
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
echo "Keystone is supposed to be done."

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
echo 'Glance has been successfully Installed'

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