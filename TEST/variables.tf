variable "test_tags" {
  description = "Common Tags to apply to all resources"
  type        = list(any)
  default     = ["TEST-WEB", "AK89"]
}

variable "test_ports" {
  description = "Common Ports for test Security Group"
  type        = list(any)
  default     = [443, 80, 8080, 22]
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "Your VPC CIDR"
}

variable "private_subnet_cidr" {
  default = "10.0.99.0/24"
}