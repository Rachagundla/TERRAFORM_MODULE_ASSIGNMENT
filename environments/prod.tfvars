global = {
  environment = "prod"
  tags = {
    Project   = "Terraform Assignment"
    Owner     = "Pavan"
    ManagedBy = "Terraform"
  }
}

resource_groups = {
  rg1 = {
    name     = "abc-prod-rg"
    location = "Central India"
    tags = {
      Environment = "Production"
      Owner       = "Pavan"
    }
  }
}