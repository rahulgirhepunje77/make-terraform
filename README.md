# make-terraform
#step 1:-
Create key pair 
ssh-keygen -t rsa -b 4096 -f terraform-key

chmod 400 terraform-key
#step 2:-
Upload key-pair on AWS

aws ec2 import-key-pair \
--key-name terraform-key \
--public-key-material fileb://terraform-key.pub

#step3:-
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply

#step4:-

verify the kind cluster and deploy application on clutser



