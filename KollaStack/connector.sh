floating_ip='91.123.203.36'
eval `ssh-agent`
ssh-add ./../../keys2/openkey
rm ~/.ssh/known_hosts
ssh -o StrictHostKeyChecking=no ubuntu@$floating_ip