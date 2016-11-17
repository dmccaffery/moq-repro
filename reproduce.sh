CLR_FAILURE='\033[1;31m'    # BRIGHT RED
CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

ROOT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

DOTNET_INSTALL_URL="https://github.com/dotnet/cli/raw/rel/1.0.0-preview2.1/scripts/obtain/dotnet-install.sh"
DOTNET_INSTALL="$(mktemp -d)/dotnet-install.sh"
DOTNET_PATH="$ROOT_PATH/.dotnet"
DOTNET="$DOTNET_PATH/dotnet"
DOTNET_VERSION="1.0.0-preview2-1-003177"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

echo $DOTNET_INSTALL_URL
echo $DOTNET_INSTALL
echo $DOTNET_PATH
echo $DOTNET

mkdir -p "$DOTNET_PATH"

wget -O $DOTNET_INSTALL $DOTNET_INSTALL_URL 2>/dev/null || curl -o $DOTNET_INSTALL -L $DOTNET_INSTALL_URL 2>/dev/null

chmod +x $DOTNET_INSTALL
$DOTNET_INSTALL -i "$DOTNET_PATH" -v $DOTNET_VERSION

$DOTNET restore "$ROOT_PATH"

$DOTNET test "$ROOT_PATH/test/Moq.Fail.Test"
echo
echo -e "${CLR_FAILURE}:: WHY YOU NO WORK?! ::${CLR_CLEAR}"
echo

$DOTNET test "$ROOT_PATH/test/Moq.Pass.Test"
echo
echo -e "${CLR_SUCCESS}:: EVERYTHING IS AWESOME! ::${CLR_CLEAR}"
echo