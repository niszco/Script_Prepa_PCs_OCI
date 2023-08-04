# Permet d'executer le script sur n'importe quelle machine
Set-ExecutionPolicy Bypass -Scope Process
# Donne les droits administrateurs pour executer le script
Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"D:\Script_Prepa_PCs`"" -Verb RunAs

# Trouve le profil "Administrateur" de Windows et active le profil
$enablingAdministrator = Get-LocalUser -Name "Administrateur" | Enable-LocalUser

# Si le profil est déjà activé, on affiche un message
if (-not $enablingAdministrator) {
        Write-Host "Le compte 'Administrateur' est déjà actif !"
}

function clientCodeRequest {
        # Ouvre une fenêtre de saisie pour le mot de passe
        $cred = Get-Credential -UserName "Administrateur" -Message "Tapez le mot de passe pour le compte Administrateur (C00XXXX@oci)"

        # Ajoute le mot de passe tapé par l'utilisateur comme mot de passe de l'Administrateur
        Set-LocalUser -Name "Administrateur" -Password $cred.Password

        Write-Host "Le mot de passe pour l'administrateur a été modifié avec succès !"
}

function localAccountDeletion {
        $deletingLocalAccount = Get-LocalUser -Name "admin" | Remove-LocalUser

        if (-not $deletingLocalAccount) {
                Write-Host "Le compte local 'admin' n'a pas pu être trouvé et/ou supprimé !"
        }
}

clientCodeRequest
localAccountDeletion
Restart-Computer



