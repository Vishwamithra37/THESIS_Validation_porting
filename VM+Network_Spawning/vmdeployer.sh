. ./../keys/openstack.sh
openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image 6db1075a-66e8-46f0-b490-cd8dcae15b39 \
--security-group TATTA \
--nic net-id=5dbfc090-9d7d-4009-99d9-af055cf6d74c \
--key-name ooru oola3
sleep 15s
openstack server add floating ip oola3 91.123.203.57
sleep 7s
openstack server add fixed ip \
--fixed-ip-address 10.6.0.25 \
oola3 \
thesis
sleep 3s
eval `ssh-agent`
ssh-add ./../keys/openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./base.sh ubuntu@91.123.203.57:~/base.sh
scp -o StrictHostKeyChecking=no ./globalsv3 ubuntu@91.123.203.57:~/globalsv2.yml
scp -o StrictHostKeyChecking=no ./openstack.rc ubuntu@91.123.203.57:~/openstack.rc
scp -o StrictHostKeyChecking=no ./netplan ubuntu@91.123.203.57:~/netplan                                 
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@91.123.203.57
done
