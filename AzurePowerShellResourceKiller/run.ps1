# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format
$currentUTCtime = (Get-Date).ToUniversalTime()
Write-Host "-----------------------------------------------"

# The 'IsPastDue' porperty is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"
Write-Host "Started"

$clientSecret = '<client secret>'
$clientId = '<client id>'
$tenantId = '<tenant id>'
$prefix = '<prefix>'

$azSecureApplicationKey = $clientSecret | ConvertTo-SecureString -AsPlainText -Force
$azCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $clientId, $azSecureApplicationKey
$isLoggedIn = [bool](Connect-AzAccount -Credential $azCredential -TenantId $tenantId -ServicePrincipal)
$resourceGroups =$null
#$resources = $null
#$subscriptionName = Get-AzSubscription | Select-Object -Property "Name"
if($isLoggedIn){
    $resourceGroups = Get-AzResource | Where-Object { $_.ResourceGroupName -like "$prefix*" }
    if($resourceGroups.Count -ne 0){
        $resourceGroups | `
            ForEach-Object -Process {
                    $resourceId = $_.ResourceId
                    $resourceName = $_.Name
                    Start-ThreadJob -ScriptBlock {
                        Remove-AzResource -ResourceId $args[0] -Force
                        Write-Host "Deleted: "$args[1]  
                    } -ArgumentList $resourceId, $resourceName
                    Start-Sleep -Seconds 1
            }
            Get-Job | Wait-Job | Receive-Job 
            Write-Host "Batch deletion completed."
    }else{
        Write-Host "No resource found."
    }
}else{
    Write-Host "Failed to access Azure AD"
}