#!/bin/sh

set -e

BASE_URL="https://github.com/srl-labs/containerlab/releases"
BIN_PATH=${BIN_PATH:-"/usr/local/bin"}

case $(uname -m ) in
    aarch64) ARCH="arm64" ;;
    x86_64) ARCH="amd64" ;;
    *)
        echo "Unsupported architecture"
        exit 1
esac

# Ensure curl is installed
if ! command -v curl > /dev/null ; then
    echo $?
    if command -v apt-get > /dev/null; then
        apt-get update && apt-get install --no-install-recommends -y curl ca-certificates
    elif command -v dnf > /dev/null; then
        dnf install --skip-broken curl ca-certificates
    elif command -v zypper > /dev/null; then
        zypper install --no-recommends -y curl ca-certificates
    elif command -v apk > /dev/null; then
        apk add --no-cache curl ca-certificates
    else
        echo "curl not available and cannot be installed"
        exit 1
    fi
fi


# Workdir
cd $(mktemp -dt clab.tmp.XXXXXX)

VERSION=${VERSION:-latest}
VERSION=$(echo "$VERSION" | sed 's/^v//')

if [ "$VERSION" = "latest" ]; then
    CHECKSUM=$(curl -SsL "$BASE_URL/latest/download/checksums.txt" | grep "linux_$ARCH.tar.gz")
    VERSION=$(echo "$CHECKSUM" | grep -oE "[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{0,3}")
else
    CHECKSUM=$(curl -SsL "$BASE_URL/download/v$VERSION/checksums.txt" | grep "linux_$ARCH.tar.gz")
fi

FILENAME="containerlab_${VERSION}_linux_${ARCH}.tar.gz"
URL="$BASE_URL/download/v$VERSION/$FILENAME"

echo "Downloading $URL"
curl -SsL $URL -o $FILENAME

echo "Checking $FILENAME"
echo "$CHECKSUM" | sha256sum -c

echo "Extracting $FILENAME to $BIN_PATH"
tar -xzf $FILENAME -C $BIN_PATH containerlab

echo "Configuring sudo-less operation"
chmod u+s "$BIN_PATH/containerlab"
if command -v groupadd; then
    groupadd -r clab_admins
    usermod -aG clab_admins "$_CONTAINER_USER"
elif command -v addgroup; then
    addgroup -S clab_admins
    addgroup "$_CONTAINER_USER" clab_admins
else
    echo "Could create clab_admins group"
fi
