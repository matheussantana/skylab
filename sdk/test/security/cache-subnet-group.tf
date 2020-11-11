module "cache-subnet-group" {
  source = "../modules/network/core/elasticache-subnet-group"
  namespace = var.namespace
  cache_subnet_group_name = "cache-subnet-group"
  subnet_ids_list = ["subnet-04c5570b1c1317371", "subnet-0622a05b94c2a983e"]
  #tags = var.tags
}

output "cache-subnet-group" {
  value = module.cache-subnet-group
}