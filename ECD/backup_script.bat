@echo off
setlocal enabledelayedexpansion

:: === Definição de Caminhos ===
set SPED_DIR=C:\Arquivos de Programas RFB\Programas SPED
set CONTABIL_DIR=%SPED_DIR%\SpedContabil
set BACKUP_FILE=%SPED_DIR%\SpedContabil_Backup_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%.zip
set INSTALLER=%~dp0ECD.exe
set DOWNLOAD_URL=https://drive.google.com/uc?export=download&id=1Rseg9OjGtxaVgG3msIeOwrYQFSG-zANE

:: === Verifica se a pasta SpedContabil existe ===
if not exist "%CONTABIL_DIR%" (
    echo [ALERTA] A pasta "SpedContabil" nao foi encontrada em:
    echo %CONTABIL_DIR%
    echo Deseja prosseguir sem backup? (S/N)
    set /p escolha=Resposta: 
    if /i not "!escolha!"=="S" (
        echo Processo abortado pelo usuario.
        pause
        exit /b 1
    )
) else (
    :: === Cria o backup em ZIP ===
    echo Criando backup da pasta "SpedContabil"...
    powershell -Command "Compress-Archive -Path '%CONTABIL_DIR%' -DestinationPath '%BACKUP_FILE%' -Force"

    if exist "%BACKUP_FILE%" (
        echo Backup criado com sucesso: %BACKUP_FILE%
    ) else (
        echo [ERRO] Falha ao criar o backup!
        pause
        exit /b 1
    )
)

:: === Baixa o instalador do Google Drive se não existir localmente ===
if not exist "%INSTALLER%" (
    echo Baixando instalador do Google Drive...
    powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%INSTALLER%'"

    if exist "%INSTALLER%" (
        echo Instalador baixado com sucesso!
    ) else (
        echo [ERRO] Falha ao baixar o instalador!
        pause
        exit /b 1
    )
)

:: === Executa o instalador em modo silencioso ===
echo Iniciando a instalacao do ECD...
start /wait "%INSTALLER%" /S

if %errorlevel% equ 0 (
    echo Instalacao concluida com sucesso!
) else (
    echo [ERRO] A instalacao encontrou problemas. Codigo de erro: %errorlevel%
    pause
    exit /b %errorlevel%
)

echo Processo finalizado com sucesso!
pause