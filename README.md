<!--
---
name: Azure Function using OpenAI TextCompletion input binding
description: Azure Function using OpenAI TextCompletion input binding to send content to Azure OpenAI and get a result
page_type: sample
products:
- azure-functions
- azure
- entra-id
urlFragment: azure-functions-completion-openai-dotnet
languages:
- azdeveloper
- bicep
- nodejs
- javascript
---
-->

# Azure Functions
## Azure Functions extension for OpenAI TextCompletion input binding with JavaScript

This sample highlights how to use the Azure Functions OpenAI TextCompletion input binding to send content to Azure OpenAI and get a result

You can learn more about the OpenAI trigger and bindings extension in the [GitHub documentation](https://github.com/Azure/azure-functions-openai-extension) and in the [Official OpenAI extension documentation](https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-openai)


## Prerequisites

* [Node 20](https://nodejs.org/)
* [Azure Functions Core Tools v4.x](https://learn.microsoft.com/azure/azure-functions/functions-run-local?tabs=v4%2Cwindows%2Cnode%2Cportal%2Cbash)
* [Azure OpenAI resource](https://learn.microsoft.com/azure/openai/overview)
* [Azurite](https://github.com/Azure/Azurite)
* [Azure Developer CLI](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd) to create Azure resources automatically - recommended

## Prepare your local environment

### Create Azure OpenAI resource for local and cloud dev-test

Enable scripts to create local settings file after deployment
Mac/Linux:
```bash
chmod +x ./infra/scripts/*.sh 
```
Windows:
```Powershell
set-executionpolicy remotesigned
```
Run the follow command to provision resoruces in Azure
```bash
azd provision
```


Once you have your Azure subscription, run the following in a new terminal window to create Azure OpenAI and other resources needed:

```bash
azd provision
```

Take note of the value of `AZURE_OPENAI_ENDPOINT` which can be found in `./.azure/<env name from azd provision>/.env`.  It will look something like:
```bash
AZURE_OPENAI_ENDPOINT="https://cog-<unique string>.openai.azure.com/"
```

Alternatively you can [create an OpenAI resource](https://portal.azure.com/#create/Microsoft.CognitiveServicesTextAnalytics) in the Azure portal to get your key and endpoint. After it deploys, click Go to resource and view the Endpoint value.  You will also need to deploy a model, e.g. with name `completion` and model `gpt-4o`.

### Create local.settings.json (should be in the same folder as host.json). This will be created if you run azd provision
```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "node",
    "AZURE_OPENAI_ENDPOINT": "<paste from above>",
    "CHAT_MODEL_DEPLOYMENT_NAME": "completion"
    }
}
```

### Permissions
#### Add the following permissions to the Azure OpenAI resource:
<b>Cognitive Services User</b> - Add your account (contoso@microsoft.com) to the OpenAI resource if you did not create the OpenAI resource to test locally and the Azure Function App's Managed Identity when running in Azure. If you used `azd provision` this step is already done - your logged in user and your function's managed idenitty already have permissions granted.  

## Run your app using Visual Studio Code

1. Open the folder in a new terminal.
1. Run the `code .` code command to open the project in Visual Studio Code.
1. In the command palette (F1), type `Azurite: Start`, which enables debugging using local storage.
1. Press **Run/Debug (F5)** to run in the debugger. Select **Debug anyway** if prompted about local emulator not running.
1. Test by sending GET requests to the `whois` endpoint and POST requests to the `PostUserContent` endpoint using your HTTP test tool. If you have the [RestClient](https://marketplace.visualstudio.com/items?itemName=humao.rest-client) extension installed, you can execute requests directly from the [`test.http`](./src/test.http) project file.

## Deploy to Azure

Run this command to provision the function app, with any required Azure resources, and deploy your code:

```shell
azd up
```

After publish completes successfully, `azd` provides you with the URL endpoints of your new functions, but without the function key values required to access the endpoints. To learn how to obtain these same endpoints along with the required function keys, see [Invoke the function on Azure](https://learn.microsoft.com/azure/azure-functions/create-first-function-azure-developer-cli?pivots=programming-language-dotnet#invoke-the-function-on-azure) in the companion article [Quickstart: Create and deploy functions to Azure Functions using the Azure Developer CLI](https://learn.microsoft.com/azure/azure-functions/create-first-function-azure-developer-cli?pivots=programming-language-dotnet).

## Redeploy your code

You can run the `azd up` command as many times as you need to both provision your Azure resources and deploy code updates to your function app.

>[!NOTE]
>Deployed code files are always overwritten by the latest deployment package.

## Clean up resources

When you're done working with your function app and related resources, you can use this command to delete the function app and its related resources from Azure and avoid incurring any further costs (--purge does not leave a soft delete of AI resource and recovers your quota):

```shell
azd down --purge
```
