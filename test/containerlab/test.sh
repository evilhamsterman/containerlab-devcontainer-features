#!/bin/sh

set -e

echo "Checking if containerlab is installed to the PATH"
containerlab version
echo "✅ containerlab installed"

echo "Checking if $USER is part of clab_admins group"
groups $USER