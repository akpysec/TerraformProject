variable "prod_tags" {
  description = "Common Tags to apply to all resources"
  type        = list(any)
  default     = ["PROD-WEB", "AK89"]
}

variable "prod_ports" {
  description = "Common Ports for PROD Security Group"
  type        = list(any)
  default     = [443, 80, 8080]
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "Your VPC CIDR"
}

variable "public_subnet_cidr" {
  default = "10.0.100.0/24"
}