variable "AWS_REGION" {
  default = "ap-southeast-1"
}

variable "AWS_ID" {
  default = "xxxxxxx"
}

variable "IAC_REPO_BRANCH" {
  default = "sysdevops-iac:master"
}

variable "AWS_AZ_A" {
  type = map
  default = {
    "ap-southeast-1" = "ap-southeast-1a"
    "ap-southeast-2" = "ap-southeast-2a"
  }
}

variable "AWS_AZ_B" {
  type = map
  default = {
    "ap-southeast-1" = "ap-southeast-1b"
    "ap-southeast-2" = "ap-southeast-2b"
  }
}

variable "AWS_AZ_C" {
  type = map
  default = {
    "ap-southeast-1" = "ap-southeast-1c"
    "ap-southeast-2" = "ap-southeast-2c"
  }
}

variable "EC2_AMI" {
  type = map
  default = {
    "ap-southeast-1" = "ami-0ff297662c4840aa5"
    "ap-southeast-2" = "ami-0009ba887e00637bd"
  }
}
variable "EC2_KEYNAME" {
  default = "dev_keypair"
}
