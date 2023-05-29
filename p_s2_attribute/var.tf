variable "subnet_range_ip" {
  default = "10.0.0.0/16"
}

// internal IP address
variable "private_ip" {
  default = "10.0.42.42"
}

variable "range_ports" {
  type    = list(string)
  default = ["80", "8080", "1000-2000"]
}