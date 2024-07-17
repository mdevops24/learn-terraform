

variable "instance_type" {
    default = "t2.micro"
    }


variable "domain_name"{
    default = "mdevops24.online"
    }

variable "components" {
  default = ["frontend", "mongo", "catalogue"]
}