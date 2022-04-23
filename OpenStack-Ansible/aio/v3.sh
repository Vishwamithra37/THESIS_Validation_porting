. ./openstack.sh
openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image 235d9bfb-7a13-4434-9966-cfc0ae033e79 \
--security-group TATTA \
--nic net-id=54b85f5a-081c-4dc1-914f-479732356b6e \
--key-name ooru ansible
sleep 15s
openstack server add floating ip ansible 91.123.203.36
sleep 7s
openstack server add fixed ip \
--fixed-ip-address 192.168.0.10 \
ansible \
net1

sleep 3s
eval `ssh-agent`
ssh-add ./openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./base.sh ubuntu@91.123.203.36 :~/base.sh                           
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@91.123.203.36 
done
