@echo off
:: Asistente de terminal - llama al proxy en la Raspberry Pi (navi)
:: Uso: navi cómo listo los archivos de una carpeta

if "%~1"=="" (
    echo Uso: navi ^<pregunta^>
    echo Ejemplo: navi como ver los archivos de una carpeta
    exit /b 1
)

:: Une todos los argumentos en una sola pregunta
set "question=%*"

:: Llama al servidor en la Pi usando PowerShell (viene en todo Windows moderno)
powershell -NoProfile -Command ^
    "$q = '%question%' -replace \"'\", \"''\"; " ^
    "$body = ConvertTo-Json @{ q = $q }; " ^
    "try { " ^
        "$r = Invoke-RestMethod -Uri 'http://navi:8080/ask' -Method Post -Body $body -ContentType 'application/json'; " ^
        "Write-Host $r " ^
    "} catch { " ^
        "Write-Host '[Error]: No se pudo conectar a navi. Verifica que el servidor este corriendo.' " ^
    "}"