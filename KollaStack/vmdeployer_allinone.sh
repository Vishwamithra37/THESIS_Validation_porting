floating_ip='91.123.203.36'
name='kollaController'
. ./../../keys2/openstack.sh
openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image 235d9bfb-7a13-4434-9966-cfc0ae033e79 \
--security-group TATTA \
--nic net-id=a611d38a-69fe-41a4-a35a-9b0c981e2982,v4-fixed-ip='192.168.0.5' \
--key-name ooru $name
sleep 15s
openstack server add floating ip $name $floating_ip
# Assign '91.123.203.36' to variable 'floating_ip'.

sleep 7s
openstack server add fixed ip \
--fixed-ip-address 192.169.0.6 \
$name \
net2
sleep 3s
eval `ssh-agent`
ssh-add ./../../keys2/openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./base_allinone.sh ubuntu@$floating_ip:~/base_allinone.sh
scp -o StrictHostKeyChecking=no ./../../keys2/openkey ubuntu@$floating_ip:~/openkey
scp -o StrictHostKeyChecking=no ./addssh.sh ubuntu@$floating_ip:~/sshadd.sh
scp -o StrictHostKeyChecking=no ./keystone.sql ubuntu@$floating_ip:~/keystone.sql
scp -o StrictHostKeyChecking=no ./glance-api.conf ubuntu@$floating_ip:~/glance.conf
# ssh -o StrictHostKeyChecking=no ubuntu@$floating_ip 'sudo apt update'
scp -o StrictHostKeyChecking=no ./openstack.rc ubuntu@$floating_ip:~/openstack.rc
scp -o StrictHostKeyChecking=no ./netplan ubuntu@$floating_ip:~/netplan                                 
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@$floating_ip
done
