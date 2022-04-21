. ./openstack.rc
openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image 6db1075a-66e8-46f0-b490-cd8dcae15b39 \
--security-group TATTA \
--nic net-id=5dbfc090-9d7d-4009-99d9-af055cf6d74c \
--key-name ooru puppetry1
sleep 15s
openstack server add floating ip puppetry1 45.114.123.189
sleep 7s
openstack server add fixed ip \
--fixed-ip-address 10.6.0.26 \
puppetry1 \
thesis
sleep 3s
eval `ssh-agent`
ssh-add ./openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./base.sh ubuntu@45.114.123.189:~/base.sh
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@45.114.123.189
done
