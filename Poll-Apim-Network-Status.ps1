param(
    [Parameter(Mandatory=$true)]
    [string]$SubscriptionId,
    
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,
    
    [Parameter(Mandatory=$true)]
    [string]$ApimName,
    
    [Parameter(Mandatory=$false)]
    [int]$PollIntervalMinutes = 15
)

while ($true) {
    # Call the API
    $response = az rest `
        --method GET `
        --url "https://management.azure.com/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.ApiManagement/service/$ApimName/networkstatus?api-version=2024-05-01" `
        | ConvertFrom-Json

    # Parse the response
    $connectivityStatus = $response[0].networkStatus.connectivityStatus
    $allSuccess = $true

    foreach ($item in $connectivityStatus) {
        if ($item.status -ne "success") {
            $allSuccess = $false
            Write-Host "Error! Name: $($item.name), ResourceType: $($item.resourceType)" -ForegroundColor Red
        }
    }

    if ($allSuccess) {
        Write-Host "Success!" -ForegroundColor Green
    }

    # Print next polling time
    $nextPollTime = (Get-Date).AddMinutes($PollIntervalMinutes)
    Write-Host "Next polling interval will execute at: $nextPollTime"

    # Wait for the specified interval
    Start-Sleep -Seconds ($PollIntervalMinutes * 60)
}
