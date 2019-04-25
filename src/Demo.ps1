iwr -uri http://localhost:50436/swagger/v1/swagger.json -OutFile swagger.json -UseDefaultCredentials -AllowUnencryptedAuthentication

autorest --powershell --input-file:./swagger.json --clear-output-folder --namespace:Times.Wire.Search
.\generated\build-module.ps1 -run

get-addomain

get-device


[system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*glueapi*'
([system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*glueapi*').gettypes() | where name -eq 'AdDomainApiViewModel'
(([system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*glueapi*').gettypes() | where name -eq 'AdDomainApiViewModel').getmembers() | ft name, membertype
(([system.appdomain]::CurrentDomain.GetAssemblies() | where location -like '*glueapi*').gettypes() | where name -eq 'DeviceApiViewModel1').getmembers() | ft name, membertype


autorest --powershell --input-file:./swagger.json --clear-output-folder --namespace:Glue.Api --use=@microsoft.azure/autorest.powershell@2.0.370