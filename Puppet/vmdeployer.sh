. ./../../keys2/openstack.sh
openstack server create \
--flavor 19178315-27c1-4506-b6a7-7697cbc6d6b5 \
--image a4703fcd-3e1d-4cda-9790-89b96ed834c4 \
--security-group TATTA \
--nic net-id=b769df65-5ae1-42eb-b775-f15dd4671513 \
--key-name ooru puppetry1
sleep 15s
openstack server add floating ip puppetry1 185.103.51.171
sleep 7s
openstack server add fixed ip \
--fixed-ip-address 10.6.0.26 \
puppetry1 \
net3
sleep 3s
eval `ssh-agent`
ssh-add ./../../keys2/openkey
rm ~/.ssh/known_hosts
scp -o StrictHostKeyChecking=no ./base.sh ubuntu@185.103.51.171:~/base.sh
while :
do
ssh -o StrictHostKeyChecking=no ubuntu@185.103.51.171
done
