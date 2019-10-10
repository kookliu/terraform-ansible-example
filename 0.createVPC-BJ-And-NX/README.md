# 0.createVPC-BJ-And-NX

关于这个部分只是初次使用Terraform的举例,用于在宁夏和北京的Region创建VPC/Subnet/RTB/NAT



这个目录里面只有3个文件：

1. providers.tf         提供商文件，也就是你接入哪个云环境，想控制啥？  这个地方实际上初步决定了你应该下哪种plugin来支持你的provider，某些特殊场景，会下载一些特殊的plugin,例如Null Plugin。
2. main.tf                主体配置文件，所有的配置写在这里。
3. output.tf             输出定义的变量结果。



虽然我们说这三个文件都有自己的说明，但是实际上Terraform在执行相关命令时，会自动将所有的tf合并处理，隐含依赖都是它独立控制点，所以和这个名字没有半毛钱关系，纯粹是你自己看着舒服，知道应该去哪找你编写的内容。

## providers.tf

```shell
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
```

这里一共分为三段，代表了我们对于哪个控制环境进行管理。

第一段，代表我们之前创建的Project账户下的北京区，进行管理。

第二段，代表我们之前创建的Project账户下的宁夏区，进行管理。

第三段，实际是对我自身账号的宁夏区进行管理。默认的情况下。



这段中，我们只需要修改role_arn，将其修改为您自己之前配置的那个即可。



## main.tf

```shell
##### for vpc :  igw vpc subnet  route-table nat
module "vpc" {
  source = "../terraform-modules/terraform-aws-vpc/"
  providers = {
    aws      = "aws.nx"
  }

  name = "nx-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["cn-northwest-1a", "cn-northwest-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Owner       = "cmct"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "cmct-vpc"
  }
}


module "vpc-bj" {
  source = "../terraform-modules/terraform-aws-vpc/"
  providers = {
    aws      = "aws.bj"
  }

  name = "bj-vpc"
  cidr = "172.0.0.0/16"

  azs             = ["cn-north-1a", "cn-north-1b"]
  private_subnets = ["172.0.1.0/24", "172.0.2.0/24"]
  public_subnets  = ["172.0.101.0/24", "172.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Owner       = "cmct"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "cmct-vpc"
  }
}

```



这段里面的参数是哪来的呢？实际上为了避免重复造轮子，Terrafrom除了提供丰富的资源接口，并且提供了丰富的模块，用于快速创建整个环境。

首先我们来理解一下Terraform的主站内容。



下面这个链接是Terraform介绍其基本语法的使用方法的。关于语法相关的部分，请在这个部分搜索。

- https://www.terraform.io/docs/configuration/index.html

下面这个链接是Provider为AWS时，里面资源使用的方法。

- https://www.terraform.io/docs/providers/aws/index.html



上面这两部分是Terraform的核心基础，但是我们目前的调用其实是对模块的使用，并不在这里。

Terraform写的官方模块在这里：https://github.com/terraform-aws-modules

而更多第三方的模块在这里可以找到：https://registry.terraform.io/





回到当前问题，我们来尝试执行命令，上面模块和参数的含义非常容易猜到，我们先去尝试执行一下terraform的基本命令，进行初步使用：



在当前目录下执行：



第一步：我们首次初始化所有模块并下载provider插件

$ terraform init 

第二步：执行计划预览

$ terraform plan

第三步：执行计划，并显示输出结果。

$ terraform apply

第四步：只输出结果

$ terraform output





并请到您的项目账号观察当前vpc相关资源的情况。



确认当前执行成功后，请再次执行：

$ terraform plan

$ terraform apply

查看执行结果的差异。



此时再次执行

$ ls -al

发现当前目录里面多出terraform的执行状态文件terraform.tfstate和上一次的状态文件terraform.tfstate.backup。这个状态文件就是你当前terraform对执行结果的记录，用自己特定的结构，记录了你当前命令的执行结果，保留了线上所有创建资源的状态。也就是通过这个文件实现了一致性。如果删除这个文件，你再次执行terraform plan,就会帮你再次创建所有资源。但是这个时候，会发生和实际环境的冲突。



综上，对此有所理解后，我们的问题就是进行参数传递，有哪些功能呢？我们就来看当前我们使用的这个模块。

| 代码                                                     | 含义说明                                               |
| -------------------------------------------------------- | ------------------------------------------------------ |
| module "vpc" {                                           | 意思定义了一个模块引用集合，名字是vpc，名字随便起。    |
| source = "../terraform-modules/terraform-aws-vpc/"       | 真正引用的模块地址，执行这个模块下所有的.tf            |
| providers = {<br/>    aws      = "aws.nx"<br/>  }        | 指定当前这个模块，使用的是项目组宁夏的Region来创建资源 |
| cidr = "172.0.0.0/16"                                    | 参数传递                                               |
| azs             = ["cn-northwest-1a", "cn-northwest-1b"] | 列表参数传递                                           |

   







output.tf

```shell
# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

//output "vpc_ipv6_cidr_block" {
//  description = "The IPv6 CIDR block"
//  value       = ["${module.vpc.vpc_ipv6_cidr_block}"]
//}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}

```

