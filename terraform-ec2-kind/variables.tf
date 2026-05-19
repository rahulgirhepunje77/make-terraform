variable "aws_region" {
  default = "ap-south-1"
}

variable "ami_id" {
  default = "ami-07a00cf47dbbc844c"
}

variable "instance_type" {
  default = "t2.xlarge"
}

variable "key_name" {
  default = "terraform-key"
}

variable "private_key_path" {
  default = "terraform-key.pem"
}