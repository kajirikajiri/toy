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

# インスタンス
resource "openstack_compute_instance_v2" "instance_1" {
  name            = var.conoha_instance_name
  image_id        = var.conoha_image_id
  flavor_id       = var.conoha_flavor_id
  key_pair        = var.conoha_key_pair
  user_data       = var.conoha_user_data
  security_groups = var.conoha_security_groups
  lifecycle {
    ignore_changes = [
      name,
      security_groups
    ]
  }
}

output "instance_ip_addr" {
  value = openstack_compute_instance_v2.instance_1.access_ip_v4
  sensitive = true
}
