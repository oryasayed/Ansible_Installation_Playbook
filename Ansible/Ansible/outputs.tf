output "Ansible" {
  value = aws_instance.Ansible.id
}

output "project_ec2_instance_public_ip" {
  value = aws_instance.Ansible.public_ip
}