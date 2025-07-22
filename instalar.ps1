# Instalar VSCode, MinGW e Python no Windows 11

# Caminho para a pasta Downloads
$downloadsPath = [System.Environment]::GetFolderPath('MyDocuments') + "\Downloads"

# Pasta temporária de download
$tempPath = "$downloadsPath\dev-setup"
New-Item -ItemType Directory -Force -Path $tempPath

# Baixar VSCode
$vscodeUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
$vscodeInstaller = "$tempPath\vscode.exe"
Invoke-WebRequest -Uri $vscodeUrl -OutFile $vscodeInstaller

# Baixar Python
$pythonUrl = "https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe"
$pythonInstaller = "$tempPath\python.exe"
Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonInstaller

# Baixar MinGW (apenas download, sem instalação)
$mingwUrl = "https://sourceforge.net/projects/mingw/files/latest/download"
$mingwInstaller = "$tempPath\mingw-get-setup.exe"
Invoke-WebRequest -Uri $mingwUrl -OutFile $mingwInstaller

Write-Output "`nInstalando VSCode..."
Start-Process -FilePath $vscodeInstaller -ArgumentList "/silent" -Wait

Write-Output "`nInstalando Python..."
Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_test=0" -Wait

Write-Output "`n✅ Instalação concluída. Reinicie o terminal para aplicar variáveis de ambiente."

# Informações sobre o MinGW (sem execução)
Write-Output "`nO arquivo MinGW foi baixado em: $mingwInstaller"
Write-Output "MinGW não será instalado automaticamente."

# Impede que o PowerShell feche automaticamente
Read-Host -Prompt "Pressione Enter para fechar"
