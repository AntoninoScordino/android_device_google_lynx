#
# Copyright (C) 2021 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/google/lynx

# Inherit from gs201
include device/google/gs201/BoardConfig-common.mk

# Audio
BOARD_USES_GENERIC_AUDIO := true

# Board information
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := lynx

# Display
TARGET_SCREEN_DENSITY := 420

# Kernel
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/configs/modules.blocklist.vendor_kernel_boot
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_RAW := $(strip $(shell cat $(DEVICE_PATH)/configs/modules.load.vendor_kernel_boot))
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD += $(BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_RAW)
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES += $(addprefix $(KERNEL_MODULE_DIR)/, $(notdir $(BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_RAW)))

BOARD_BOOTCONFIG += \
    androidboot.load_modules_parallel=true

BOARD_KERNEL_CMDLINE += \
    fips140.load_sequential=1 \
    exynos_drm.load_sequential=1

# Radio
include device/google/gs-common/check_current_prebuilt/check_current_prebuilt.mk
RELEASE_GOOGLE_PRODUCT_RADIO_DIR := $(RELEASE_GOOGLE_LYNX_RADIO_DIR)
RELEASE_GOOGLE_BOOTLOADER_LYNX_DIR ?= pdk
RELEASE_GOOGLE_PRODUCT_BOOTLOADER_DIR := bootloader/$(RELEASE_GOOGLE_BOOTLOADER_LYNX_DIR)
$(call soong_config_set,lynx_bootloader,prebuilt_dir,$(RELEASE_GOOGLE_BOOTLOADER_LYNX_DIR))

# SEPolicy
BOARD_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor \
    $(DEVICE_PATH)/sepolicy/tracking_denials

BOARD_VENDOR_SEPOLICY_DIRS += \
    hardware/google/pixel-sepolicy/vibrator/common \
    hardware/google/pixel-sepolicy/vibrator/cs40l26

# Wi-Fi
include device/google/gs201/wifi/qcom/BoardConfig-wifi.mk

# Inherit the proprietary files
include vendor/google/lynx/BoardConfigVendor.mk
