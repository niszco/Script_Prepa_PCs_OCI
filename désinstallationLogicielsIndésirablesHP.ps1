# Permet d'executer le script sur n'importe quelle machine
Set-ExecutionPolicy Bypass -Scope Process
# Donne les droits administrateurs pour executer le script
Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"D:\Script_Prepa_PCs`"" -Verb RunAs

$HPPackagesToUninstall = @(
    "AD2F1837.HPJumpStarts"
    "AD2F1837.HPPCHardwareDiagnosticsWindows"
    "AD2F1837.HPPowerManager"
    "AD2F1837.HPPrivacySettings"
    "AD2F1837.HPSupportAssistant"
    "AD2F1837.HPSureShieldAI"
    "AD2F1837.HPSystemInformation"
    "AD2F1837.HPQuickDrop"
    "AD2F1837.HPWorkWell"
    "AD2F1837.myHP"
    "AD2F1837.HPDesktopSupportUtilities"
    "AD2F1837.HPQuickTouch"
    "AD2F1837.HPEasyClean"
    "AD2F1837.HPSystemInformation"
)

$MSPackagesToUninstall = @(
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.XboxGameOverlay"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxSpeechToTextOverlay" 
    "Microsoft.XboxGameCallableUI"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxOneSmartGlass"
    "Microsoft.XboxApp"
    "Microsoft.GamingApp"
    "Microsoft.WindowsMaps"
    "Microsoft.OneDriveSync"
    "Microsoft.microsoftwindowscommunicationapps"
    "Microsoft.People"
    "Microsoft.YourPhone"
    "Microsoft.SkypeApp"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.WindowsAlarms"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.LanguageExperiencePackde-DE"
    "Microsoft.LanguageExperiencePacken-EN"
)

$OtherPackagesToUninstall = @(
    "Facebook.InstagramBeta"
    "Clipchamp.Clipchamp"
    "5319275A.WhatsAppDesktop"
    "BytedancePte.Ltd.TikTok"
    "SpotifyAB.SpotifyMusic"
    "Disney.37853FC22B2CE"
    "AppleInc.iTunes"
)

function uninstallChoice {
    $userChoice = Read-Host 'Voulez-vous lancer le processus de désinstallation des logiciels indésirables ? (O pour Oui - N pour Non) '

    switch ($userChoice) {
        'N' {
            Write-Host -ForegroundColor Green 'Le processus de désinstallation a été annulé.'
            Exit
        }

        'O' {
            Write-Host -ForegroundColor Yellow 'Lancement du processus de désinstallation des logiciels indésirables.'

            # Désinstallation des logiciels inutiles / indésirables du PC
    
            # Logiciels Microsoft
            ForEach ($AppxPackage in $MSPackagesToUninstall) {
                Write-Host -Object -ForegroundColor Yellow "Désinstallation du package suivant : [$($AppxPackage.Name)]..."
                Try {
                    $Null = Remove-AppxPackage -Package $AppxPackage.PackageFullName -AllUsers -ErrorAction Continue
                    Write-Host  -ForegroundColor Green -Object "Désinstallation réussi du package : [$($AppxPackage.Name)]"
                }
                Catch {
                    Write-Warning -Message -ForegroundColor Red "Échec de la désinstallation du package : [$($AppxPackage.Name)]"
                }
            }
    
            # Logiciels HP, ID du Fabricant du Package : AD2F1837
            ForEach ($AppxPackage in $HPPackagesToUninstall) {
                Write-Host -Object -ForegroundColor Yellow "Désinstallation du package suivant : [$($AppxPackage.Name)]..."
                Try {
                    $Null = Remove-AppxPackage -Package $AppxPackage.PackageFullName -AllUsers -ErrorAction Stop
                    Write-Host -Object -ForegroundColor Green "Désinstallation réussi du package : [$($AppxPackage.Name)]"
                }
                Catch {
                    Write-Warning -Message -ForegroundColor Red "Échec de la désinstallation du package : [$($AppxPackage.Name)]"
                }
            }
            # Autres
            ForEach ($AppxPackage in $OtherPackagesToUninstall) {
                Write-Host -Object -ForegroundColor Yellow "Désinstallation du package suivant : [$($AppxPackage.Name)]..."
                Try {
                    $Null = Remove-AppxPackage -Package $AppxPackage.PackageFullName -AllUsers -ErrorAction Stop
                    Write-Host -Object -ForegroundColor Green "Désinstallation réussi du package : [$($AppxPackage.Name)]"
                }
                Catch {
                    Write-Warning -Message -ForegroundColor Red "Échec de la désinstallation du package : [$($AppxPackage.Name)]"
                }
            }
    
            # 1er essai de désinstallation d'HP Wolf Security
            Try {
                MsiExec /x "{0E2E04B0-9EDD-11EB-B38C-10604B96B11E}" /qn /norestart
                Write-Host -Object "Désinstallation d'HP Wolf Security..."
            }
            Catch {
                Write-Warning -Object "Échec de la désinstallation d'HP Wolf Security avec MSI, erreur : $($_.Exception.Message)"
            }
            
            # 2ème essai de désinstallation d'HP Wolf Security
            Try {
                MsiExec /x "{4DA839F0-72CF-11EC-B247-3863BB3CB5A8}" /qn /norestart
                Write-Host -Object "Désinstallation d'HP Wolf Security..."
            }
            Catch {
                Write-Warning -Object  "Échec de la désinstallation d'HP Wolf Security avec MSI, erreur : $($_.Exception.Message)"
            }
        }
        }
    }

function computerRestartChoice {
    $rebootChoice = Read-Host "Voulez-vous redémarrarer l'ordinateur ? (O pour Oui - N pour Non)"
    switch ($rebootChoice) {
        'O' {
            Restart-Computer -Force -Confirm:$false
        }
        'N' {
            Write-Host "L'ordinateur ne sera pas redémarré !"
            Exit
        }
        default{write-warning "Redémarrage annulé !"}
    }
}
uninstallChoice
computerRestartChoice
Exit