Set-Location C:\repos\Summit2019\src\xkcd
# https://apis.guru/browse-apis/
# Look at Yaml

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

invoke-webrequest (Get-XkcdComic -comicid 327).img -outfile image.png ; & ./image.png

$cred = Import-Clixml "~\gallery_creds.xml"
#Update nuspec
.\generated\pack-module.ps1

Start-Process 'https://dev.azure.com/apr2019/Workshop/_packaging?_a=feed&feed=Test'
nuget.exe push -Source "SummitGallery" -ApiKey AzureDevOps .\generated\bin\xkcd.0.1.1.nupkg

Start-Process C:\Users\AdamMurray\Documents\PowerShell\Modules

# Note in version 1.40 of package management that was demonstrated during Monday's lightning demos cache's creds
find-module -Repository PSSummit2019 -Credential $cred xkcd | install-module -Credential $cred

# Modules are built against PSStandard 2.0 and are therefore compatible with 5.1 and 6.x
# Run Windows PowerShell 5.1
find-module -Repository PSSummit2019 -Credential $cred xkcd | install-module -Credential $cred -scope currentuser




# Our real world example - Glue Demo
# We use swashbuckle to automtically generate our openapi spec and create a gui
# https://github.com/domaindrivendev/Swashbuckle.AspNetCore

Start-Process http://localhost:50436/swagger/index.html

Invoke-WebRequest -uri http://localhost:50436/swagger/v1/swagger.json -OutFile swagger.json -UseDefaultCredentials -AllowUnencryptedAuthentication

# Custom folder gives you extensibility
# We can use this to implement authentication
# Walk through Module.cs in the custom folder

autorest --powershell --input-file:./swagger.json --clear-output-folder --namespace:Glue.Api
.\generated\build-module.ps1 -run

get-addomain

get-device


connect-glue -Path C:\Users\AdamMurray\glue_client_secret.xml
$devices = get-device
$devices.count
$danger = $devices | Where-Object -not VmsIsPresent | Where-Object -not AvIsPresent
$danger.count
$danger | Select-Object Hostname, OperatingSystem -first 20
$danger | Group-Object OperatingSystem | Sort-Object count -Descending


# Generate Help
.\generated\generate-help.ps1

# Readme.md can contain module configuration

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

# (.md) markdown -- a literate configuration file, with triple-backtick YAML or JSON code blocks. 
# Literate configuration files have the advantage of being able to mix documentation and settings easily, 
# and code blocks can be turned on and off with your own switches.
# https://github.com/Azure/autorest/blob/master/docs/user/configuration.md
