#######################################Random users are created#########################################3
openstack user create --domain default --password thesis a1
openstack role add --project default --user a1 _member_
openstack user create --domain default --password thesis a2
openstack role add --project default --user a2 _member_
openstack user create --domain default --password thesis a3
openstack role add --project default --user a3 _member_
openstack user create --domain default --password thesis a4
openstack role add --project default --user a4 _member_
openstack project create --domain default --description "Thesis Project" thesis
openstack role add --project thesis --user a1 _member_
openstack role add --project thesis --user a2 _member_
openstack role add --project thesis --user a3 _member_    
openstack role add --project thesis --user a4 _member_
########################################Random users are created############################################
count=5
for i in $(seq 1 $count)
openstack image create \
--file ./cirro.img \
--unprotected \
--public \
cirro+$i
done
#########################################Images are created##################################################
#########################################Creating networks###################################################
openstack network create --subnet-project-domain default --subnet-project thesis --subnet-domain default --external --provider-network-type flat --provider-physical-network physnet1 --router:external --provider-segment 1 net1
openstack subnet create --network net1 --subnet-range 192.168.0.0/24 --gateway 192.168.0.1 --dns-nameserver 192.168.0.1
#########################################Creating networks###################################################
#########################################Creating router######################################################
openstack router create router1
openstack router add subnet router1 net1
#########################################Creating router######################################################
#########################################Creating security group###############################################
openstack security group create --description "default security group" default
openstack security group rule create --ingress --protocol tcp --destination-port 22 default
#########################################Creating security group###############################################
#########################################Creating keypair######################################################
openstack keypair create --public-key ./../../keys2/openkey.pub openkey
#########################################Creating keypair######################################################
#########################################Creating flavor#######################################################
openstack flavor create --ram 512 --disk 1 --vcpus 1 m1.tiny
#########################################Creating flavor#######################################################
#########################################Creating VM###########################################################
openstack server create \
--flavor m1.tiny \
--image cirro+1 \
--security-group default \
--nic net-id=net1 \
--key-name openkey \
--wait \
vm1
openstack server create \
--flavor m1.tiny \
--image cirro+1 \
--security-group default \
--nic net-id=net1 \
--key-name openkey \
--wait \
vm1
#########################################Creating VM###########################################################







