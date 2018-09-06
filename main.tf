/*
Copyright 2018 Bryan Frimin.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

resource "aws_network_interface" "main" {
  count           = "${var.count}"
  subnet_id       = "${element(var.subnet_ids, count.index)}"
  private_ips     = ["${cidrhost(element(var.subnet_cidr, count.index), 1)}"]
  security_groups = ["${aws_security_group.zookeeper-server.id}"]
}

resource "aws_instance" "zookeeper" {
  count                   = "${var.count}"
  ami                     = "${var.ami}"
  instance_type           = "${var.instance_type}"
  ebs_optimized           = "${var.ebs_optimized}"
  disable_api_termination = "${var.disable_api_termination}"
  monitoring              = "${var.monitoring}"
  user_data_base64        = "${var.user_data_base64}"

  network_interface {
    network_interface_id = "${element(aws_network_interface.main.*.id, count.index)}"
    device_index         = 0
  }

  tags {
    Name = "${var.name}-zookeeper-${count.index}"
  }
}

data "template_file" "zookeeper-properties" {
  template = "${file("${path.module}/zookeeper.properties.tpl")}"

  vars {
    zk1 = "${element(flatten(aws_network_interface.main.*.private_ips), 0)}"
    zk2 = "${element(flatten(aws_network_interface.main.*.private_ips), 1)}"
    zk3 = "${element(flatten(aws_network_interface.main.*.private_ips), 2)}"
  }
}

resource "aws_security_group" "zookeeper-server" {
  name   = "zookeeper-server"
  vpc_id = "vpc-3140e457"

  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "TCP"
    cidr_blocks = []
  }
}
