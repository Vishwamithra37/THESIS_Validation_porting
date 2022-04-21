. openstack.rc
openstack server create \
--flavor 7d1807d8-81d1-431c-b990-da31f228c72a \
--image 6db1075a-66e8-46f0-b490-cd8dcae15b39 \
--security-group TATTA \
--nic net-id=5dbfc090-9d7d-4009-99d9-af055cf6d74c \
--key-name ooru oola3
openstack server add floating ip oola3 91.123.203.57
openstack server add fixed ip \
--fixed-ip-address 10.6.0.25 \
oola3 \
thesis
eval `ssh-agent`
ssh-add ./openkey
rm ~/.ssh/known_hosts
while :
do
ssh 91.123.203.57
done