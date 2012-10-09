# XXX: should be full_base_telephony?
$(call inherit-product, build/target/product/full.mk)

$(call inherit-product, build/target/product/languages_small.mk)
$(call inherit-product, vendor/cm/config/common.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/lge/VS920/VS920-vendor.mk)

PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

DEVICE_PACKAGE_OVERLAYS += device/lge/VS920/overlay

PRODUCT_TAGS += dalvik.gc.type-precise
$(call inherit-product, frameworks/base/build/phone-xhdpi-1024-dalvik-heap.mk)

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init.qcom.rc:root/init.qcom.rc \
	$(LOCAL_PATH)/init.target.rc:root/init.target.rc \
	$(LOCAL_PATH)/ueventd.qcom.rc:root/ueventd.qcom.rc

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init.lge.usb.rc:root/init.lge.usb.rc \
	$(LOCAL_PATH)/prebuilt/init.qcom.sh:root/init.qcom.sh \
	$(LOCAL_PATH)/prebuilt/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh \
	$(LOCAL_PATH)/prebuilt/init.qcom.modem_links.sh:system/etc/init.qcom.modem_links.sh \
	$(LOCAL_PATH)/prebuilt/init.qcom.mdm_links.sh:system/etc/init.qcom.mdm_links.sh

# Recovery
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh
	
## Configs
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/atcmd_virtual_kbd.kl:system/usr/keylayout/atcmd_virtual_kbd.kl \
	$(LOCAL_PATH)/configs/ffa-keypad_qwerty.kl:system/usr/keylayout/ffa-keypad_qwerty.kl \
	$(LOCAL_PATH)/configs/i_vzw-keypad.kl:system/usr/keylayout/i_vzw-keypad.kl \
	$(LOCAL_PATH)/configs/pmic8058_pwrkey.kl:system/usr/keylayout/pmic8058_pwrkey.kl \
	$(LOCAL_PATH)/configs/touch_dev.kl:system/usr/keylayout/touch_dev.kl \
	$(LOCAL_PATH)/configs/touch_dev.idc:system/usr/idc/touch_dev.idc \
	$(LOCAL_PATH)/configs/thermald.conf:system/etc/thermald.conf

# WiFi
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf 

# Publish that we support the live wallpaper feature.
PRODUCT_COPY_FILES += \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml

# Permission files
PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/base/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/base/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

# HW HALS
PRODUCT_PACKAGES += \
	hdmid \
	libgenlock \
	libmemalloc \
	liboverlay \
	gralloc.msm8660 \
	hwcomposer.msm8660 \
	copybit.msm8660 \
	lights.msm8660 \
	gps.msm8660 \
	audio.primary.msm8660 \
	audio_policy.msm8660 \
	audio.a2dp.default \
	com.android.future.usb.accessory

# OMX
PRODUCT_PACKAGES += \
	libstagefrighthw \
	libdivxdrmdecrypt \
	libOmxVdec \
	libOmxVenc \
	libOmxAacEnc \
	libOmxAmrEnc \
	libmm-omxcore \
	libOmxCore

# Bluetooth
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/prebuilt/init.qcom.bt.sh:system/bin/init.qcom.bt.sh

PRODUCT_PACKAGES += \
	hcitool \
	hciconfig \
	hwaddrs

# Charger mode
PRODUCT_PACKAGES += \
	charger \
	charger_res_images


#PRODUCT_PACKAGES += getbaseband

#PRODUCT_PROPERTY_OVERRIDES += \
#	ro.sf.lcd_density=320 \
#	persist.sys.use_16bpp_alpha

PRODUCT_PROPERTY_OVERRIDES += \
	ro.secure=0 \
	ro.com.google.locationfeatures=1 \
	ro.com.google.clientidbase=android-lge \
	ro.com.google.clientidbase.gmm=android-lge \
	gsm.operator.iso-country=us
