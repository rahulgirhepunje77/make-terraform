resource "aws_security_group" "demo_sg" {
  name = "terraform-demo-sg"

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
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "kind_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  root_block_device {
    volume_size = 25
    volume_type = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "Terraform-Kind-Server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [

      "sudo apt-get update -y",

      "sudo apt-get install -y docker.io",

      "sudo usermod -aG docker ubuntu",

      "newgrp docker",

      "sudo chmod 777 /var/run/docker.sock",

      "curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64",

      "chmod +x ./kind",

      "sudo mv ./kind /usr/local/bin/kind",

      "curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl",

      "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",

      "sudo apt-get install -y make",
      
      "kind create cluster --config k8s/kind-config.yaml --name terraform-kind",

      "docker --version",

      "kind --version",

      "kubectl version --client"
    ]
  }
}