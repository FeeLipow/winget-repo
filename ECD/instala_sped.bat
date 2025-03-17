@echo off
setlocal enabledelayedexpansion

:: Define variáveis
set backupScript=%~dp0backup_script.ps1
set installer=%~dp0SPEDContabil_w64-10.3.1.exe
set downloadUrl=https://drive.google.com/uc?export=download&id=1Rseg9OjGtxaVgG3msIeOwrYQFSG-zANE

:: Habilita execução de scripts no PowerShell
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"

:: Executa o script de backup
powershell -File "%backupScript%"

:: Baixa o instalador do Google Drive se não existir localmente
if not exist "%installer%" (
    echo Baixando instalador do Google Drive...
    powershell -Command "Invoke-WebRequest -Uri '%downloadUrl%' -OutFile '%installer%'"
)

:: Executa o instalador silenciosamente
echo Instalando o ECD...
start /wait "%installer%" /S

:: Mensagem final
echo Backup e instalação concluídos!
pause
