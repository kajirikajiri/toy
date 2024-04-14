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

