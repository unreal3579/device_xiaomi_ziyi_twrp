#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
LOCAL_PATH := device/xiaomi/ziyi
DEVICE_PATH := device/xiaomi/ziyi

# Configure Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# The app "/system/bin/bootctl" doesn't currently exist in custom recoveries, so running it currently does nothing. So we added this.
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/bootctl

# Configure gsi_keys.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# OTA Assert
TARGET_OTA_ASSERT_DEVICE := ziyi, ziyigl

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti.recovery \

# Crypto
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# FastbootD support
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

PRODUCT_PACKAGES += \
    otapreopt_script \
    checkpoint_gc

# API
PRODUCT_SHIPPING_API_LEVEL  := 31
PRODUCT_TARGET_VNDK_VERSION := 31

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION  := false

# Virtual A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    recovery \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(DEVICE_PATH) \
	vendor/qcom/opensource/commonsys-intf/display

# TWRP - Specifics
TW_THEME                := portrait_hdpi
TW_DEFAULT_LANGUAGE     := ru
TW_USE_TOOLBOX          := true
TW_INCLUDE_NTFS_3G      := true
TW_INCLUDE_FUSE_EXFAT   := true
TW_INCLUDE_FUSE_NTFS    := true
TW_INCLUDE_REPACKTOOLS  := true
TW_INCLUDE_RESETPROP    := true
TW_INCLUDE_LIBRESETPROP := true
TW_MAX_BRIGHTNESS       := 2047
TW_EXTRA_LANGUAGES      := true
TW_DEFAULT_BRIGHTNESS   := 204
TW_EXCLUDE_APEX         := true
TW_EXCLUDE_TWRPAPP      := true
TW_INCLUDE_FASTBOOTD    := true
TWRP_INCLUDE_LOGCAT     := true
TW_INCLUDE_PYTHON       := true

# TWRP notch offsets
TW_Y_OFFSET := 99
TW_H_OFFSET := -99

# Set panel refresh rate to 90 Hertz for smoother experience
# Possible supported frequencies: 30, 60, 90, 120
TW_FRAMERATE := 120

# Blacklist Goodix fingerprint. There's no reason to include this input in recovery
TW_INPUT_BLACKLIST := "uinput-goodix"

TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone50/temp"
TW_BRIGHTNESS_PATH      := "/sys/class/backlight/panel0-backlight/brightness"
TW_LOAD_VENDOR_MODULES  += "adsp_loader_dlkm.ko qti_battery_charger.ko synaptics_tcm_core_module.ko haptic.ko swr_haptics_dlkm.ko goodix_core.ko focaltech_fps.ko aw882xx_dlkm.ko aw88179_178a.ko"

TW_EXCLUDE_DEFAULT_USB_INIT            := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true

TW_SUPPORT_INPUT_AIDL_HAPTICS          := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME   := "IVibrator/vibratorfeature"
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF  := true

# TWRP - Crypto
TW_INCLUDE_CRYPTO               := true
TW_INCLUDE_CRYPTO_FBE           := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_FORCE_KEYMASTER_VER          := true
BOARD_USES_QCOM_FBE_DECRYPTION  := true
PLATFORM_VERSION                := 99.87.36
PLATFORM_VERSION_LAST_STABLE    := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH         := 2127-12-31
VENDOR_SECURITY_PATCH           := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH             := $(PLATFORM_SECURITY_PATCH)

#TWRP Configuration
TW_INCLUDE_RESETPROP        := true
TW_NO_FLASH_CURRENT_TWRP    := true
RECOVERY_SDCARD_ON_DATA     := true
TW_NO_EXFAT_FUSE            := true
TW_HAS_EDL_MODE             := true
TW_BACKUP_EXCLUSIONS        := /data/fonts
TW_LOAD_VENDOR_BOOT_MODULES := true
TW_NO_SCREEN_BLANK          := true

#PB
PB_TORCH_PATH := "/sys/class/leds/led:torch_0"

# A/B related packages
ENABLE_AB := true
ENABLE_VIRTUAL_AB := true

# otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/releasekey

BUILD_BROKEN_MISSING_REQUIRED_MODULES := true