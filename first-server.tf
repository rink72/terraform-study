provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "creds"
}


resource "aws_instance" "hello-world" {
  ami = "ami-2d39803a"
  instance_type = "t2.nano"

  tags {
    Name = "terraform-study"

  }
}
