
echo -n "Please enter the Sensu server public/private IP address: "
#stty -echo
read sensu_server_IP


echo -n "Please enter the Sensu clinet public/private IP address: "
#stty -echo
read sensu_client_IP


echo -n "Please enter the Sensu clinet private IP address: "
#stty -echo
read sensu_server_private_IP

echo -n "Please enter root user password of Sensu Server: "
stty -echo
read root_pass

# Ubuntu
if [ -f /etc/lsb-release ]; then
sudo apt-get -y install software-properties-common
yes '' | sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible
sudo apt-get -y install git
fi

#Centos
if [ -f /etc/redhat-release ]; then
sudo yum -y install epel-release
sudo yum -y install git
sudo yum -y install ansible
fi

# Download sensu script from bitbucket

sudo git clone https://glistenreadrepo:Glisten2014@bitbucket.org/glistensoft/sensu.git


cd sensu/
sudo sed -ie '/\[sensu-server\]/a '$sensu_server_IP' ansible_connection=ssh ansible_user=root ansible_ssh_pass='\"$root_pass\"' ' inventory/hosts


sudo sed -ie '/\[sensu-client\]/a '$sensu_client_IP' ansible_connection=ssh ansible_user=root ansible_ssh_pass='\"$root_pass\"'' inventory/hosts


sudo sed -ie 's/10.0.0.217/'$sensu_server_private_IP'/g' group_vars/ip.yml

#Sensu server installation/configuration

cd ../sensu/plays/
ansible-playbook sensu-server.yml

#Sensu clinet installation/configuration

ansible-playbook sensu-client.yml
