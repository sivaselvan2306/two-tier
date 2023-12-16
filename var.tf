#provider
variable aws_region {
  type = string
  description = "region name"
  default = "us-east-1"
}
#vpc
variable cidr_vpc {
  type        = string
  description = "cidr"
  default     = "10.0.0.0/16"
}
#pubnet1
variable pubnet1 {
  type = string
  description = "subnet"
  default = "10.0.1.0/24"
}
#pubnet2
variable pubnet2 {
  type = string
  description = "subnet"
  default = "10.0.2.0/24"
}
#pvtnet1
variable pvtnet1 {
  type = string
  description = "subnet"
  default = "10.0.3.0/24"
}
#pvtnet2
variable pvtnet2 {
  type = string
  description = "subnet"
  default = "10.0.4.0/24"
}
#az-pub1
#pubnet1
variable az_pubnet1 {
  type = string
  description = "subnet"
  default = "us-east-1a"
}
#pubnet2
variable az_pubnet2 {
  type = string
  description = "subnet"
  default = "us-east-1b"
}
#pvtnet1
variable az_pvtnet1 {
  type = string
  description = "subnet"
  default = "us-east-1a"
}
#pvtnet2
variable az_pvtnet2 {
  type = string
  description = "subnet"
  default = "us-east-1b"
}
#ami
variable ami_id {
  type = string
  description = "ami"
  default = "ami-0759f51a90924c166"
}
#instance type
variable instance_type {
  type = string
  description = "instance type"
  default = "t2.micro"
}
#username
variable db_username {
  type = string
  description = "username"
  default = "admin"
}
#password
variable db_password {
  type = string
  description = "password"
  default = "admin$312"
}
#availability zone
variable availability_zone_db {
  type = string
  description = "availability zone"
  default = "us-east-1a"
}

