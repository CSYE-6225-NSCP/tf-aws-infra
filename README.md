# tf-aws-infra

In this setup i configured the following aws-infra:

1. Vpc 
2. route table
3. private and public subnets
4. internet gateway

Setting up the infra:

1. download the file 
2. configure the terraform init in dev-infra
3. create terraform.tfvars for variables with the following lines:
 
<!-- aws_region          = 
vpc_cidr            = 
public_subnet_cidrs  = 
private_subnet_cidrs = 
availability_zones   = 
public_route_cidr    = -->

4. After setting up these perform `terraform fmt`
5. terraform validate
6. terraform plan
7. terraform apply -auto-approve
8. To destroy the infra perform the `terraform destroy -auto-approve`

SSL CERTIFICATE:

TO IMPORT THE CERTIFICATE:

aws acm import-certificate \
  --certificate fileb://demo_malepati_me.crt \
  --private-key fileb://private.key \
  --certificate-chain fileb://demo_malepati_me.ca-bundle \
  --region us-east-1