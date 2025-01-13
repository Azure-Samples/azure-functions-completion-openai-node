$ErrorActionPreference = "Stop"

if (-not (Test-Path ".\src\local.settings.json")) {

    $output = azd env get-values

    # Parse the output to get the endpoint values
    foreach ($line in $output) {
        if ($line -match "AZURE_OPENAI_ENDPOINT"){
            $AZURE_OPENAI_ENDPOINT = ($line -split "=")[1] -replace '"',''
        }
    }

    @{
        "IsEncrypted" = "false";
        "Values" = @{
            "AzureWebJobsStorage" = "UseDevelopmentStorage=true";
            "FUNCTIONS_WORKER_RUNTIME" = "node";
            "AZURE_OPENAI_ENDPOINT" = "$AZURE_OPENAI_ENDPOINT";
            "CHAT_MODEL_DEPLOYMENT_NAME" = "completion";
        }
    } | ConvertTo-Json | Out-File -FilePath ".\src\local.settings.json" -Encoding ascii
}