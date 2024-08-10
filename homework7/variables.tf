variable "instance_type" {
    description = "Provide instance type"
    type        = string
    default     = ""
}

variable "region" {
    description = "Provide region"
    type        = string
    default     = ""
}

variable "allow_ports" {
    description = "List of ports to open for instance" 
    type        = list
    default     = []
}

variable "key_name" {
    description = "Provide key name" 
    type        = string
    default     = "" 
}

variable "count-ec2" {
    description = "Provide count ec2"    
    type        = number
    default     = 1
}

variable "name" {
  description   = "Provide name of instance"
  type          = string
  default       = ""
}