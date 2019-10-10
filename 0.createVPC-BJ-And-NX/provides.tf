##
provider "aws" {
  alias = "bj"
  region = "cn-north-1"
  assume_role {
    role_arn     = "arn:aws-cn:iam::123932990026:role/terraform-assume-role"
  }
}

provider "aws" {
  alias = "nx"
  region = "cn-northwest-1"
  assume_role {
    role_arn     = "arn:aws-cn:iam::123932990026:role/terraform-assume-role"
  }
}

provider "aws" {
  region = "cn-northwest-1"
}