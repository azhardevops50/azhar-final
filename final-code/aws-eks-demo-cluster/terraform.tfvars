region                = "us-east-1"
cluster_name          = "my-eks-cluster"
instance_types        = ["t3a.medium"]
public-subnet-1-cidr  = "10.0.1.0/24"
public-subnet-2-cidr  = "10.0.2.0/24"
private-subnet-1-cidr = "10.0.3.0/24"
private-subnet-2-cidr = "10.0.4.0/24"
vpc_cidr              = "10.0.0.0/16"
cluster_version       = "1.32"
accountid             = "123456789012"
alb_certificate_arn   = "arn:aws:acm:region:account-id:certificate/certificate-id"
app_image             = "my-docker-repo/my-app:latest"