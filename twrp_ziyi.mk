#
# Copyright (C) 2022 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

#DEVICE_PATH := device/xiaomi/ziyi

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from ziyi device
$(call inherit-product, device/xiaomi/ziyi/device.mk)

PRODUCT_RELEASE_NAME := ziyi

PRODUCT_DEVICE := ziyi
PRODUCT_NAME := twrp_ziyi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 2210129SG
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Assert
#TARGET_OTA_ASSERT_DEVICE := ziyi

# Theme
#TW_STATUS_ICON_ALIGN := center
#TW_Y_OFFSET :=
#TW_H_OFFSET :=

