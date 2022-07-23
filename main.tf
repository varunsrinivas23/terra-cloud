module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  ami                    = "ami-0cff7528ff583bf9a"
  instance_type          = "t2.micro"
  monitoring             = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
