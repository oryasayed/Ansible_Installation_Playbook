**Install ansible in Control Node, As am using Amazon Linux2 OS, Amazon-linux-extras will install all required dependencies**

```bash
#!/bin/bash
    sudo yum update -y                 # For Amazon Linux 2
    sudo amazon-linux-extras install ansible2 -y
    echo "Ansible installed" >> /tmp/ansible-installation.log
```

verify ansible version by running below command

```bash
ansible --version
```

```bash
which ansible
```

```bash
ansible-config dump
```

**Create a common user for all ansible activities**

Creating a user, Here am using "ansibleusr" user and set password.

```bash
useradd ansibleusr
```
```bash
passwd ansibleusr
```

**Provide Sudeoer permissions**
```bash
visudo
<img width="301" alt="image" src="https://github.com/user-attachments/assets/d7c40a36-5087-468b-a2d7-b4d48306c87a">

```

Add below entry to sudeor file.

```bash
ansibleuser ALL=(ALL) NOPASSWD: ALL
```

```bash
su - ansibleusr

sudo yum install -tree -y  # it's working now

now we have to go node and use the same method for the ansible user

```

**Enable SSH Connection across the instances.**

```bash
vim /etc/ssh/sshd_config
```
```bash
<img width="128" alt="image" src="https://github.com/user-attachments/assets/be208270-ce8b-406f-8679-5f7b63174740">

Set "PasswordAuthentication yes"

<img width="121" alt="image" src="https://github.com/user-attachments/assets/815dd257-1d81-4e2e-9a3d-de9e3fe7d452">

```
we need to restart the sshd
```bash
service sshd restart

we will do the same in our nodes as well
```

**Connect to all the nodes and Create common user same as Above.**

```bash
useradd ansibleusr
passwd ansibleusr
visudo
ansibleusr ALL=(ALL) NOPASSWD: ALL
su - ansibleusr
vim /etc/ssh/sshd_config
Set "PasswordAuthentication yes"
service sshd restart

ssh Node-ip
```
<img width="347" alt="image" src="https://github.com/user-attachments/assets/0a360534-8b5b-4fae-aa52-5efe3513f9d1">


**Configure password-less authentication.**

*Perform this on Control Node*

Create an SSH Public key and Private Key in Server and Copy Public Key to across the instances. Make sure you are doing this as ansibleusr, and perform this from Control Node.

```bash
ssh-keygen -t rsa
```
<img width="818" alt="image" src="https://github.com/user-attachments/assets/1a977bfc-c996-42fe-bf77-b80fb9368a79">

We only need ssh key in Asible svr not in nodes we have to copy to other nodes 

```bash
ssh-copy-id ansibleuser@Managed-node-1/2/3

<img width="537" alt="image" src="https://github.com/user-attachments/assets/c3e55109-cc54-48b2-8f6d-e3f6e97f956d">

do this for all the nodes

```

Now test the Password-less authentication. It should not prompt any password.

```bash
ssh Node-ip
<img width="344" alt="image" src="https://github.com/user-attachments/assets/7bf7b3b6-f797-4d5f-b209-409deea5341c">

Now it doesn't need password

```
***When we install ansible, we will get 3 IMP files under /etc/ansible***

<img width="248" alt="image" src="https://github.com/user-attachments/assets/eb842ed8-8fec-49d7-a0e6-4baa03a8e21c">

1. ansible-config
2. hosts
3. roles
   we will edit the ansible config file
   ![image](https://github.com/user-attachments/assets/01f5822c-16f6-48a2-98c0-fa4a91273ba6)

   and uncomment the inventory line
   <img width="200" alt="image" src="https://github.com/user-attachments/assets/ddb4adfd-d197-45d6-9bf1-3fc29bae4f3b">



In "ansible-config" file, hosts file entry is commented default.

Create a group in hosts file (i.e; webservers / web-group / dbservers)

<img width="247" alt="image" src="https://github.com/user-attachments/assets/921e3f7f-6a7a-4893-a3ea-cf0823925a5d">


<img width="158" alt="image" src="https://github.com/user-attachments/assets/6d8d9185-d0c8-41da-aa0e-e0861b40481d">

<img width="1705" alt="image" src="https://github.com/user-attachments/assets/fa890a6d-329b-4f20-ad6c-e2d548814deb">




**Commands to verify hosts**

To list all the hosts ansible is managing run below command.

```bash
ansible all --list-hosts
```

You can also ping all/group of nodes.

```bash
ansible all -m ping -v
```

If you want to list the nodes from a specific group, use below command

```bash
ansible mygroup --list-hosts
```
