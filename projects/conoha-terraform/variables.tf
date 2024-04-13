variable "conoha_user_name" {
  description = "ConoHaのユーザー名"
  type        = string
  sensitive   = true
}

variable "conoha_password" {
  description = "ConoHaのパスワード"
  type        = string
  sensitive   = true
}

variable "conoha_tenant_id" {
  description = "ConoHaのテナントID"
  type        = string
  sensitive   = true
}

variable "conoha_auth_url" {
  description = "ConoHaの認証URL"
  type        = string
  sensitive   = true
}

variable "conoha_security_groups" {
  description = "ConoHaのsecurty_groupの名前リスト"
  type        = list(string)
  sensitive   = true
}

variable "conoha_secgroup_description" {
  description = "ConoHaのsecurtygroupの説明"
  type        = string
  sensitive   = true
}

variable "conoha_allow_port" {
  description = "ConoHaの許可するPort"
  type        = number
  sensitive   = true
}

variable "conoha_allow_ethertype" {
  description = "ConoHaの許可するEthtype"
  type        = string
  sensitive   = true
}

variable "conoha_allow_direction" {
  description = "ConoHaの許可するdirection"
  type        = string
  sensitive   = true
}

variable "conoha_allow_protocol" {
  description = "ConoHaの許可するprotocol"
  type        = string
  sensitive   = true
}

variable "conoha_instance_name" {
  description = "ConoHaのinstance名"
  type        = string
  sensitive   = true
}

variable "conoha_image_id" {
  description = "ConoHaのimage_id"
  type        = string
  sensitive   = true
}

variable "conoha_flavor_id" {
  description = "ConoHaのflavor_id"
  type        = string
  sensitive   = true
}

variable "conoha_key_pair" {
  description = "ConoHaのkey_pair"
  type        = string
  sensitive   = true
}

variable "conoha_user_data" {
  description = "ConoHaのuser_data"
  type        = string
  sensitive   = true
}

