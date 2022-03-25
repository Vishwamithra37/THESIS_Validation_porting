floating_ip='89.46.80.73'
eval `ssh-agent`
ssh-add ./../../keys2/openkey
rm ~/.ssh/known_hosts
ssh -o StrictHostKeyChecking=no ubuntu@$floating_ip