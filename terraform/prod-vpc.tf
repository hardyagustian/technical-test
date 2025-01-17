# VPC id
resource "aws_vpc" "main-prod-vpc" {
  cidr_block           = "172.18.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Environment   = "production"
    Project       = "payments"
    Name          = "main-prod-vpc"
    Init          = "terraform"
    Billing       = "communication"
  }
}

## Subnet ###
## Private Subnet
resource "aws_subnet" "main-prod-private-subnet-a" {
  vpc_id            = aws_vpc.main-prod-vpc.id
  cidr_block        = "172.18.1.0/24"
  availability_zone = "${lookup(var.AWS_AZ_A, var.AWS_REGION)}"

  tags = {
    Name    = "main-prod-private-subnet-a"
    Init = "terraform"
    Billing = "communication"
  }
}
resource "aws_subnet" "main-prod-private-subnet-b" {
  vpc_id            = aws_vpc.main-prod-vpc.id
  cidr_block        = "172.18.2.0/24"
  availability_zone = "${lookup(var.AWS_AZ_B, var.AWS_REGION)}"

  tags = {
    Name    = "main-prod-private-subnet-b"
    Init = "terraform"
    Billing = "communication"
  }
}
resource "aws_subnet" "main-prod-private-subnet-c" {
  vpc_id            = aws_vpc.main-prod-vpc.id
  cidr_block        = "172.18.3.0/24"
  availability_zone = "${lookup(var.AWS_AZ_C, var.AWS_REGION)}"

  tags = {
    Name    = "main-prod-private-subnet-c"
    Init = "terraform"
    Billing = "communication"
  }
}

# Route tables to nat
resource "aws_route_table" "main-prod-private-rtb" {
  vpc_id = aws_vpc.main-prod-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main-nat-prod-private-natgw.id
  }

  tags = {
    Name    = "main-prod-private-rtb"
    Init = "terraform"
    Billing = "communication"
  }
}

# Route tables association to  private Subnets
resource "aws_route_table_association" "main-prod-private-rtb-assoc-a" {
  subnet_id      = aws_subnet.main-prod-private-subnet-a.id
  route_table_id = aws_route_table.main-prod-private-rtb.id
}
resource "aws_route_table_association" "main-prod-private-rtb-assoc-b" {
  subnet_id      = aws_subnet.main-prod-private-subnet-b.id
  route_table_id = aws_route_table.main-prod-private-rtb.id
}
resource "aws_route_table_association" "main-prod-private-rtb-assoc-c" {
  subnet_id      = aws_subnet.main-prod-private-subnet-c.id
  route_table_id = aws_route_table.main-prod-private-rtb.id
}


## Public Subnet
resource "aws_subnet" "main-prod-public-subnet-a" {
  vpc_id            = aws_vpc.main-prod-vpc.id
  cidr_block        = "172.18.5.0/24"
  availability_zone = "${lookup(var.AWS_AZ_A, var.AWS_REGION)}"

  tags = {
    Name    = "main-prod-public-subnet-a"
    Init = "terraform"
    Billing = "communication"
  }
}
resource "aws_subnet" "main-prod-public-subnet-b" {
  vpc_id            = aws_vpc.main-prod-vpc.id
  cidr_block        = "172.18.6.0/24"
  availability_zone = "${lookup(var.AWS_AZ_B, var.AWS_REGION)}"

  tags = {
    Name    = "main-prod-public-subnet-b"
    Init = "terraform"
    Billing = "communication"
  }
}
resource "aws_subnet" "main-prod-public-subnet-c" {
  vpc_id            = aws_vpc.main-prod-vpc.id
  cidr_block        = "172.18.7.0/24"
  availability_zone = "${lookup(var.AWS_AZ_C, var.AWS_REGION)}"

  tags = {
    Name    = "main-prod-public-subnet-c"
    Init = "terraform"
    Billing = "communication"
  }
}

## Internet Gateway
## main-prod IGW
resource "aws_internet_gateway" "main-prod-igw" {
  vpc_id = aws_vpc.main-prod-vpc.id

  tags = {
    Name    = "main-prod-igw"
    Init = "terraform"
    Billing = "communication"
  }
}

## Route tables
## Route public to IGW
resource "aws_route_table" "main-prod-route-live-rtb" {
  vpc_id = aws_vpc.main-prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-prod-igw.id
  }
  tags = {
    Name    = "main-prod-route-live-rtb"
    Init = "terraform"
  }
}

## Route live subnet association to IGW
resource "aws_route_table_association" "main-prod-public-subnet-assoc-a" {
  subnet_id      = aws_subnet.main-prod-public-subnet-a.id
  route_table_id = aws_route_table.main-prod-route-live-rtb.id
}

resource "aws_route_table_association" "main-prod-public-subnet-assoc-b" {
  subnet_id      = aws_subnet.main-prod-public-subnet-b.id
  route_table_id = aws_route_table.main-prod-route-live-rtb.id
}

resource "aws_route_table_association" "main-prod-public-subnet-assoc-c" {
  subnet_id      = aws_subnet.main-prod-public-subnet-c.id
  route_table_id = aws_route_table.main-prod-route-live-rtb.id
}

#### RDS ####
#### Subnet Group #####
resource "aws_db_subnet_group" "private-prod-db-subnet-group" {
  name        = "private-prod-db-subnet-group"
  subnet_ids  = [
                 "aws_subnet.main-prod-private-subnet-a.id",
                 "aws_subnet.main-prod-private-subnet-b.id",
                 "aws_subnet.main-prod-private-subnet-c.id"
                ]

  tags = {
    Name    = "private-prod-db-subnet-group"
    Init    = "terraform"
    Billing = "communication"
  }
}

resource "aws_db_subnet_group" "public-prod-db-subnet-group" {
  name        = "public-prod-db-subnet-group"
  subnet_ids  = [
                 "aws_subnet.main-prod-public-subnet-a.id",
                 "aws_subnet.main-prod-public-subnet-b.id",
                 "aws_subnet.main-prod-public-subnet-c.id"
                ]

  tags = {
    Name    = "public-prod-db-subnet-group"
    Init    = "terraform"
    Billing = "communication"
  }
}

#### elasticache ####
#### Subnet Group #####
resource "aws_elasticache_subnet_group" "private-prod-elasticache-subnet-group" {
  name        = "private-prod-elasticache-subnet-group"
  subnet_ids  = [
                 "aws_subnet.main-prod-private-subnet-a.id",
                 "aws_subnet.main-prod-private-subnet-b.id",
                 "aws_subnet.main-prod-private-subnet-c.id"
                ]

  tags = {
    Name    = "private-prod-elasticache-subnet-group"
    Init    = "terraform"
    Billing = "communication"
  }
}

resource "aws_elasticache_subnet_group" "public-prod-elasticache-subnet-group" {
  name        = "public-prod-elasticache-subnet-group"
  subnet_ids  = [
                 "aws_subnet.main-prod-public-subnet-a.id",
                 "aws_subnet.main-prod-public-subnet-b.id",
                 "aws_subnet.main-prod-public-subnet-c.id"
                ]

  tags = {
    Name    = "public-prod-elasticache-subnet-group"
    Init    = "terraform"
    Billing = "communication"
  }
}
