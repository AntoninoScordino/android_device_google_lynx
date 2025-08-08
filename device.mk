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

include device/google/gs201/device-shipping-common.mk
include device/google/gs-common/touch/gti/predump_gti.mk
include device/google/gs-common/wlan/dump.mk

# ANGLE - Almost Native Graphics Layer Engine
PRODUCT_PACKAGES += \
    ANGLE

# Audio
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/tuning/cs35l41/fw/,$(TARGET_COPY_OUT_VENDOR)/firmware) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/tuning/,$(TARGET_COPY_OUT_VENDOR)/etc/aoc)

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_with_le_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml

PRODUCT_VENDOR_PROPERTIES += \
    vendor.audio.hapticgenerator.distortion.output.gain=0.29

PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.audio.cca.enabled=false

# Bluetooth
include $(LOCAL_PATH)/configs/bluetooth/qti_default.mk

PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.device_id.product_id=16651

# Build
TARGET_DISABLE_EPPE := true

# Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/media_profiles_lynx.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.1080P_60fps_binning=true \
    persist.vendor.camera.increase_thread_priority_nodes_stop=true \
    persist.vendor.camera.ois_with_system_imu=true \
    persist.vendor.camera.exif_reveal_make_model=true \
    persist.vendor.camera.front_720P_always_binning=true

PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.camera.extended_launch_boost=1 \
    persist.vendor.camera.optimized_tnr_freq=1 \
    persist.vendor.camera.raise_buf_allocation_priority=1 \
    persist.vendor.camera.start_cpu_throttling_at_moderate_thermal=1

# Device features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml

PRODUCT_PRODUCT_PROPERTIES += \
    ro.quick_start.oem_id=00e0 \
    ro.quick_start.device_id=lynx

PRODUCT_PROPERTY_OVERRIDES += \
    ro.gms.dck.eligible_wcc=2 \
    ro.gms.dck.se_capability=1

# Display
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/display/,$(TARGET_COPY_OUT_VENDOR)/etc) \

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    vendor.display.lbe.supported=1 \
    ro.surface_flinger.set_idle_timer_ms=1000 \
    ro.surface_flinger.ignore_hdr_camera_layers=true \
    vendor.primarydisplay.lhbm.frames_to_reach_peak_brightness=2

PRODUCT_PACKAGES += \
    NoCutoutOverlay \
    AvoidAppsInCutoutOverlay

PRODUCT_PACKAGES += \
    HbmSVManagerOverlayLynx

PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_hide_display_cutout=true

PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# EUICC
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

PRODUCT_PACKAGES += \
    EuiccSupportPixelOverlay

PRODUCT_PRODUCT_PROPERTIES += \
   euicc.seamless_transfer_enabled_in_non_qs=true


# Fingerprint
GOODIX_CONFIG_BUILD_VERSION := g7_trusty
$(call inherit-product-if-exists, vendor/goodix/udfps/configuration/udfps_common.mk)
$(call inherit-product-if-exists, vendor/goodix/udfps/configuration/udfps_shipping.mk)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.udfps.als_feed_forward_supported=true \
    persist.vendor.udfps.lhbm_controlled_in_hal_supported=true

# Gadget
PRODUCT_VENDOR_PROPERTIES += \
    ro.usb.uvc.enabled=true

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.sensors-V2-ndk.vendor:64

# Graphics
USE_SWIFTSHADER := true
BOARD_USES_SWIFTSHADER := true

PRODUCT_PACKAGES += \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle

PRODUCT_PACKAGES += \
    libacryl \
    libacryl_hdr_plugin \
    libexynosv4l2

# Init configuration files
PRODUCT_PACKAGES += \
    init.lynx.rc

PRODUCT_PACKAGES += \
    init.recovery.lynx.rc \
    init.recovery.lynx.touch.rc

# Kernel
TARGET_KERNEL_DIR ?= $(RELEASE_KERNEL_LYNX_DIR)
TARGET_BOARD_KERNEL_HEADERS ?= $(RELEASE_KERNEL_LYNX_DIR)/kernel-headers

TARGET_LINUX_KERNEL_VERSION := 6.1

# Location
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/location/gps.xml.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/configs/location/gps.xml

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    ro.odm.build.media_performance_class=33

# NFC (Near Field Communication)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf \
    $(LOCAL_PATH)/configs/nfc/libnfc-nci-lynx.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml

PRODUCT_PACKAGES += \
    android.hardware.secure_element@1.2-service-gto \
    android.hardware.secure_element@1.2-service-gto-ese2

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/nfc/libse-gto-hal.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libse-gto-hal.conf \
    $(LOCAL_PATH)/configs/nfc/libse-gto-hal2.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libse-gto-hal2.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml

PRODUCT_PACKAGES += \
    $(RELEASE_PACKAGE_NFC_STACK) \
    Tag \
    android.hardware.nfc-service.st \
    NfcOverlayLynx

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/lynx/overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-lineage

# Radio
include device/google/gs-common/modem/modem_svc_sit/shared_modem_platform.mk
SHARED_MODEM_PLATFORM_VENDOR := lassen

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/radio/lynx_display_primary_mipi_coex_table.csv:$(TARGET_COPY_OUT_VENDOR)/etc/modem/display_primary_mipi_coex_table.csv

# Sensors
PRODUCT_PACKAGES += \
    sensors.dynamic_sensor_hal

# Soong
$(call soong_config_set,lyric,camera_hardware,lynx)
$(call soong_config_set,lyric,tuning_product,lynx)
$(call soong_config_set,google3a_config,target_device,lynx)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/powerstats \
    hardware/qcom/wlan/wcn6740

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal/thermal_info_config_lynx.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json \
    $(LOCAL_PATH)/configs/thermal/thermal_info_config_charge_lynx.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config_charge.json

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/power/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# VINTF
DEVICE_MANIFEST_FILE += \
    $(LOCAL_PATH)/configs/nfc/manifest_se.xml \
    $(LOCAL_PATH)/manifest.xml

# Vibrator
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

# Wi-Fi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/coex_table.xml:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/coex_table.xml

PRODUCT_PACKAGES += \
    libwifi-hal-ctrl:64

PRODUCT_PACKAGES += \
    Iwlan

PRODUCT_PACKAGES += \
    WifiOverlay2023Mid

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.aware.interface=wifi-aware0

# Wireless charger
include device/google/gs-common/wireless_charger/wireless_charger.mk

# ZRAM
PRODUCT_VENDOR_PROPERTIES += \
    vendor.zram.size=3g

# Inherit from vendor blobs
$(call inherit-product, vendor/google/lynx/lynx-vendor.mk)
