. ./../../keys/openstack.sh
openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image 235d9bfb-7a13-4434-9966-cfc0ae033e79 \
--security-group TATTA \
--nic net-id=54b85f5a-081c-4dc1-914f-479732356b6ec \
--key-name ooru oola3
sleep 15s
openstack server add floating ip oola3 89.46.80.73
sleep 7s
openstack server add fixed ip \
--fixed-ip-address 192.168.1.2 \
oola3 \
net1

openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image 235d9bfb-7a13-4434-9966-cfc0ae033e79 \
--security-group TATTA \
--nic net-id=5dbfc090-9d7d-4009-99d9-af055cf6d74c \
--key-name ooru net1
sleep 15s
openstack server add floating ip oola2 45.114.123.189

sleep 3s
eval `ssh-agent`
ssh-add ./../../keys/openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./base.sh ubuntu@91.123.203.57:~/base.sh
scp -o StrictHostKeyChecking=no ./globalsv3 ubuntu@91.123.203.57:~/globalsv2.yml
scp -o StrictHostKeyChecking=no ./openstack.rc ubuntu@91.123.203.57:~/openstack.rc
scp -o StrictHostKeyChecking=no ./netplan ubuntu@91.123.203.57:~/netplan                                 
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@91.123.203.57
done
