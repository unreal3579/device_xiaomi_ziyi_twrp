#!/bin/bash
cd ./bootable/recovery
patch -p1 < ../../device/xiaomi/ziyi/patches/0001-revert-save-settings-file-in-persist.patch
cd ../..
