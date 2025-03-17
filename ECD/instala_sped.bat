@echo off
:: Habilita a execução de scripts no PowerShell
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"

:: Executa o script de backup
powershell -File "%~dp0backup_script.ps1"

:: Executa o instalador (ajuste o nome do instalador se precisar)
"%~dp0ECD.exe"

:: Mensagem de conclusão
echo Backup e instalação concluídos!
pause