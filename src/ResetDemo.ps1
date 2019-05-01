uninstall-module xkcd -Force
copy 'C:\repos\Summit2019\src\Visual Studio Code Host_history.txt' 'C:\Users\AdamMurray\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine' -force
#Remove xkcd from Azure Devops - https://dev.azure.com/apr2019/Workshop/_packaging?_a=feed&feed=Test
rm C:\Users\AdamMurray\Documents\WindowsPowerShell\modules\xkcd -recurse -force

cd C:\repos\Summit2019
git clean -fxd
cd C:\repos\Summit2019_muzz
git clean -fxd


code C:\repos\Summit.code-workspace


Clear-Host
"Ready to go"