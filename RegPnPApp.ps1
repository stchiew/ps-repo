<# Register AAD app using PnP #>
Register-PnPAzureADApp -ApplicationName AppName

Grant-PnPAzureADAppSitePermission -AppId "9878ffc4-bc3f-49c8-8b78-d3b4822435c3" -DisplayName "My Countries App" -Permissions Write -Site https://pandacolors.sharepoint.com/sites/Explorer

Connect-PnPOnline -Url https://pandacolors.sharepoint.com/sites/Explorer -ClientId "9878ffc4-bc3f-49c8-8b78-d3b4822435c3" -ClientSecret "G8N8Q~JQ-6COwH25ZPvoPMaPjy6MjC9.b6TvHaHP"
Get-PnPAzureADAppSitePermission -PermissionId "aTowaS50fG1zLnNwLmV4dHw5ODc4ZmZjNC1iYzNmLTQ5YzgtOGI3OC1kM2I0ODIyNDM1YzNAMDNhMzY3OWItZjhiMy00MjcyLTgwYTUtNWE2MjM5MTAyZTA0"