# Permet d'executer le script sur n'importe quelle machine
Set-ExecutionPolicy Bypass -Scope Process
# Donne les droits administrateurs pour executer le script
Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"D:\Script_Prepa_PCs`"" -Verb RunAs

function uninstallChoice {
    $userChoice = Read-Host 'Voulez-vous lancer le processus de desinstallation des logiciels indesirables ? (O pour Oui - N pour Non) '

    if ($userChoice = 'N') {
        Write-Host -ForegroundColor DarkGreen 'Le processus de desinstallation a ete annule.'
        Exit
    }
    
    if ($userChoice = 'O') {
        Write-Host -ForegroundColor Red 'Lancement du processus de desinstallation des logiciels indesirables.'

        # Désinstallation des logiciels inutiles / indésirables du PC
        Get-AppxPackage -Name "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.XboxGameOverlay" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.Xbox.TCUI" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.XboxGameCallableUI" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.XboxIdentityProvider" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.XboxOneSmartGlass"| Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.XboxApp" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.GamingApp" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.WindowsMaps" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.OneDriveSync" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.microsoftwindowscommunicationapps" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.People" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.YourPhone" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.SkypeApp" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.WindowsAlarms" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.ZuneMusic" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.LanguageExperiencePackde-DE" | Remove-AppxPackage
        Get-AppxPackage -Name "Microsoft.LanguageExperiencePacken-EN" | Remove-AppxPackage
        Get-AppxPackage -Name "Facebook" | Remove-AppxPackage
        Get-AppxPackage -Name "TikTok" | Remove-AppxPackage
        Get-AppxPackage -Name "WhatsApps" | Remove-AppxPackage
        Get-AppxPackage -Name "Instagram" | Remove-AppxPackage
        Get-AppxPackage -Name "Spotify" | Remove-AppxPackage
    }
}
uninstallChoice
Exit