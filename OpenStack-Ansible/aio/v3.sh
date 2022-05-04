. ./openstack.sh
openstack server create \
--flavor f6408fad-eed3-4261-87ab-80ad59462e55 \
--image 235d9bfb-7a13-4434-9966-cfc0ae033e79 \
--security-group TATTA \
--nic net-id=1d9fea2d-f3e7-4eac-bf00-9cbfb1d346e9 \
--key-name ooru ansible
sleep 15s
openstack server add floating ip ansible 91.123.203.203
sleep 7s
openstack server add fixed ip \
--fixed-ip-address 192.168.0.18 \
ansible \
net1

sleep 3s
eval `ssh-agent`
ssh-add ./openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./base.sh ubuntu@91.123.203.203:~/base.sh                           
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@91.123.203.203
done
