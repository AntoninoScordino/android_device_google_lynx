#
# SPDX-FileCopyrightText: 2021-2024 The LineageOS Project
# SPDX-FileCopyrightText: 2021-2024 The Calyx Institute
# SPDX-License-Identifier: Apache-2.0
#

TARGET_LINUX_KERNEL_VERSION := 6.1

DEVICE_USES_NO_TRUSTY := true
USE_SWIFTSHADER := true
BOARD_USES_SWIFTSHADER := true

# Inherit some common stuff
TARGET_DISABLE_EPPE := true
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit device configuration
DEVICE_CODENAME := lynx
DEVICE_PATH := device/google/lynx
VENDOR_PATH := vendor/google/lynx
$(call inherit-product, device/google/gs201/aosp_common.mk)
$(call inherit-product, $(DEVICE_PATH)/$(DEVICE_CODENAME)/device.mk)
$(call inherit-product, device/google/gs201/lineage_common.mk)
$(call inherit-product, $(DEVICE_PATH)/$(DEVICE_CODENAME)/device-lineage.mk)

# Device identifier. This must come after all inclusions
PRODUCT_BRAND := google
PRODUCT_DEVICE := lynx
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Pixel 7a
PRODUCT_NAME := lineage_$(DEVICE_CODENAME)

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="lynx-user 15 BP1A.250505.005.B1 13277630 release-keys" \
    BuildFingerprint=google/lynx/lynx:15/BP1A.250505.005.B1/13277630:user/release-keys \
    DeviceProduct=$(DEVICE_CODENAME)

DEVICE_MANIFEST_FILE := \
	device/google/lynx/manifest.xml

$(call inherit-product, $(VENDOR_PATH)/$(DEVICE_CODENAME)-vendor.mk)
