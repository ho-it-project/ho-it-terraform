module "hoit_dev_amdin" {
  source      = "./_module/assume_policy/"
  aws_account = "hoit-dev"
  subject     = "admin"
  resources   = ["arn:aws:iam::${var.ACCOUNT_ID}:role/assume-hoit-dev-admin"]
}


output "assume_hoit_dev_admin_policy_arn" {
  value = module.hoit_dev_amdin.assume_policy_arn
}


module "art_dev_poweruser" {
  source      = "./_module/assume_policy/"
  aws_account = "hoit-dev"
  subject     = "poweruser"
  resources   = ["arn:aws:iam::${var.ACCOUNT_ID}:role/assume-hoit-dev-poweruser"]
}

output "assume_hoit_dev_poweruser_policy_arn" {
  value = module.art_dev_poweruser.assume_policy_arn
}



module "art_dev_readonly" {
  source      = "./_module/assume_policy/"
  aws_account = "hoit-dev"
  subject     = "readonly"
  resources   = ["arn:aws:iam::${var.ACCOUNT_ID}:role/assume-hoit-dev-readonly"]
}

output "assume_hoit_dev_readonly_policy_arn" {
  value = module.art_dev_readonly.assume_policy_arn
}
