# Definição de pastas e arquivo de backup
$programPath = "C:\Arquivos de Programas RFB\Programas SPED\SpedContabil"
$backupFolder = "C:\Arquivos de Programas RFB\Programas SPED"
$backupFile = Join-Path $backupFolder ("Backup_SpedContabil_" + (Get-Date -Format 'yyyyMMdd_HHmmss') + ".zip")

# Verifica se a pasta do programa existe
if (Test-Path -Path $programPath) {
    # Compacta a pasta SpedContabil em um arquivo .zip
    Compress-Archive -Path "$programPath\*" -DestinationPath $backupFile -Force

    Write-Output "Backup criado com sucesso: $backupFile"
} else {
    Write-Output "A pasta do Sped Contábil não foi encontrada em: $programPath"
}