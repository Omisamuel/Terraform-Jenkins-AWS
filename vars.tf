variable "REGION" {
  default = "us-west-2"
}

variable "ZONE1" {
  default = "us-west-2a"
}

variable "ZONE2" {
  default = "us-west-2b"
}

variable "ZONE3" {
  default = "us-west-2c"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-west-2 = "ami-0fcf52bcf5db7b003"
    us-west-1 = "ami-014d05e6b24240371"
  }
}

variable "USER" {
  default = "ubuntu"
}

variable "PUB_KEY" {
  default = "jenkins-key.pub"
}

variable "PRIV_KEY" {
  default = "jenkins-key"
}

variable "MYIP" {
  default = "193.159.40.236/32"
}

variable "ANYWHERE" {
  default = "0.0.0.0/0"
}

variable "MYANYWHERE" {
  default = "0.0.0.0/0"
}
