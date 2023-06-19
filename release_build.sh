#/bin/sh

# export PREFIX=$THEOS/toolchain/Xcode14.xctoolchain/usr/bin/

# make clean
# make package FINALPACKAGE=1

# export -n PREFIX

make clean
make package FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=rootless
