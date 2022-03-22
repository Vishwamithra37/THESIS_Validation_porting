openstack image create \
--id bionic \
--container-format bare \
--disk-format raw \
--file ./cirro.img \
--unprotected \
--public \
bionic