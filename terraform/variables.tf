variable "key_name" {
  default = "DevOpsKey"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "region" {
  default = "eu-north-1"
}

variable "db_username" {
  description = "اسم مستخدم قاعدة البيانات"
  type        = string
}

variable "db_password" {
  description = "كلمة مرور قاعدة البيانات"
  type        = string
  sensitive   = true
}
