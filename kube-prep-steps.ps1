#### Parameters

$keyvaultname = "aks-demo-key"
$location = "East Asia"
$keyvaultrg = "aks-demo-rg"
$sshkeysecret = "akssshpubkey"
$spnclientid = "b3b14960-aaea-4c5c-8345-199d1f13a53a"
$clientidkvsecretname = "spn-id"
$spnclientsecret = "Em18Q~kPEaBMohlMebf5sw9OtDD3zCA4fwpqgdkB"
$spnkvsecretname = "spn-secret"
$spobjectID = "b3b14960-aaea-4c5c-8345-199d1f13a53a"
$userobjectid = "b3b14960-aaea-4c5c-8345-199d1f13a53a"


#### Create Key Vault

New-AzResourceGroup -Name $keyvaultrg -Location $location

New-AzKeyVault -Name $keyvaultname -ResourceGroupName $keyvaultrg -Location $location

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -UserPrincipalName $userobjectid -PermissionsToSecrets get,set,delete,list

#### create an ssh key for setting up password-less login between agent nodes.

ssh-keygen  -f C:\\aks\\.ssh\\id_rsa_terraform


#### Add SSH Key in Azure Key vault secret

$pubkey = cat C:\\aks\\.ssh\\id_rsa_terraform.pub

$Secret = ConvertTo-SecureString -String $pubkey -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $sshkeysecret -SecretValue $Secret


#### Store service principal Client id in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientid -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $clientidkvsecretname -SecretValue $Secret


#### Store service principal Secret in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientsecret -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $spnkvsecretname -SecretValue $Secret


#### Provide Keyvault secret access to SPN using Keyvault access policy

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -ServicePrincipalName $spobjectID -PermissionsToSecrets Get,Set
