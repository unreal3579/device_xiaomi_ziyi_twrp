#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

#DEVICE_PATH := device/xiaomi/ziyi

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

#BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
#BUILD_BROKEN_PREBUILT_ELF_FILES := true
#BUILD_BROKEN_DUP_RULES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75

# APEX
#DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := taro
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Kernel
#VENDOR_CMDLINE := "console=ttyMSM0,115200n8 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket pcie_ports=compat loop.max_part=7 iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1 buildvariant=user reboot=panic_warm androidboot.init_fatal_reboot_target=recovery androidboot.selinux=permissive"
#BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_BOOT_HEADER_VERSION := 4
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel_empty
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)

# Ramdisk use lz4
BOARD_RAMDISK_USE_LZ4 := true


#BOARD_KERNEL_SEPERATED_DTBO := true

#BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(VENDOR_CMDLINE)

#BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
#BOARD_MKBOOTIMG_ARGS += --dtb $(DEVICE_PATH)/prebuilt/dtb.img

#TARGET_KERNEL_CONFIG := ziyi_defconfig
#TARGET_KERNEL_SOURCE := kernel/xiaomi/ziyi

# Kernel - prebuilt
#TARGET_FORCE_PREBUILT_KERNEL := true
#ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
#endif

# A/B
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
#BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
	vendor_dlkm \
    vendor_boot

# Avb
BOARD_AVB_ENABLE := true

# Partitions
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600

# Dynamic Partitions
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs


#BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
#BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663295

#BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4


# System as root
#BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
#BOARD_SUPPRESS_SECURE_ERASE := true

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_VENDOR_DLKMIMAGE := true

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Platform
#BOARD_USES_QCOM_HARDWARE := true
#TARGET_BOARD_PLATFORM := taro

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
#TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
#ALLOW_MISSING_DEPENDENCIES := true

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
TW_USE_FSCRYPT_POLICY := 2
PLATFORM_VERSION := 13
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Tool
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true

# Debug
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true

# FastbootD
TW_INCLUDE_FASTBOOTD := true

# Security patch level
#VENDOR_SECURITY_PATCH := 2021-08-01

# Verified Boot
#BOARD_AVB_ENABLE := true
#BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Hack: prevent anti rollback
#PLATFORM_SECURITY_PATCH := 2099-12-31
#VENDOR_SECURITY_PATCH := 2099-12-31
#PLATFORM_VERSION := 16.1.0

# TWRP Configuration
TW_THEME := portrait_hdpi
TW_FRAMERATE := 60
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_NO_EXFAT_FUSE := true
TW_USE_TOOLBOX := true
TARGET_USES_MKE2FS := true
TW_INCLUDE_FUSE_EXFAT := true
TW_INCLUDE_FUSE_NTFS := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := en_US
TW_DEFAULT_BRIGHTNESS := 200
TW_EXCLUDE_APEX := true
TW_HAS_EDL_MODE := true


#TW_SCREEN_BLANK_ON_BOOT := true
#TW_INCLUDE_REPACKTOOLS := true
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko gpr_dlkm.ko q6_notifier_dlkm.ko q6_pdr_dlkm.ko snd_event_dlkm.ko spf_core_dlkm.ko"