global = {
  environment = "test"
  tags = {
    Project   = "Terraform Assignment"
    Owner     = "Pavan"
    ManagedBy = "Terraform"
  }
}
resource_groups = {
  rg1 = {
    name     = "abc-test-rg"
    location = "Central India"
    tags = {
      Environment = "Test"
      Owner       = "Pavan"
    }
  }
}