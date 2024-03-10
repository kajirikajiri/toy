terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

# プロバイダー
provider "openstack" {
  user_name = var.conoha_user_name
  password  = var.conoha_password
  tenant_id = var.conoha_tenant_id
  auth_url  = var.conoha_auth_url
}

# セキュリティグループ
resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = var.conoha_secgroup_name
  description = var.conoha_secgroup_description
}

# セキュリティグループルール
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction = var.conoha_allow_direction
  ethertype = var.conoha_allow_ethertype
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
  port_range_max = var.conoha_allow_port
  port_range_min = var.conoha_allow_port
  protocol = var.conoha_allow_protocol
  remote_ip_prefix = local.my_ip
}

# インスタンス
resource "openstack_compute_instance_v2" "instance_1" {
  name            = var.conoha_instance_name
  image_id        = var.conoha_image_id
  flavor_id       = var.conoha_flavor_id
  key_pair        = var.conoha_key_pair
  security_groups = [openstack_networking_secgroup_v2.secgroup_1.name]
  lifecycle {
    ignore_changes = [
      name,
      security_groups,
    ]
  }
}

