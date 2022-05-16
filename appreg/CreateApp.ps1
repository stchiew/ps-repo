<#
Create and configure App Id for use in console app with interactive login
#>

Connect-AzureAD

## Define inputs
$displayName = "App name"
$identifierUris = ""


$aadApplication = New-AzureADApplication -DisplayName "MTS Demo App" -IdentifierUris "http://mtsdemoapp.contoso.com" -HomePage "http://mtsdemo.contoso.com"

$currentUser = (Get-AzureADUser -ObjectId (Get-AzureADCurrentSessionInfo).Account.Id)
Add-AzureADApplicationOwner -ObjectId $aadApplication.ObjectId -RefObjectId $currentUser.ObjectId

New-AzureADServicePrincipal -ReplyUrls $replyUrl -ServicePrincipalType 