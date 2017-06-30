// Zone
variable "zone" {
	default = "us-east-1"
}

variable "avzone" {
    type = "list"
	default = ["us-east-1b", "us-east-1d", "us-east-1c", "us-east-1e"]
}

variable "subnet" {
	type = "list"
	default = ["subnet-bda4e7e6" , "subnet-ce7cf5f2" , "subnet-ae085c83" , "subnet-2264616b" ]
}

variable "key" {
	default = "Blog-Estudo"
}

variable "vpc" {
	default = "vpc-a4f76ec2"
}

variable "cidr" {
	default = "10.0.0.0/22"
}


variable "security" {
	default = "sg-68600514"
}

// EC2
variable "instance" {
	default = "1"
}

variable "size_so" {
        default = "70"
}

variable "size_cache" {
        default = "50"
}

variable "type_disk_cache" {
        default = "gp2"
}

variable "type_disk_so" {
        default = "gp2"
}

variable "type" {
	default = "t2.medium"
}

variable "ami" {
	default = "ami-f4cc1de2"
}

variable "ssh_user_name" {
  	default = "ubuntu"
}

variable "ssh_key_file" {
  	default = "../../chave/Blog-Estudo.pem"
}

// RDS
variable "identifier" {
  description = "Endpoint"
  default = "bacula"
}

variable "db_name" {
  description = "Database name"
  default = "bacula"
}

variable "username" {
  description = "User master"
  default = "root"
}

variable "password" {
  description = "Enter Password BD"
  default   = "passroot"
}

variable "storage" {
  default = "50"
}

variable "engine" {
  default     = "mariadb"
  description = "Engine type, example values mariadb, mysql, postgres"
}

variable "engine_version" {
  type = "map"
  description = "Engine version"
  default = {
    mariadb  = "10.1.19"
    mysql    = "5.6.22"
    postgres = "9.4.1"
  }
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "multi_az" {
  default = "false"
}

variable "backup_retentiion" {
  default = "7"
}

// S3
variable "bucket" {
	description = "name bucket"
	default = ""
}

