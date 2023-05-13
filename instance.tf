resource "aws_key_pair" "Jen-keys" {
  key_name   = "jenkins"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "jenkins" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.jenkins-pub-1.id
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.Jen-keys.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_stack_sg.id]
  tags = {
    Project = "my-jenkins"
  }

  provisioner "file" {
    source      = "jenkins.sh"
    destination = "/tmp/jenkins.sh"


    connection {
      type        = "ssh"
      user        = var.USER
      private_key = file(var.PRIV_KEY)
      host        = self.public_ip
    }
  }

}

resource "aws_ebs_volume" "vol_4_jenkins" {
  availability_zone = var.ZONE1
  size              = 8
  tags = {
    Name = "extr-vol-4-jenkins"
  }
}

resource "aws_volume_attachment" "atch_vol_jenkins" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol_4_jenkins.id
  instance_id = aws_instance.jenkins.id
}

#TO PRINT

output "PublicIP" {
  value = aws_instance.jenkins.public_ip
}

output "PrivateIP" {
  value = aws_instance.jenkins.private_ip
}
