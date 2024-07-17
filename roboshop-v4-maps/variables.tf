#variable "instance_type" {
#    default = "t2.micro"
#    }

variable "domain_name"{
    default = "mdevops24.online"
    }

variable "components" {
  default = {
    frontend = {
        instance_type = "t2.micro"
    }
    mongo = {
        instance_type = "t2.micro"
          }
    catalogue = {
            instance_type = "t2.micro"
        }
    }
}
