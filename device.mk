#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/ziyi

# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit_only.mk
#$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Configure gsi_keys.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Configure Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Configure virtual_ab compression.mk
#$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Configure SDCard replacement functionality
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure twrp
#$(call inherit-product, vendor/twrp/config/common.mk)

#PRODUCT_PACKAGES += \
#    bootctrl.taro.recovery \
#	android.hardware.boot@1.2-impl-qti.recovery

# A/B related packages
ENABLE_AB := true
ENABLE_VIRTUAL_AB := true

PRODUCT_PACKAGES += update_engine \
    update_engine_client \
    update_verifier \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
  update_engine_sideload

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# Boot/kernel Console enabled
TARGET_CONSOLE_ENABLED := true

# Build
BUILD_BROKEN_DUP_RULES := true
RELAX_USES_LIBRARY_CHECK := true

# Crypto
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Fastbootd
PRODUCT_PACKAGES += \
	android.hardware.fastboot@1.0-impl-mock \
	android.hardware.fastboot@1.0-impl-mock.recovery \
	fastbootd

# f2fs utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Platform
TARGET_BOARD_PLATFORM := taro
TARGET_BOOTLOADER_BOARD_NAME := taro
QCOM_BOARD_PLATFORMS += taro

# Suppot to compile recovery without msm headers
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

# Userdata checkpoint
PRODUCT_PACKAGES += \
    checkpoint_gc

# SHIPPING API
#PRODUCT_SHIPPING_API_LEVEL := 31

# VNDK API
#PRODUCT_TARGET_VNDK_VERSION := 33

# Board
BOARD_SHIPPING_API_LEVEL := 31
BOARD_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31
SHIPPING_API_LEVEL := 31

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# otacert
#PRODUCT_EXTRA_RECOVERY_KEYS += \
#    $(DEVICE_PATH)/security/releasekey

#TWRP_REQUIRED_MODULES += miui_prebuilt magisk_prebuilt

#PRODUCT_USE_DYNAMIC_PARTITIONS := true
#BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
# Copy modules for depmod
#PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*.ko,$(DEVICE_PATH)/prebuilt,$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules)

