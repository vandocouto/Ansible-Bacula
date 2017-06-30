
<pre>

</pre>

<pre>
./deploy.sh default plan
</pre>

<pre>
./deploy.sh default apply
</pre>

<pre>
Outputs:

Endpoint Bucket = storagebaculasd
Endpoint MariaDB = bacula.crje9bunlidu.us-east-1.rds.amazonaws.com:3306
Private IP = 10.0.0.191
Public Elastic IP = 34.230.96.230

</pre>

<pre>
[bacula]
34.225.145.56

[all:vars]
ansible_ssh_user=ubuntu
ansible_ssh_private_key_file=../chave/Blog-Estudo.pem
privateip=10.0.0.103

# MariaDB
useradmin=root
bdpassadmin=passroot
bdpassuser=tutoriais2017
bdendpoint=bacula.crje9bunlidu.us-east-1.rds.amazonaws.com

# Bacula
linkbacula=https://downloads.sourceforge.net/project/bacula/bacula/7.4.7/bacula-7.4.7.tar.gz
dirbacula=bacula-7.4.7

# Bacula Pass
baculapass=geIeA6w+IVRaWuKNioA687uSeZia64VRZHJ7dFYidZaq
server_name=BaculaServer

# S3 - Aws info credentials access S3
bucket=
accesskey=
keypass=
</pre>

<pre>
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts ./tasks/main.yml 
</pre>
