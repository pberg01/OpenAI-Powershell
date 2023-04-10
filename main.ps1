function Invoke-OpenAI {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Prompt,
        [string]$ApiKey = "API KEY GOES HERE",
        [string]$Model = "text-davinci-003",
        [int]$MaxTokens = 2048
    )

    # Define the request body as a PowerShell object
    $body = @{
        "model" = $Model
        "prompt" = $Prompt
        "max_tokens" = $MaxTokens
    }

    # Convert the request body to JSON
    $jsonBody = $body | ConvertTo-Json

    # Invoke the OpenAI API's text generation endpoint with the specified parameters
    $response = Invoke-RestMethod `
        -Method 'POST' `
        -Uri 'https://api.openai.com/v1/completions' `
        -Headers @{ "Content-Type" = "application/json"; "Authorization" = "Bearer $ApiKey" } `
        -Body $jsonBody

    # Extract the completed text from the response
    $completionText = $response.choices.text

    # Output the completed text to the console
    Write-Host $completionText
}
