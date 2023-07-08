  ##c8.local ec2 instance
  resource "aws_instance" "frontend" {
  ami = "ami-031e6a417aae9b9f6"
  instance_type = "t2.micro"
  key_name = "terraform_oregon"
  vpc_security_group_ids = ["${aws_security_group.my_network.id}"] 
  subnet_id = "${aws_subnet.public-subnet.id}"
  availability_zone = "us-west-2a"
  associate_public_ip_address = true

    root_block_device {
    volume_size = "10"
    volume_type = "gp2"
    delete_on_termination = true 
 }

 tags = {
    Name = "c8.local"
  }
}

##u21.local ec2 instance
  resource "aws_instance" "backend" {
  ami = "ami-03f65b8614a860c29"
  instance_type = "t2.micro"
  key_name = "terraform_oregon"
  vpc_security_group_ids = ["${aws_security_group.my_network.id}"] 
  subnet_id = "${aws_subnet.public-subnet.id}"
  availability_zone = "us-west-2a"
  associate_public_ip_address = true


    root_block_device {
    volume_size = "10"
    volume_type = "gp2"
    delete_on_termination = true 
 }

 tags = {
    Name = "u21.local"
  }
}
