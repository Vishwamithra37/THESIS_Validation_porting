# Ansible managed

# Clear any old environment that may conflict.
for key in $( set | awk '{FS="="}  /^OS_/ {print $1}' ); do unset $key ; done
export OS_USERNAME=vishwa37
export OS_PASSWORD=projectmanam
export OS_AUTH_URL=https://fra1.citycloud.com:5000
export OS_USER_DOMAIN_NAME=CCP_Domain_39140
export OS_PROJECT_DOMAIN_NAME=CCP_Domain_39140
export OS_REGION_NAME=Fra1
export OS_PROJECT_NAME="Default Project 39140"
export OS_TENANT_NAME="Default Project 39140"
export OS_AUTH_VERSION=3
export OS_IDENTITY_API_VERSION=3
