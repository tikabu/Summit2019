uninstall-module xkcd -Force
#Remove xkcd from Azure Devops - https://dev.azure.com/apr2019/Workshop/_packaging?_a=feed&feed=Test
rm C:\Users\AdamMurray\Documents\WindowsPowerShell\modules\xkcd -recurse -force

cd C:\repos\Summit2019
git clean -fxd
cd C:\repos\Summit2019_muzz
git clean -fxd


code C:\repos\Summit.code-workspace


Clear-Host
"Ready to go"