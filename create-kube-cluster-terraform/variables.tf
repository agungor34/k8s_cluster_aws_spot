
variable "myRegion" {
  default = "us-east-2"
}

variable "myAZs" {
  default = "us-east-2a"
}

variable "myKey" {
  default = "us-east-2-kp"
}

variable "myTag" {
  default = "patrick"
}
variable "myAmi" {
  description = "amazon linux 2 ami"
  default = "ami-05fb0b8c1424f266b"
}

variable "myInstancetype" {
  default = "t3a.large"
}
