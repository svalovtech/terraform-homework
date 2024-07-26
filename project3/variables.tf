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
variable vpc_cidr {
    type = list(object({
      cidr_block = string
      dns_support = bool
      dns_hostnames = bool
    }))
  
}

variable key_name {
  type = string
}

variable "traffic_distribution" {
  description = "Levels of traffic distribution"
  type        = string
}



locals {
  traffic_dist_map = {
    blue = {
      blue  = 100
      green = 0
    }
    blue-90 = {
      blue  = 90
      green = 10
    }
    split = {
      blue  = 50
      green = 50
    }
    green-90 = {
      blue  = 10
      green = 90
    }
    green = {
      blue  = 0
      green = 100
    }
  }
}