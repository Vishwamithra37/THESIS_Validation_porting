floating_ip='91.123.203.36'
name='kollaController'
. ./../../keys2/openstack.sh
openstack server create \
--flavor 2 \
--image 235d9bfb-7a13-4434-9966-cfc0ae033e79 \
--security-group TATTA \
--nic net-id=54b85f5a-081c-4dc1-914f-479732356b6e,v4-fixed-ip='192.168.0.5' \
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
scp -o StrictHostKeyChecking=no ./base.sh ubuntu@$floating_ip:~/base.sh
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
