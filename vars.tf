variable "name" {
  description = "Name of the Azure stack"
}

variable "location" {
  description = "Azure region where resources will be deployed"
}

variable "vnetcidr" {
  description = "CIDR block for the virtual network"
}

variable "websubnetcidr" {
  description = "CIDR block for the web subnet"
}

variable "appsubnetcidr" {
  description = "CIDR block for the app subnet"
}

variable "dbsubnetcidr" {
  description = "CIDR block for the database subnet"
}

variable "web_host_name_1" {
  description = "Hostname for the first web VM"
}

variable "web_host_name_2" {
  description = "Hostname for the second web VM"
}

variable "web_username" {
  description = "Admin username for web VMs"
}

variable "web_os_password" {
  description = "Admin password for web VMs"
}

variable "app_host_name" {
  description = "Hostname for the app VM"
}

variable "app_username" {
  description = "Admin username for app VM"
}

variable "app_os_password" {
  description = "Admin password for app VM"
}

variable "primary_database" {
  description = "Name of the primary database"
}

variable "primary_database_admin" {
  description = "Admin username for the primary database"
}

variable "primary_database_password" {
  description = "Admin password for the primary database"
}

variable "primary_database_version" {
  description = "Version of the primary database"
}
