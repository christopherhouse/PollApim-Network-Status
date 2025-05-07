# 🔄 APIM Network Status Polling Tool

![Azure API Management](https://img.shields.io/badge/Azure-API%20Management-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)

## 📋 Overview

This PowerShell script monitors the network connectivity status of an Azure API Management (APIM) instance by polling the network status endpoint at regular intervals. It provides real-time feedback on connectivity to various dependent resources.

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
.\Poll-Apim-Network-Status.ps1 -SubscriptionId "c5d4a6e8-69bf-4148-be25-cb362f83c370" -ResourceGroupName "RG-SW-APIM" -ApimName "apim-sw-apim-eu2"
```

### Custom Polling Interval (5 minutes)

```powershell
.\Poll-Apim-Network-Status.ps1 -SubscriptionId "c5d4a6e8-69bf-4148-be25-cb362f83c370" -ResourceGroupName "RG-SW-APIM" -ApimName "apim-sw-apim-eu2" -PollIntervalMinutes 5
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
1. 🔄 Calls the APIM network status endpoint via Azure CLI
2. 🔍 Parses the JSON response to analyze the connectivity status
3. ✅ Displays success or error messages based on the connectivity status
4. ⏱️ Waits for the specified interval before polling again

## 🛠️ Troubleshooting

- Ensure Azure CLI is installed and you're logged in
- Verify you have the correct permissions to access the APIM resource
- Check that the APIM instance name, resource group, and subscription ID are correct

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.
