provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}


data "aws_ami" "ubuntu_us_east_1" {
  provider    = aws.us_east_1
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "ubuntu_us_east_2" {
  provider    = aws.us_east_2
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_ami" "ubuntu_test" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# // Code that creates resources in 2 regions
# resource "aws_instance" "web1" {
#   ami = data.aws_ami.ubuntu_us_east_1.id
#   instance_type = "t2.micro"

#   provider = aws.us_east_1
# }

# resource "aws_instance" "web2" {
#   ami = data.aws_ami.ubuntu_us_east_2.id
#   instance_type = "t2.micro"

#   provider = aws.us_east_2
# }

// 1 module, used twice for two different regions (us-east-1 and us-east-2)
module "instance_east_1" {
  source = "./modules/ec2-instance"

  providers = {
    aws = aws.us_east_1
  }

  ec2_ami       = data.aws_ami.ubuntu_us_east_1.id
  instance_type = "t2.micro"
}


module "instance_east_2" {
  source = "./modules/ec2-instance"

  providers = {
    aws = aws.us_east_2

  }

  ec2_ami       = data.aws_ami.ubuntu_us_east_2.id
  instance_type = "t2.micro"
}

// This code causes an error, because of the configuration_aliases setting inside the child's terraform block
# module "instance_test" {
#   source = "./modules/ec2-instance"

#   ec2_ami       = data.aws_ami.ubuntu_test.id
#   instance_type = "t2.micro"
# }

