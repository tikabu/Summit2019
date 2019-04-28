Set-Location C:\repos\Summit2019\src\xkcd

#Look at Yaml
autorest --powershell --input-file:./xkcd.yaml --clear-output-folder

#Look at Generated folder
.\generated\build-module.ps1 -run

Get-command -module xkcd

Get-XkcdComic | Format-List *

#Under the covers
[system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*xkcd*'
([system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*xkcd*').gettypes()
(([system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*xkcd*').gettypes() | Where-Object name -eq 'comic').getmembers() | Format-Table name, membertype

invoke-webrequest (Get-XkcdComic).img -outfile image.png ; & ./image.png

$cred = Import-Clixml "~\gallery_creds.xml"
#Update nuspec
.\generated\pack-module.ps1

start 'https://dev.azure.com/apr2019/Workshop/_packaging?_a=feed&feed=Test'
nuget.exe push -Source "SummitGallery" -ApiKey AzureDevOps .\generated\bin\xkcd.0.1.0.nupkg

start C:\Users\AdamMurray\Documents\PowerShell\Modules

find-module -Repository PSSummit2019 -Credential $cred xkcd | install-module -Credential $cred




#Our real world example - Glue Demo

Invoke-WebRequest -uri http://localhost:50436/swagger/v1/swagger.json -OutFile swagger.json -UseDefaultCredentials -AllowUnencryptedAuthentication

#Custom folder gives you extensibility
#We can use this to implement authentication

autorest --powershell --input-file:./swagger.json --clear-output-folder --namespace:Glue.Api
.\generated\build-module.ps1 -run

get-addomain

get-device


[system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*glueapi*'
([system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*glueapi*').gettypes() | Where-Object name -eq 'AdDomainApiViewModel'
(([system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*glueapi*').gettypes() | Where-Object name -eq 'AdDomainApiViewModel').getmembers() | Format-Table name, membertype
(([system.appdomain]::CurrentDomain.GetAssemblies() | Where-Object location -like '*glueapi*').gettypes() | Where-Object name -eq 'DeviceApiViewModel1').getmembers() | Format-Table name, membertype


#Generate Help
.\generated\generate-help.ps1

#Readme.md can contain module configuration

#Tag version of autorest extension
autorest --powershell --input-file:./swagger.json --clear-output-folder --namespace:Glue.Api --use=@microsoft.azure/autorest.powershell@2.0.370