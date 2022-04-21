. ./openstack.sh
openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image 235d9bfb-7a13-4434-9966-cfc0ae033e79 \
--security-group TATTA \
--nic net-id=5dbfc090-9d7d-4009-99d9-af055cf6d74c \
--key-name ooru ansible
sleep 15s
openstack server add floating ip ansible 91.123.203.6
sleep 7s
openstack server add fixed ip \
--fixed-ip-address 10.6.0.30 \
ansible \
thesis

sleep 3s
eval `ssh-agent`
ssh-add ./openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./base.sh ubuntu@91.123.203.6:~/base.sh                           
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@91.123.203.6
done
