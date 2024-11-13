resource "aws_instance" "Ansible" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = "ec2_keypair"

  tags = {
    Name = var.tag_name
  }
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_for_Ansible
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_Ansible

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}