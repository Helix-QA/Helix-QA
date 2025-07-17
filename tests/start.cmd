chcp 65001
"C:\Program Files\1cv8\8.3.24.1368\bin\1cv8c" /N"Admin" /TestManager /Execute "D:\VA Automation\vanessa-automation\vanessa-automation.epf" /IBConnectionString "Srvr=""192.168.2.71"";Ref=""avtotestqa"";" /C"StartFeaturePlayer;DisableFeatureLoadOnOpenForm;QuietInstallVanessaExt;GenerateSmokeTest;VAParams=D:\VA Automation\Scenarios\SmokeTest\VAParams.json"

python replace_commands.py