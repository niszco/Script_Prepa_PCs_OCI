# Donne les droits administrateurs pour executer le script
Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"D:\Script_Prepa_PCs`"" -Verb RunAs

# Permet d'executer le script sur n'importe quelle machine
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser