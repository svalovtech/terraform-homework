variable region {
  type =string
}


variable allow_ports {
 type = list 
}
variable key_name {
  type = string
}

variable subnet {
  type = list(object({
    cidr = string
    subnet_name = string
  }))
}

variable "instance_type" {
  type = string
}
    

variable vpc_cidr {
    type = list(object({
      cidr_block = string
      dns_support = bool
      dns_hostnames = bool
    }))
  
}