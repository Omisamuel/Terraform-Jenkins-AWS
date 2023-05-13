resource "aws_security_group" "jenkins_stack_sg" {
  vpc_id      = aws_vpc.jenkins-vpc.id
  name        = "jenkins-stack-sg"
  description = "Sec Grp for jenkins ssh"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    self        = true
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    self        = true
    protocol    = "tcp"
    cidr_blocks = [var.LB]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    self        = true
    protocol    = "tcp"
    cidr_blocks = [var.ANYWHERE]
  }

  tags = {
    Name    = "jenkins-security-group"
    Project = "Jenkins"
  }
}
