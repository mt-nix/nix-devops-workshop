# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                                                                       #
#                                                 READ ME BEFORE START                                                  #
#                                                                                                                       #
# This is only a sample variable file. While working on the workshop tasks, feel free to change wherever you want.      #
# Where you see comments in the file, you need to figure out on your own how should it look like.                       #
# The values left in the file are free tier eligible, but still double check them, just as with your own values.        #
#                                                                                                                       #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Provider variables ##

variable "region" {
  type      = string
  default   = "us-east-1"
}

## Network part ##

variable "vpc_cider_block" {
    # Complete this variable.
}

variable "subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  # Default value comes here. As you can see, the type is a map of objects, with two strings in it, so fill the default values accordingly.
  # Hint: every object needs to have a name and should look like the type of the variable.
  default = {}
}

variable "security_group_name" {
  # Complete this variable.
}

variable "security_group_ingress_ports" {
  # Complete this variable.
  # Hint: It should be a list of strings.
}

# Make a variable for the security group's egress ports too! 

variable "security_group_ingress_cidr" {
  # Complete this variable.
}

# Make a variable for the security group's egress CIDR block too! 

variable "internet_gateway_name" {
  # Complete this variable.
}

## EC2 ##

variable "ec2_instance_name" {
  # Complete this variable.
}

variable "ec2_instance_image" {
  # Complete this variable.
  # Check the AMI of the 'Ubuntu Server 24.04 LTS (HVM),EBS General Purpose (SSD) Volume Type' image.
}

variable "ec2_instance_size" {
  # Complete this variable.
  # Check for free tier options only! 
}

variable "ec2_volume_size" {
  type    = string
  default = "8"
}

variable "ec2_volume_type" {
  type    = string
  default = "gp3"
}

variable "key_pair_name" {
  # Use the key pair you created for the AWS workshop.
}
