DOMAIN=${DOMAIN:=openshift.delta.com}
IPADDR=${IPADDR:=192.168.165.129}
USERNAME=${USERNAME:=developer}
PASSWORD=${PASSWORD:=password}
sudo yum install -y epel-release
sudo yum install -y docker wget zip unzip git
sudo yum install -y pyton-cryptography pyOpenSSL.x86_64
sudo yum install -y "@Development Tools" python2-pip openssl-devel python-devel python
sudo pip install pip --upgrade
sudo pip install passlib
sudo pip install -Iv ansible==2.3.1.0
sudo yum -y install httpd-tools
echo ${IPADDR} ${DOMAIN}>> /etc/hosts
ssh-keygen -t rsa
ssh-copy-id root@${DOMAIN}
echo 'INSECURE_REGISTRY="--insecure-registry 172.30.0.0/16"' >> /etc/sysconfig/docker
wget https://github.com/openshift/openshift-ansible/archive/release-1.4.zip
unzip release-1.4.zip
mv openshift-ansible-release-1.4/ openshift-ansible/
ansible-playbook -i priyatest/inventory.erb openshift-ansible/playbooks/byo/config.yml
cd /etc/origin/master/
htpasswd -c /etc/origin/master/htpasswd developer
