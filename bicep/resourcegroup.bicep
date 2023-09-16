targetScope = 'subscription'
resource myresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'example-rg'
  location: 'UK South'
}
