# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  token = ""
  region = "us-east-1"
}
# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity-T2" {
  ami           = "ami-0742b4e673072066f" # Amazon Linux 2 AMI (HVM), SSD
  instance_type = "t2.micro"
  count         = 4
}


# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity-M4" {
  ami           = "ami-0742b4e673072066f" # Amazon Linux 2 AMI (HVM), SSD
  instance_type = "m4.large"
  count         = 2
}
