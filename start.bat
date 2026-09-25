@echo off
 setlocal enabledelayedexpansion
chcp 65001 >nul
title FrenchUtility - Bot Discord

REM Se placer dans le dossier du bot, peu importe d'ou le .bat est lance
cd /d "%~dp0"

echo ==========================================
echo   FrenchUtility - demarrage du bot
echo ==========================================
echo.

REM ---------- 1. Trouver Python ----------
set "PY="
where py >nul 2>&1
if %errorlevel%==0 set "PY=py"
if not defined PY (
    where python >nul 2>&1
    if !errorlevel!==0 set "PY=python"
)
if not defined PY (
    echo [ERREUR] Python est introuvable sur cette machine.
    echo.
    echo   Installe Python 3.12 depuis https://www.python.org/downloads/
    echo   et coche bien "Add Python to PATH" pendant l'installation.
    echo.
    pause
    exit /b 1
)
for /f "delims=" %%v in ('%PY% -c "import sys;print(sys.version.split()[0])"') do set "PYVER=%%v"
echo [OK] Python %PYVER% detecte.

REM ---------- 2. Verifier les fichiers du bot ----------
if not exist "src\_loader.json" (
    echo [ERREUR] src\_loader.json est introuvable.
    echo   Lance ce .bat depuis le dossier du bot.
    pause
    exit /b 1
)
if not exist ".env" (
    echo [ERREUR] Le fichier .env est manquant. Cree-le avec :
    echo     TOKEN=ton_token_ici
    echo     PREFIX=/
    pause
    exit /b 1
)

REM ---------- 3. Verifier que le token n'est pas le placeholder ----------
%PY% -c "import io,sys;v=[l.split('=',1)[1].strip() for l in io.open('.env',encoding='utf-8') if l.startswith('TOKEN=')];sys.exit(1 if (not v or len(v[0])<50) else 0)" >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Aucun vrai token dans le fichier .env.
    echo   Ouvre .env et remplace la ligne TOKEN= par ton vrai token Discord
    echo   ^(Discord Developer Portal ^> ton application ^> Bot ^> Reset Token^).
    pause
    exit /b 1
)
echo [OK] Token present dans .env.

REM ---------- 4. Verifier les dependances ----------
REM discord.py doit etre en version 2.1 ou plus. Si les dependances manquent
REM ou si la version est trop ancienne, on les installe / met a jour ; sinon on
REM garde la version deja installee.
set "VERIF_DEPS=import sys,re,discord,dotenv;v=tuple(int(x) for x in re.findall(r'\d+',discord.__version__)[:2]);sys.exit(0 if v>=(2,1) else 1)"
%PY% -c "%VERIF_DEPS%" >nul 2>&1
if errorlevel 1 (
    echo [..] Dependances manquantes ou discord.py trop ancien, mise a jour en cours...
    %PY% -m pip install --disable-pip-version-check -U -r requirements.txt
    %PY% -c "%VERIF_DEPS%" >nul 2>&1
    if errorlevel 1 (
        echo.
        echo [ERREUR] Impossible d'installer discord.py 2.1 ou plus recent.
        echo.
        echo   Lance cette commande a la main, puis relance start.bat :
        echo       %PY% -m pip install -U -r requirements.txt
        echo.
        pause
        exit /b 1
    )
)
for /f "delims=" %%d in ('%PY% -c "import discord;print(discord.__version__)"') do set "DPYVER=%%d"
echo [OK] discord.py %DPYVER% installe.

REM ---------- 5. Lancer le bot ----------
echo.
echo Lancement du bot... ^(Ctrl+C pour arreter^)
echo ------------------------------------------
%PY% -c "import json;exec(chr(10).join(json.load(open('src/_loader.json',encoding='utf-8'))['source']))"

set "CODE=%errorlevel%"
echo ------------------------------------------
if not "%CODE%"=="0" (
    echo [X] Le bot s'est arrete avec le code d'erreur %CODE%.
) else (
    echo Le bot s'est arrete normalement.
)
echo.
pause
