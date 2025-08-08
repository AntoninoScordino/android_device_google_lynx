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

TARGET_LINUX_KERNEL_VERSION := $(RELEASE_KERNEL_LYNX_VERSION)
# Keeps flexibility for kasan and ufs builds
TARGET_KERNEL_DIR ?= $(RELEASE_KERNEL_LYNX_DIR)
TARGET_BOARD_KERNEL_HEADERS ?= $(RELEASE_KERNEL_LYNX_DIR)/kernel-headers

DEVICE_PACKAGE_OVERLAYS += device/google/lynx/lynx/overlay
DEVICE_PACKAGE_OVERLAYS += device/google/lynx/overlay-lineage

include device/google/gs201/device-shipping-common.mk
include device/google/gs-common/touch/gti/predump_gti.mk
include device/google/gs-common/wlan/dump.mk

# Audio configuration
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_with_le_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml

# Speaker firmware
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/tuning/cs35l41/fw/,$(TARGET_COPY_OUT_VENDOR)/firmware)

# Audio tuning
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/tuning/,$(TARGET_COPY_OUT_VENDOR)/etc/aoc)

# go/lyric-soong-variables
$(call soong_config_set,lyric,camera_hardware,lynx)
$(call soong_config_set,lyric,tuning_product,lynx)
$(call soong_config_set,google3a_config,target_device,lynx)

# Init files
PRODUCT_PACKAGES += \
	init.lynx.rc

# Recovery files
PRODUCT_PACKAGES += \
    init.recovery.lynx.rc

# Camera
PRODUCT_COPY_FILES += \
	device/google/lynx/configs/media/media_profiles_lynx.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# Media Performance Class 13
PRODUCT_PROPERTY_OVERRIDES += ro.odm.build.media_performance_class=33

# Display Config
PRODUCT_COPY_FILES += \
        device/google/lynx/lynx/display_colordata_dev_cal0.pb:$(TARGET_COPY_OUT_VENDOR)/etc/display_colordata_dev_cal0.pb \
        device/google/lynx/lynx/display_golden_cal0.pb:$(TARGET_COPY_OUT_VENDOR)/etc/display_golden_cal0.pb

# Display
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.lbe.supported=1
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_idle_timer_ms=1000
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.ignore_hdr_camera_layers=true

#config of primary display frames to reach LHBM peak brightness
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.primarydisplay.lhbm.frames_to_reach_peak_brightness=2

# NFC
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
	frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
	frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
	device/google/lynx/configs/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf \
    device/google/lynx/configs/nfc/libnfc-nci-lynx.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf

PRODUCT_PACKAGES += \
	$(RELEASE_PACKAGE_NFC_STACK) \
	Tag \
	android.hardware.nfc-service.st \
	NfcOverlayLynx

# Shared Modem Platform
SHARED_MODEM_PLATFORM_VENDOR := lassen

# Shared Modem Platform
include device/google/gs-common/modem/modem_svc_sit/shared_modem_platform.mk

# SecureElement
PRODUCT_PACKAGES += \
	android.hardware.secure_element@1.2-service-gto \
	android.hardware.secure_element@1.2-service-gto-ese2

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
	device/google/lynx/configs/nfc/libse-gto-hal.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libse-gto-hal.conf \
	device/google/lynx/configs/nfc/libse-gto-hal2.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libse-gto-hal2.conf

DEVICE_MANIFEST_FILE += \
	device/google/lynx/configs/nfc/manifest_se.xml

# Thermal Config
PRODUCT_COPY_FILES += \
	device/google/lynx/configs/thermal/thermal_info_config_lynx.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json \
	device/google/lynx/configs/thermal/thermal_info_config_charge_lynx.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config_charge.json

# Power HAL config
PRODUCT_COPY_FILES += \
	device/google/lynx/configs/power/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# PowerStats HAL
PRODUCT_SOONG_NAMESPACES += \
    device/google/lynx/powerstats \
    device/google/lynx

# Bluetooth HAL and Pixel extension
include device/google/lynx/configs/bluetooth/qti_default.mk

# Fingerprint HAL
GOODIX_CONFIG_BUILD_VERSION := g7_trusty
$(call inherit-product-if-exists, vendor/goodix/udfps/configuration/udfps_common.mk)
$(call inherit-product-if-exists, vendor/goodix/udfps/configuration/udfps_shipping.mk)

# Vibrator HAL
$(call soong_config_set,haptics,kernel_ver,v$(subst .,_,$(TARGET_LINUX_KERNEL_VERSION)))
ADAPTIVE_HAPTICS_FEATURE := adaptive_haptics_v1
ACTUATOR_MODEL := legacy_zlra_actuator
PRODUCT_VENDOR_PROPERTIES += \
	ro.vendor.vibrator.hal.f0.comp.enabled=1 \
	ro.vendor.vibrator.hal.redc.comp.enabled=0 \
	persist.vendor.vibrator.hal.context.enable=false \
	persist.vendor.vibrator.hal.context.scale=40 \
	persist.vendor.vibrator.hal.context.fade=true \
	persist.vendor.vibrator.hal.context.cooldowntime=1600 \
	persist.vendor.vibrator.hal.context.settlingtime=5000

# Override Output Distortion Gain
PRODUCT_VENDOR_PROPERTIES += \
    vendor.audio.hapticgenerator.distortion.output.gain=0.29

# Location
PRODUCT_COPY_FILES += \
    device/google/lynx/configs/location/gps.xml.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/configs/location/gps.xml

# Wifi HAL
PRODUCT_SOONG_NAMESPACES += hardware/qcom/wlan/wcn6740

# DCK properties based on target
PRODUCT_PROPERTY_OVERRIDES += \
    ro.gms.dck.eligible_wcc=2 \
    ro.gms.dck.se_capability=1

# WIFI COEX
PRODUCT_COPY_FILES += \
	device/google/lynx/configs/wifi/coex_table.xml:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/coex_table.xml

# WiFi Overlay
PRODUCT_PACKAGES += \
	WifiOverlay2023Mid

# Wifi Aware Interface
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.aware.interface=wifi-aware0

# Set zram size
PRODUCT_VENDOR_PROPERTIES += \
	vendor.zram.size=3g

# Increment the SVN for any official public releases
ifdef RELEASE_SVN_LYNX
TARGET_SVN ?= $(RELEASE_SVN_LYNX)
else
# Set this for older releases that don't use build flag
TARGET_SVN ?= 46
endif

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.build.svn=$(TARGET_SVN)

# Set device family property for SMR
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.device_family=P10C10L10

# Set build properties for SMR builds
ifeq ($(RELEASE_IS_SMR), true)
    ifneq (,$(RELEASE_BASE_OS_LYNX))
        PRODUCT_BASE_OS := $(RELEASE_BASE_OS_LYNX)
    endif
endif

# Set build properties for EMR builds
ifeq ($(RELEASE_IS_EMR), true)
    ifneq (,$(RELEASE_BASE_OS_LYNX))
        PRODUCT_PROPERTY_OVERRIDES += \
        ro.build.version.emergency_base_os=$(RELEASE_BASE_OS_LYNX)
    endif
endif
# Set support hide display cutout feature
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_hide_display_cutout=true

# Set support One-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Fingerprint als feed forward
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.udfps.als_feed_forward_supported=true \
    persist.vendor.udfps.lhbm_controlled_in_hal_supported=true

# Hide cutout overlays
PRODUCT_PACKAGES += \
    NoCutoutOverlay \
    AvoidAppsInCutoutOverlay

# MIPI Coex Configs
PRODUCT_COPY_FILES += \
    device/google/lynx/configs/radio/lynx_display_primary_mipi_coex_table.csv:$(TARGET_COPY_OUT_VENDOR)/etc/modem/display_primary_mipi_coex_table.csv

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.camera.extended_launch_boost=1 \
	persist.vendor.camera.optimized_tnr_freq=1 \
	persist.vendor.camera.raise_buf_allocation_priority=1 \
	persist.vendor.camera.start_cpu_throttling_at_moderate_thermal=1

# Enable camera 1080P 60FPS binning mode
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.1080P_60fps_binning=true

# Increase thread priority for nodes stop
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.increase_thread_priority_nodes_stop=true

# OIS with system imu
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.ois_with_system_imu=true

# Enable camera exif model/make reporting
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.exif_reveal_make_model=true

# Enable front camera always binning for 720P or smaller resolution
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.front_720P_always_binning=true

# Device features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml

# The default value of this variable is false and should only be set to true when
# the device allows users to enable the seamless transfer feature.
PRODUCT_PRODUCT_PROPERTIES += \
   euicc.seamless_transfer_enabled_in_non_qs=true

##Audio Vendor property
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.audio.cca.enabled=false

# SKU specific RROs
PRODUCT_PACKAGES += \
    SettingsOverlayG82U8 \
    SettingsOverlayG0DZQ \
    SettingsOverlayGHL1X \
    SettingsOverlayGWKK3

# Enable DeviceAsWebcam support
PRODUCT_VENDOR_PROPERTIES += \
    ro.usb.uvc.enabled=true

# Quick Start device-specific settings
PRODUCT_PRODUCT_PROPERTIES += \
    ro.quick_start.oem_id=00e0 \
    ro.quick_start.device_id=lynx

# Bluetooth device id
# Raven: 0x410B
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.device_id.product_id=16651

# ANGLE - Almost Native Graphics Layer Engine
PRODUCT_PACKAGES += \
    ANGLE

# EUICC
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

PRODUCT_PACKAGES += \
    EuiccSupportPixelOverlay

# HBM
PRODUCT_PACKAGES += \
    HbmSVManagerOverlayLynx

# Init
PRODUCT_PACKAGES += \
    init.recovery.lynx.touch.rc

# IWLAN
PRODUCT_PACKAGES += \
    Iwlan

# wireless_charger HAL service
include device/google/gs-common/wireless_charger/wireless_charger.mk

# Build necessary packages for vendor

# Codec2
PRODUCT_PACKAGES += \
    libacryl \
    libacryl_hdr_plugin \
    libexynosv4l2

# Fingerprint
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.sensors-V2-ndk.vendor:64

# Graphics
PRODUCT_PACKAGES += \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle

# Sensors
PRODUCT_PACKAGES += \
    sensors.dynamic_sensor_hal

# Wi-Fi
PRODUCT_PACKAGES += \
    libwifi-hal-ctrl:64
