resource "aws_instance" "X" {
 ami           = "ami-0f403e3180720dd7e"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance X"
  }
}

resource "aws_instance" "Y"{
 ami           = "ami-0f403e3180720dd7e"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance Y"
  }
}
