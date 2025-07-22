# Instalar VSCode, MinGW e Python no Windows 11

# Pasta temporária
$tempPath = "$env:TEMP\dev-setup"
New-Item -ItemType Directory -Force -Path $tempPath

# Baixar VSCode
$vscodeUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
$vscodeInstaller = "$tempPath\vscode.exe"
Invoke-WebRequest -Uri $vscodeUrl -OutFile $vscodeInstaller

# Baixar Python
$pythonUrl = "https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe"
$pythonInstaller = "$tempPath\python.exe"
Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonInstaller

# Baixar MinGW
$mingwUrl = "https://sourceforge.net/projects/mingw-w64/files/latest/download"
$mingwInstaller = "$tempPath\mingw.exe"
Invoke-WebRequest -Uri $mingwUrl -OutFile $mingwInstaller

Write-Output "`nInstalando VSCode..."
Start-Process -FilePath $vscodeInstaller -ArgumentList "/silent" -Wait

Write-Output "`nInstalando Python..."
Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_test=0" -Wait

Write-Output "`nInstalando MinGW..."
Start-Process -FilePath $mingwInstaller -Wait

# Adiciona o MinGW ao PATH (assumindo instalação em C:\Program Files\mingw-w64)
$mingwPath = "C:\Program Files\mingw-w64\bin"
if (Test-Path $mingwPath) {
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$mingwPath", [System.EnvironmentVariableTarget]::Machine)
    Write-Output "MinGW adicionado ao PATH."
} else {
    Write-Warning "Não foi possível encontrar o diretório do MinGW. Verifique se a instalação foi concluída."
}

Write-Output "`n✅ Instalação concluída. Reinicie o terminal para aplicar variáveis de ambiente."
