module "buckets3-backend" {
  source = "../modules/fileserver/core/bucket-s3"

  namespace = var.namespace
  #partition-key = "default-backend-storage-${random_integer.value.id}"
  partition-key = "dev-backend" #var.param_s3fs_backend_partition_name#"default-backend-storage"

  tags = var.tags

}

output "buckets3"{
  value = module.buckets3-backend
}