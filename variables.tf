variable "access_key" {
  sensitive = false
  default = ""
}

variable "secret_key" {
  sensitive = false
  default = ""
}

variable "region" {
  default = "us-east-2"
}

variable "ami" {
  default = "ami-0d8d212151031f51c"
}

variable "instance_type" {
  default = "t2.micro"
}


variable "tag" {
    default = ""
    type = string
}

variable "ssh-public-key" {
    default = ""
    type = string
}
