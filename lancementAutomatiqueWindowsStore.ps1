# Permet d'executer le script sur n'importe quelle machine
Set-ExecutionPolicy Bypass -Scope Process
# Donne les droits administrateurs pour executer le script
Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"D:\Script_Prepa_PCs`"" -Verb RunAs

Start-Process -FilePath "C:\Program Files\WindowsApps\Microsoft.WindowsStore_22306.1401.1.0_x64__8wekyb3d8bbwe\WinStore.App.exe"