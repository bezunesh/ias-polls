variable "project" { }

variable "credentials_file" { }

variable "region" {
  default = "us-east4"
}

variable "zone" {
  default = "us-east4-a"
}

variable "cidrs" { default = [] }

variable "environment" {
  type    = string
  default = "staging"
}

variable "machine_types" {
  type    = map
  default = {
    dev  = "f1-micro"
    test = "n1-highcpu-32"
    prod = "n1-highcpu-32"
  }
}
