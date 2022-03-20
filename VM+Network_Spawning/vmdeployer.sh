. ./../../keys2/openstack.sh
openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image 6db1075a-66e8-46f0-b490-cd8dcae15b39 \
--security-group TATTA \
--nic net-id=54b85f5a-081c-4dc1-914f-479732356b6e \
--key-name ooru oola3
sleep 15s
floating_ip='91.123.203.36'
openstack server add floating ip oola3 $floating_ip
# Assign '91.123.203.36' to variable 'floating_ip'.

sleep 7s
openstack server add fixed ip \
--fixed-ip-address 192.168.0.6 \
oola3 \
net2
sleep 3s
eval `ssh-agent`
ssh-add ./../../keys2/openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./base.sh ubuntu@$floating_ip:~/base.sh
scp -o StrictHostKeyChecking=no ./globalsv3 ubuntu@$floating_ip:~/globalsv2.yml
scp -o StrictHostKeyChecking=no ./openstack.rc ubuntu@$floating_ip:~/openstack.rc
scp -o StrictHostKeyChecking=no ./netplan ubuntu@$floating_ip:~/netplan                                 
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@$floating_ip
done
