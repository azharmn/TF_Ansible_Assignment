  resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

tags = {
   Name = "terraform-vpc"
}
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my-vpc.id}"

  tags = {
    Name = "terraform-IGW"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = "${aws_vpc.my-vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "public-subnet-2a"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = "${aws_vpc.my-vpc.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "private-subnet-2b"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id     = "${aws_vpc.my-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "public-rt"
  }
}

  # Assign the route table to the public Subnet
resource "aws_route_table_association" "public-rt" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

resource "aws_security_group" "my_network" {
  name        = "my_network"
  description = "terraform_sg" 
  vpc_id     = "${aws_vpc.my-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 19999
    to_port     = 19999
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }


  tags = {
    Name = "terraform-sg"
  }
}

