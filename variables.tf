variable "access_key" {
  type      = string
  sensitive = true
}
variable "secret_key" {
  type      = string
  sensitive = true
}

variable "region" {
  type = string
}

variable "public_subnet_1_cidrs" {
  type        = string
  description = "The first public subnet CIDR values"
  default     = "172.16.1.0/24"
}

variable "public_subnet_2_cidrs" {
  type        = string
  description = "The second public subnet CIDR values"
  default     = "172.16.2.0/24"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}
