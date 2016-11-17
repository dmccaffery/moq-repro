#requires -version 4

$ROOT_PATH = Convert-Path (Get-Location)

$DOTNET_INSTALL_URL = "https://github.com/dotnet/cli/raw/rel/1.0.0-preview2.1/scripts/obtain/dotnet-install.ps1"
$DOTNET_TEMP = Join-Path ([System.IO.Path]::GetTempPath()) $([System.IO.Path]::GetRandomFileName())
$DOTNET_INSTALL = Join-Path $DOTNET_TEMP "dotnet-install.ps1"
$DOTNET_PATH = Join-Path $ROOT_PATH ".dotnet"
$DOTNET = Join-Path $DOTNET_PATH "dotnet"
$DOTNET_VERSION = "1.0.0-preview2-1-003177"

$env:DOTNET_CLI_TELEMETRY_OPTOUT = 1

Write-Host $DOTNET_INSTALL_URL
Write-Host $DOTNET_INSTALL
Write-Host $DOTNET_PATH
Write-Host $DOTNET
Write-Host $DOTNET_VERSION

mkdir $DOTNET_TEMP -ErrorAction SilentlyContinue | Out-Null
mkdir $DOTNET_PATH -ErrorAction SilentlyContinue | Out-Null

Invoke-WebRequest $DOTNET_INSTALL_URL -OutFile $DOTNET_INSTALL -ErrorAction Stop | Out-Null

& $DOTNET_INSTALL -i "$DOTNET_PATH" -v "$DOTNET_VERSION"

& $DOTNET restore "$ROOT_PATH"

& $DOTNET test "$ROOT_PATH\test\Moq.Fail.Test"
Write-Host ""
Write-Host -Color Red ":: WHY YOU NO WORK?! ::"
Write-Host ""

& $DOTNET test "$ROOT_PATH\test\Moq.Pass.Test"
Write-Host ""
Write-Host -Color Green ":: bows head ::"
Write-Host ""