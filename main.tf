provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "us-west-2"
}

variable "aws_access_key" {
  description = "access key"
}

variable "aws_secret_key" {
  description = "secret key"
}

resource "aws_launch_template" "demo-lt" {
  name_prefix   = "demo-"
  image_id      = "ami-076b01046426fd1c5"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "demo-ag" {
  availability_zones = ["us-west-2a"]
  desired_capacity   = 3
  max_size           = 5
  min_size           = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  

  launch_template {
    id      = "${aws_launch_template.demo-lt.id}"
    version = "$$Latest"
  }
}
