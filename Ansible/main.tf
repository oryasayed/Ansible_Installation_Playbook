provider "aws" {
  region = var.region
}

module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  us_availability_zone = var.us_availability_zone
  cidr_private_subnet  = var.cidr_private_subnet
}

module "security_group" {
  source              = "./security-groups"
  ec2_sg_name         = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  vpc_id              = module.networking.project_vpc_id
  ec2_Ansible_sg_name = "Allow port 8080 for Ansible"
}

module "Ansible" {
  source                    = "./Ansible"
  ami_id                    = var.ec2_ami_id
  instance_type             = "t2.medium"
  tag_name                  = "Ansible"
  subnet_id                 = tolist(module.networking.project_public_subnets)[0]
  sg_for_Ansible           = [module.security_group.sg_ec2_sg_ssh_http_id, module.security_group.sg_ec2_Ansible_port_8080]
  enable_public_ip_address  = true
  user_data_install_Ansible = templatefile("./Ansible-runner-script/Ansible-installer.sh", {})
}

