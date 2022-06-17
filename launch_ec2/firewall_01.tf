
resource "aws_network_interface" "fw_01_eth0" {
  subnet_id         = local.fw_01_eth0_subnet_id
  private_ips       = [local.fw_01_eth0_ip]
  source_dest_check = false
  security_groups   = [aws_security_group.fw.id]
  tags              = merge(local.tags, { interface : "eth0", firewall : local.fw_01_name, name : "${local.fw_01_name}_eth0", "Name" : "${local.fw_01_name}_eth0" })
}

resource "aws_network_interface" "fw_01_eth1" {
  subnet_id         = local.fw_01_eth1_subnet_id
  private_ips       = [local.fw_01_eth1_ip]
  source_dest_check = true
  security_groups   = [aws_security_group.fw.id]
  tags              = merge(local.tags, { interface : "eth1", firewall : local.fw_01_name, name : "${local.fw_01_name}_eth1", "Name" : "${local.fw_01_name}_eth1" })
}

resource "aws_instance" "fw_01" {
  availability_zone = local.fw_01_availability_zone

  network_interface {
    network_interface_id = aws_network_interface.fw_01_eth0.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.fw_01_eth1.id
    device_index         = 1
  }

  launch_template {
    id      = aws_launch_template.fw.id
    version = local.fw_01_template_version
  }

  disable_api_termination = true

  tags = merge(local.tags, { firewall : local.fw_01_name, name : local.fw_01_name, "Name" : local.fw_01_name })

  # Open Issue https://github.com/hashicorp/terraform-provider-aws/issues/5011
  lifecycle {
    ignore_changes = [user_data]
  }
}
