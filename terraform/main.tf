provider "aws" {
  region = "eu-west-1"
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_key}"
}

locals {
  run_ansible_script = <<EOS
    sudo ANSIBLE_CONFIG=/tmp/staging/ansible/config/ansible.cfg \
    ansible-playbook /tmp/staging/ansible/playbook.yml \
    --extra-vars=@/tmp/staging/settings.json --connection=local --inventory /tmp/staging/ansible/inventory.yml
  EOS
}

resource "aws_security_group" "web" {
  name = "terraform"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "web" {
  key_name = "terraform"
  public_key = "${var.aws_ssh_public_key}"
}

resource "aws_instance" "web" {
  ami = "${var.aws_ami_id}"
  instance_type = "${var.aws_instance_type}"
  key_name = "terraform"
  security_groups = ["terraform"]

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${var.aws_ssh_private_key}"
  }

  tags {
    Name = "${var.app_name}"
  }

  provisioner "remote-exec" {
    inline = ["mkdir /tmp/staging"]
  }

  provisioner "file" {
    source = "${path.root}/../ansible"
    destination = "/tmp/staging"
  }

  provisioner "file" {
    source = "${path.root}/../settings.json"
    destination = "/tmp/staging/settings.json"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo ansible-galaxy install -r /tmp/staging/ansible/requirements.yml",
      "${local.run_ansible_script}",
      "rm -rf /tmp/staging"
    ]
  }
}

resource "aws_eip" "web" {
  instance = "${aws_instance.web.id}"
}

output "public_ip" {
  value = "${aws_eip.web.public_ip}"
}
