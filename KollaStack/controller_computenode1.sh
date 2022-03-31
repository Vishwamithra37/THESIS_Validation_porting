nano multinode
kolla-ansible -i multinode bootstrap-servers --limit nova
kolla-ansible -i multinode pull --limit nova
kolla-ansible -i multinode deploy --limit nova