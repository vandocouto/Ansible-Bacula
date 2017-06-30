provider "aws" {
	region = "${var.zone}"
}

# Security Group Bacula
resource "aws_security_group" "Bacula" {
  name        = "Bacula"
  description = "Used in the terraform"
  vpc_id      = "${var.vpc}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9101
    to_port     = 9101
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 9102
    to_port     = 9102
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9103
    to_port     = 9103
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = -1
    self        = true
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.cidr}"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "ip-wan" {
  	instance = "${aws_instance.Bacula.id}"
  	depends_on = ["aws_instance.Bacula"]
  	vpc      = true
}

# Deploy Instance
resource "aws_instance" "Bacula" {
  count                       = "${var.instance}"
  subnet_id                   = "${element(var.subnet, count.index)}"
  instance_type               = "${var.type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key}"
  security_groups             = ["${aws_security_group.Bacula.id}"]
  associate_public_ip_address = true
  root_block_device {
    volume_size               = "${var.size_so}"
    volume_type               = "${var.type_disk_so}"
    }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "${var.type_disk_cache}"
    volume_size = "${var.size_cache}"
    delete_on_termination = true
  }
  tags {
    Name = "Bacula"
  }
  provisioner "remote-exec" {
    connection {
      user = "${var.ssh_user_name}"
      private_key = "${file(var.ssh_key_file)}"
    }
  }
  user_data = "${file("script.sh")}"
}

# Deploy RDS
resource "aws_db_subnet_group" "Bacula" {
    name       = "baculamysql"
    subnet_ids = "${var.subnet}"
}

resource "aws_db_instance" "default" {
    depends_on                = ["aws_security_group.Bacula"]
    multi_az                  = "${var.multi_az}"
    backup_retention_period   = "${var.backup_retentiion}"
    publicly_accessible       = "true"
    identifier                = "${var.identifier}"
    allocated_storage         = "${var.storage}"
    engine                    = "${var.engine}"
    engine_version            = "${lookup(var.engine_version, var.engine)}"
    instance_class            = "${var.instance_class}"
    name                      = "${var.db_name}"
    username                  = "${var.username}"
    password                  = "${var.password}"
    vpc_security_group_ids    = ["${aws_security_group.Bacula.id}"]
    db_subnet_group_name      = "${aws_db_subnet_group.Bacula.id}"
}

// Deploy S3
resource "aws_s3_bucket" "bacula" {
    bucket = "${var.bucket}"
    acl    = "private"
    force_destroy = "true"

    tags {
        Name        = "${var.bucket}"
        Environment = "Prod"
    }
}

// Output
output "Private IP" {
	value = "${join(",", aws_instance.Bacula.*.private_ip)}"
 
}

//output "Public IP" {
//    value = "${join(",", aws_instance.Bacula.*.public_ip)}"
//
//}

output "Public Elastic IP" {
        value = "${join (",", aws_eip.ip-wan.*.public_ip)}"
}

output "Endpoint MariaDB" {
        value = "${join("," , aws_db_instance.default.*.endpoint)}"
}

output "Endpoint Bucket" {
        value = "${join ("," , aws_s3_bucket.bacula.*.bucket)}"
}

