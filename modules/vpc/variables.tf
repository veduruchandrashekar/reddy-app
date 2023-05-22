variable "cidr_block" {
    default = "10.20.0.0/16"
}
variable "instance_tenancy" {}


variable "vpc_id" {}
variable "subnet_id1" {}
variable "subnet_id2" {}
variable "subnet_cidr1" {
    default = "10.20.1.0/24"
}
variable "subnet_cidr2" {
  default = "10.20.2.0/24"
}



