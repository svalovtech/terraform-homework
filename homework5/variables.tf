variable region {
  type =string
}

variable rt_names {
  type = list(string)
}

variable ing_name {
  type = string
}

variable port {
 type = list 
}

variable subnet {
  type = list(object({
    cidr = string
    subnet_name = string
  }))
}
variable ec2_ins {
  type = list(object ({
    instance_type = string 
    name = string
    }))
}
variable vps_cidr {
    type = list(object({
      cidr_block = string
      dns_support = bool
      dns_hostnames = bool
    }))
  
}