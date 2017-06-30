### Creating Bacula Server 7.4.7 - Infrastructure as Code
<br>

![Alt text](img/bacula.png?raw=true "Ansible Bacula")

<hr>
<br>
Step 1 - Project clone 
<pre>
$ git clone https://github.com/vandocouto/Ansible-Bacula.git
</pre>
Step 2 - Accessing the project directory
<pre>
$ cd Ansible-Bacula
</pre>

TERRAFORM 

Step 3 - Configuring variables according to your sizing
<pre>
$ vim terraform/default/variables.tf
</pre>
Step 5 - Accessing directory terrform
<pre>
$ cd terraform
</pre>
Step 5 - Terraform plan
<pre>
$ ./deploy.sh default plan
</pre>
Step 6 - Terraform apply (Build project)
<pre>
$ ./deploy.sh default apply
</pre>

#### OUTPUT Terraform
<pre>
Outputs:

 Endpoint Bucket = storagebaculasd
 Endpoint MariaDB = bacula.crje9bunlidu.us-east-1.rds.amazonaws.com:3306
 Private IP = 10.0.0.191
 Public Elastic IP = 34.230.96.230

</pre>

ANSIBLE

Step 1 - Configuring the hosts file, according to the output of the terraform output
<pre>
[bacula]
34.230.96.230

[all:vars]
ansible_ssh_user=ubuntu
ansible_ssh_private_key_file=../chave/Blog-Estudo.pem
privateip=10.0.0.191

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

Step 2 - Running playbook
<pre>
$ ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts ./tasks/main.yml 
</pre>

