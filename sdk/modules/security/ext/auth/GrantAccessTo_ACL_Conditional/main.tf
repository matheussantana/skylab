###
# Policy
# Module: GrantAccessTo_ACL
###

variable "policy_name"{
  type = string
  default = "default_policy"
}
variable "access_level" {
  type = string
  default = "Allow"
}

variable "target_service" {
  type = string
}
variable "namespace" {
  type = string
}

variable "account-id" {
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
  type = string
}

module "aws-policy" {
  source = "../../../core/iam/policy-condition"
  policy_name = var.policy_name
  namespace = var.namespace
  access_level = var.access_level
  target_service = var.target_service
  operation_list = var.operation_list
  condition_operation = "StringEquals"
  condition_operation_key = "ec2:ResourceTag/Name"
  condition_operation_value = var.namespace

  #target_resource = (var.target_resource_id_list == "*" ? [format("%s%s",var.namespace,"*")]
  target_resource = (var.target_resource_id_list[0] == "*" ? ["*"]
 :
    formatlist("arn:aws:%s:%s:%s:%s%s", var.target_service, var.region, var.account-id, var.prefix, var.target_resource_id_list)
  )
}

variable "target_user_name" {
  type = string
}

variable "target_role_name" {
  type = string
}

resource "aws_iam_policy_attachment" "policy-attach" {
  name       = "policy-attachment"
  users      = [var.target_user_name]
  roles      = [var.target_role_name]
  policy_arn = module.aws-policy.policy_id
}

output "policy" {
  value = module.aws-policy.policy
}


#module "aws-grant-access" {}
#module "dynamo" {}

variable "operation_list" {
  type = list(string)
  default = ["*"]
}

variable "target_resource_id_list" {
  type = list(string)
  default = ["*"]
}
