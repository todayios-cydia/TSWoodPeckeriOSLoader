#!/usr/bin/env bash

echo "Cleaning up..."
# rm -rf bin/ woodpecker-ios/

echo "Updating submodules..."
git submodule update --init --recursive
echo "===================================="

DYLIB_SOURCE_PATH="./woodpecker-ios/WoodPeckeriOS.xcframework/ios-arm64_armv7/WoodPeckeriOS.framework"

echo "Copying dylib..."
DYLIB_PATH="./layout/Library/Application Support/TSWoodPeckeriOSLoader/"
if [ ! -d "$DYLIB_PATH" ]; then
	mkdir -p ./layout/Library/Application\ Support/TSWoodPeckeriOSLoader/
fi

cp -f -r ${DYLIB_SOURCE_PATH} ./layout/Library/Application\ Support/TSWoodPeckeriOSLoader/
echo "===================================="

echo "##WARNING: resign WoodPeckeriOS.framework"
# codesign -fs "Apple Development: Qianduan Da (4V52F2MX45)" ./layout/Library/Application\ Support/TSWoodPeckeriOSLoader/WoodPeckeriOS.framework
echo "===================================="

echo "Done."
