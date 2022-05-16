## Create service principal

$add = New-MsolServicePrincipalAddresses -Address "http://localhost/" -AddressType Reply
$appid = New-MsolServicePrincipal -DisplayName "Innovations-Full" -Addresses $add
RZjQ6gwdMppGJ5jMZO2i2Dw+PG8zWQ4cXFFxmpkKiUw=
$AppId = (Get-MsolServicePrincipal -ServicePrincipalName "MyApp").AppPrincipalId
$spn = $AppId+"/localhost"
Set-MsolServicePrincipal -AppPrincipalId $AppId -ServicePrincipalNames @($AppId,$spn)

$AppId = (Get-MsolServicePrincipal -SearchString "IDEA").AppPrincipalId