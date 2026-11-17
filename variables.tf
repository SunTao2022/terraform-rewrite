variable "rg_name" {
  type    = string
  default = "terraform-rewrite-rg"
}

variable "rg_location" {
  type    = string
  default = "canadacentral"
}

variable "vnet_name" {
  type    = string
  default = "rewrite-vnet"
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  type    = string
  default = "rewrite_subnet"
}

variable "nsg_name" {
  type    = string
  default = "rewrite_nsg"
}

variable "ssh_ports" {
  type    = list(number)
  default = [22]
}

variable "ssh_source_cidr" {
  description = "Trusted public IP/CIDR allowed to SSH (for example 203.0.113.10/32). Do not use 0.0.0.0/0."
  type        = string
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key_path" {
  type = string
}

variable "vm_base_name" {
  type = string
}

variable "arm_client_id" {
  type = string
}

variable "arm_client_secret" {
  type      = string
  sensitive = true
}

variable "arm_tenant_id" {
  type = string
}

variable "arm_subscription_id" {
  type = string
}
