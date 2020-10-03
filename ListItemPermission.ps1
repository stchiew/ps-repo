## List item permissions
$listname = "Registration"
$Results = @()
$rolemember = [ordered] @{"Id" = ""
                        "Title" = ""
                        "Unique" = ""
                        "Member" = ""
                        "Role" = "" }   
$ctx = Get-PnPContext
$allitems = Get-PnPListItem -List $listname

foreach ($item in $allitems) {
    Write-Host "Processing... " $item["ID"] - $item["Title"] -ForegroundColor Green
             
    Get-PnPProperty -ClientObject $item -Property HasUniqueRoleAssignments | Out-Null
    if($item.HasUniqueRoleAssignments) {
        $roleAssignments = $item.RoleAssignments
        $ctx.Load($roleAssignments)
        $ctx.ExecuteQuery()
        foreach ($roleAssignment in $roleAssignments) {
            $member = $roleAssignment.Member
            $roleDef = $roleAssignment.RoleDefinitionBindings

            $ctx.Load($member)
            $ctx.Load($roleDef)
            $ctx.ExecuteQuery()
            
            foreach ($binding in $roleDef) {
                if ($binding.Name -ne "Limited Access" ) {
                    $rolemember."ID" = $item["ID"]
                    $rolemember."Title" = $item["Title"]
                    $rolemember."Unique" = "Yes"
                    $rolemember."Member" = $member.Title
                    $rolemember."Role" = $binding.Name
                    $objRecord = [pscustomobject] $rolemember
                    $Results += $objRecord
                }
            }
         }
    } else {
         $rolemember."ID" = $item["ID"]
         $rolemember."Title" = $item["Title"]
         $rolemember."Unique" = "No"
         $rolemember."Member" = ""
         $rolemember."Role" = ""
         $objRecord = [pscustomobject] $rolemember
         $Results += $objRecord
    }
     
}

$Results|Export-Csv ./Roles.csv -NoTypeInformation