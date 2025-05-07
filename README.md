# 🔄 APIM Network Status Polling Tool

## 📋 Overview

This PowerShell script monitors the network connectivity status of an Azure API Management (APIM) instance by polling the network status endpoint at regular intervals. It provides real-time feedback on connectivity to various dependent resources.

This script can be useful when troubleshooting connectivity issues in VNet-injected APIM deployments, where network dependencies may be complex and difficult to diagnose. It allows you to monitor the status of dependencies and get
details about failed resource types over time.

Note that the polling interval is configured, however the connectivity status reported by this API is only updated
every 15 minutes.
## ✨ Features

- 🔍 Continuously monitors APIM network connectivity
- ⏱️ Configurable polling interval
- 🚦 Visual status indicators (green for success, red for errors)
- 🔧 Customizable for different APIM instances

## 📝 Prerequisites

- Azure CLI installed and authenticated
- PowerShell 5.1 or higher
- Appropriate permissions to access the APIM resource

## 🔧 Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| SubscriptionId | string | ✅ Yes | - | The Azure subscription ID containing the APIM instance |
| ResourceGroupName | string | ✅ Yes | - | The resource group containing the APIM instance |
| ApimName | string | ✅ Yes | - | The name of the APIM instance to monitor |
| PollIntervalMinutes | integer | ❌ No | 15 | Time in minutes between polling intervals |

## 🚀 Usage Examples

### Basic Usage

```powershell
.\Poll-Apim-Network-Status.ps1 -SubscriptionId "<your-subscription-id>" -ResourceGroupName "<your-resource-group>" -ApimName "<your-apim-name>"
```

### Custom Polling Interval (5 minutes)

```powershell
.\Poll-Apim-Network-Status.ps1 -SubscriptionId "<your-subscription-id>" -ResourceGroupName "<your-resource-group>" -ApimName "<your-apim-name>" -PollIntervalMinutes 5
```

## 📊 Sample Output

When all services are online:
```
✅ Success, all dependencies are availabe!
Next polling interval will execute at: 05/07/2025 15:53:04
```

When there are connectivity issues:
```
❌ Error! Name: apimstrmszxtdxh2df5ldxr8.blob.core.windows.net, ResourceType: BlobStorage
❌ Error! Name: apirpsqlfi6mahlotrqv5mnk.database.windows.net, ResourceType: SQLDatabase
Next polling interval will execute at: 05/07/2025 15:53:04
```

## 📝 How It Works

The script:
1. 🔄 Calls the APIM network status endpoint via Azure CLI using the `az apim show-network-status` command
   - This command calls the APIM REST API endpoint: `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/networkstatus?api-version=2021-08-01`
   - The endpoint returns a comprehensive list of all dependencies and their connectivity status
2. 🔍 Parses the JSON response to analyze the connectivity status
3. ✅ Displays success or error messages based on the connectivity status
4. ⏱️ Waits for the specified interval before polling again

The network status API provides detailed information about connectivity to various Azure service dependencies including:
- Azure Storage accounts
- Azure SQL databases
- Key Vault instances
- Event Hubs
- Any other resources the APIM instance requires to function properly

## 🛠️ Troubleshooting

- Ensure Azure CLI is installed and you're logged in
- Verify you have the correct permissions to access the APIM resource
- Check that the APIM instance name, resource group, and subscription ID are correct

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.
