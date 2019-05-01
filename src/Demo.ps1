Set-Location C:\repos\Summit2019\src\xkcd
# https://apis.guru/browse-apis/

# Swagger UI
# https://petstore.swagger.io/?_ga=2.232371231.1855476143.1556683098-574006975.1556683098
# Look at Yaml

Invoke-RestMethod http://xkcd.com/info.0.json
Invoke-RestMethod http://xkcd.com/327/info.0.json

autorest --help

autorest --powershell --input-file:./xkcd.yaml --clear-output-folder

#Look at Generated folder
.\generated\build-module.ps1 -run

Get-command -module xkcd

Get-XkcdComic | Format-List *

#Under the covers
[system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*xkcd*'
([system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*xkcd*').gettypes()
(([system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*xkcd*').gettypes() | Where-Object name -eq 'comic').getmembers() | Format-Table name, membertype

start (Get-XkcdComic -comicid 327).img

$cred = Import-Clixml "~\gallery_creds.xml"
#Update nuspec
.\generated\pack-module.ps1

Start-Process 'https://dev.azure.com/apr2019/Workshop/_packaging?_a=feed&feed=Test'
nuget.exe push -Source "SummitGallery" -ApiKey AzureDevOps .\generated\bin\xkcd.0.1.2.nupkg

Start-Process C:\Users\AdamMurray\Documents\WindowsPowerShell\Modules

# Note in version 1.40 of package management that was demonstrated during Monday's lightning demos cache's creds

# Modules are built against PSStandard 2.0 and are therefore compatible with 5.1 and 6.x
# Run Windows PowerShell 5.1
find-module -Repository PSSummit2019 -Credential $cred xkcd | install-module -Credential $cred -scope currentuser

Start-Process C:\Users\AdamMurray\Documents\WindowsPowerShell\Modules


# Our real world example - Glue Demo
# We use swashbuckle to automtically generate our openapi spec and create a gui
# https://github.com/domaindrivendev/Swashbuckle.AspNetCore

cd C:\repos\Summit2019_muzz\Glue_Demo
Start-Process http://localhost:50436/swagger/index.html

#Invoke-WebRequest -uri http://localhost:50436/swagger/v1/swagger.json -OutFile swagger.json -UseDefaultCredentials -AllowUnencryptedAuthentication

# Custom folder gives you extensibility
# We can use this to implement authentication
# Walk through Module.cs in the custom folder
# Set environment variable for negotiate
$env:NegotiateAuth = $true
autorest --powershell --input-file:./swagger.json --clear-output-folder --namespace:Glue.Api
.\generated\build-module.ps1 -run

get-addomain

$env:NegotiateAuth = ''
# Switch to using oAuth authentication to Azure

# (.md) markdown -- a literate configuration file, with triple-backtick YAML or JSON code blocks. 
# Literate configuration files have the advantage of being able to mix documentation and settings easily, 
# and code blocks can be turned on and off with your own switches.
# https://github.com/Azure/autorest/blob/master/docs/user/configuration.md

# Autorest by default looks for readme.md
# Open readme.md
git clean -fxd

autorest

connect-glue -Path C:\Users\AdamMurray\glue_client_secret.xml

# Generate Help
.\generated\generate-help.ps1

# Tag version of autorest extension
autorest --powershell --input-file:./swagger.json --clear-output-folder --namespace:Glue.Api --use=@microsoft.azure/autorest.powershell@2.0.370

# Produce SDK for another language

autorest --python --input-file:./xkcd.yaml --clear-output-folder

<#--csharp                      generate C# client code
  --go                          generate Go client code
  --java                        generate Java client code
  --python                      generate Python client code
  --nodejs                      generate NodeJS client code
  --typescript                  generate TypeScript client code
  --ruby                        generate Ruby client code
  --php                         generate PHP client code
  --azureresourceschema         generate Azure resource schemas
  --model-validator             validates an OpenAPI document against linked examples (see https://github.com/Azure/azure-rest-api-specs/search?q=x-ms-examples )
  --azure-validator             validates an OpenAPI document against guidelines to improve quality (and optionally Azure guidelines)
#>


