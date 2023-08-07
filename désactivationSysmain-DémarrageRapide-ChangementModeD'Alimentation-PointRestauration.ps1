# Donne les droits administrateurs pour executer le script
Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"D:\Script_Prepa_PCs`"" -Verb RunAs

# Désactivation du service : Sysmain
$sysmain = "SysMain"
Get-Service -Name $sysmain
Stop-Service -DisplayName $sysmain
sc.exe delete $sysmain

# Désactivation du démarrage rapide et de la veille prolongée
powercfg /h off # Désactive la veille prolongée et le démarrage rapide
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name HiberbootEnabled -Value 0 # Désactive le démarrage rapide dans le registre de Windows

# Changement des temps de mise en veille
Powercfg /Change monitor-timeout-ac 60 # 1 Heures / mise à l'arrêt de l'écran
Powercfg /Change monitor-timeout-dc 60 # 1 Heures / mise à l'arrêt de l'écran
Powercfg /Change standby-timeout-ac 300 # 5 Heures = 60 Minutes * 5 / veille
Powercfg /Change standby-timeout-dc 300 # 5 Heures = 60 Minutes * 5 / veille

# Protection d'un point de restauration du disque de stockage (5%)
powershell -command "Enable-ComputerRestore -Drive C:"
vssadmin resize shadowstorage /for=C: /on=C: /maxsize=5%

