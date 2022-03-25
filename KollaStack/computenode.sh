floating_ip='89.46.80.73'
. ./../../keys2/openstack.sh
openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image 235d9bfb-7a13-4434-9966-cfc0ae033e79 \
--security-group TATTA \
--nic net-id=54b85f5a-081c-4dc1-914f-479732356b6e,v4-fixed-ip=192.168.0.6 \
--key-name ooru oola4
sleep 15s
openstack server add floating ip oola4 $floating_ip
# Assign '91.123.203.36' to variable 'floating_ip'.


sleep 7s
openstack server add fixed ip \
--fixed-ip-address 192.169.0.11 \
oola4 \
net2
sleep 3s
eval `ssh-agent`
ssh-add ./../../keys2/openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./computenodefiles/neutron.conf ubuntu@$floating_ip:~/neutron.conf
scp -o StrictHostKeyChecking=no ./computenodefiles/nova.conf ubuntu@$floating_ip:~/nova.conf
scp -o StrictHostKeyChecking=no ./nova.sh ubuntu@$floating_ip:~/nova.sh


# ssh -o StrictHostKeyChecking=no ubuntu@$floating_ip 'sudo apt update'
scp -o StrictHostKeyChecking=no ./openstack.rc ubuntu@$floating_ip:~/openstack.rc
scp -o StrictHostKeyChecking=no ./netplan ubuntu@$floating_ip:~/netplan                                 
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@$floating_ip
done
