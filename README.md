<<<<<<< HEAD
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
- JavaScript
- bicep
- azdeveloper
---
-->

# Azure Functions
## Azure Functions extension for OpenAI TextCompletion input binding

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

Run the following command to download the project code
```bash
azd init -t https://github.com/Azure-Samples/azure-functions-completion-openai-node
```

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

You're prompted to supply these required deployment parameters:

| Parameter | Description |
| ---- | ---- |
| _Environment name_ | An environment that's used to maintain a unique deployment context for your app. You won't be prompted if you created the local project using `azd init`.|
| _Azure subscription_ | Subscription in which your resources are created.|
| _Azure location_ | Azure region in which to create the resource group that contains the new Azure resources. Only regions that currently support the Flex Consumption plan are shown.|

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
=======
# Project Name

(short, 1-3 sentenced, description of the project)

## Features

This project framework provides the following features:

* Feature 1
* Feature 2
* ...

## Getting Started

### Prerequisites

(ideally very short, if any)

- OS
- Library version
- ...

### Installation

(ideally very short)

- npm install [package name]
- mvn install
- ...

### Quickstart
(Add steps to get up and running quickly)

1. git clone [repository clone url]
2. cd [repository name]
3. ...


## Demo

A demo app is included to show how to use the project.

To run the demo, follow these steps:

(Add steps to start up the demo)

1.
2.
3.

## Resources

(Any additional resources or related projects)

- Link to supporting information
- Link to similar sample
- ...
>>>>>>> d0b4c52a663d6168de49532cd5bf98116e91edac
