aks_vnet_name = "aks_vnet"
aks_subnet = "aks_subnet"
sshkvsecret = "akssshpubkey"

clientidkvsecret = "spn-id"

spnkvsecret = "spn-secret"

vnetcidr = ["10.5.0.0/16"]

subnetcidr = ["10.5.192.0/18"]

keyvault_rg = "aks-demo-rg"

keyvault_name = "aks-demo6-key"

azure_region = "eastus"

resource_group = "aks-democluster-rg"

cluster_name = "aks-demo-cluster90"

dns_name = "aksdemocluster90"

admin_username = "aksuser"

kubernetes_version = "1.28.5"

agent_pools = {
      name            = "pool1"
      count           = 1
      vm_size         = "Standard_DS2_v2"
      os_disk_size_gb = "30"
    }
