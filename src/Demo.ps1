cd C:\repos\Summit2019\src\xkcd

#Look at Yaml
autorest --powershell --input-file:./xkcd.yaml --clear-output-folder

#Look at Generated folder
.\generated\build-module.ps1 -run

Get-command -module xkcd

Get-XkcdComic | fl *

#Under the covers
[system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*xkcd*'
([system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*xkcd*').gettypes()
(([system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*xkcd*').gettypes() | where name -eq 'comic').getmembers() | ft name, membertype

invoke-webrequest (Get-XkcdComic).img -outfile image.png ; & ./image.png


#Our real world example - Glue Demo

iwr -uri http://localhost:50436/swagger/v1/swagger.json -OutFile swagger.json -UseDefaultCredentials -AllowUnencryptedAuthentication

autorest --powershell --input-file:./swagger.json --clear-output-folder --namespace:Glue.Api
.\generated\build-module.ps1 -run

get-addomain

get-device


[system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*glueapi*'
([system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*glueapi*').gettypes() | where name -eq 'AdDomainApiViewModel'
(([system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*glueapi*').gettypes() | where name -eq 'AdDomainApiViewModel').getmembers() | ft name, membertype
(([system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*glueapi*').gettypes() | where name -eq 'DeviceApiViewModel1').getmembers() | ft name, membertype


#Generate Help
.\generated\generate-help.ps1


#Tag version of autorest extension
autorest --powershell --input-file:./swagger.json --clear-output-folder --namespace:Glue.Api --use=@microsoft.azure/autorest.powershell@2.0.370