#!/usr/bin/env bash

echo "Cleaning up..."
rm -rf bin/ src/

echo "Updating submodules..."
git submodule update --init --recursive
echo "===================================="

DYLIB_SOURCE_PATH="./src/WoodPeckeriOS/WoodPeckeriOS.framework"

echo "Copying dylib..."
DYLIB_PATH="./layout/Library/Application Support/TSWoodPeckeriOSLoader/"
if [ ! -d "$DYLIB_PATH" ]; then
	mkdir -p ./layout/Library/Application\ Support/TSWoodPeckeriOSLoader/
fi

cp -f -r ${DYLIB_SOURCE_PATH} ./layout/Library/Application\ Support/TSWoodPeckeriOSLoader/
echo "===================================="

echo "##WARNING: resign WoodPeckeriOS.framework"
# codesign -fs "Apple Development: ljduan2013@icloud.com (992QNX5ZG6)" ./layout/Library/Application\ Support/TSWoodPeckeriOSLoader/WoodPeckeriOS.framework
echo "===================================="

echo "Done."
