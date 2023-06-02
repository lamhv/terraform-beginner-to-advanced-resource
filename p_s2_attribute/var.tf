variable "subnet_range_ip" {
  type = string
}

// internal IP address
variable "private_ip" {
  type    = string
}

variable "range_ports" {
  type    = list(string)
}