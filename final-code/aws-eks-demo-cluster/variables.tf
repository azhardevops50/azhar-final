variable "region" {}
variable "cluster_name" {}
variable "instance_types" {}
variable "public-subnet-1-cidr" {}
variable "public-subnet-2-cidr" {}
variable "private-subnet-1-cidr" {}
variable "private-subnet-2-cidr" {}
variable "vpc_cidr" {}
variable "cluster_version" {}
variable "accountid" {}
variable "alb_certificate_arn" {}
variable "app_image" {
  description = "Docker image for the application"
  type        = string
}