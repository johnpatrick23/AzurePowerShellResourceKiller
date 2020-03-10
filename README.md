# Azure  Powershell Resource Killer
- It is an **Azure Function Application** used to delete all of resources in a selected filtered **Azure Resource Group**.

# Installation
1. **[Install Visual Studio Code](https://code.visualstudio.com/download "Install Visual Studio Code")**
2. **[Install .Net Core 2.2 or Above](https://dotnet.microsoft.com/download/dotnet-core/2.2 ".Net Core 2.2 or Above")**
3. **[Install Powershell Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell "Install Powershell Extension")**


* It executes every 12 Hours, but you can edit the scedule and set a CRON time on a time or date that you want to execute the Function App. Shown in a code below.
 * function.json
```json
{
  "bindings": [
    {
      "name": "Timer",
      "type": "timerTrigger",
      "direction": "in",
      "schedule": "0 0 */12 * * *"
    }
  ]
}
```


[da]: http://ssss.com "ds"
[.Net Core 2.2]: https://dotnet.microsoft.com/download/dotnet-core/2.2 ".Net Core 2.2"
[Visual Studio Code]: https://code.visualstudio.com/download "Visual Studio Code"