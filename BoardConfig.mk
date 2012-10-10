include vendor/lge/i_vzw/BoardConfigVendor.mk

# Camera
USE_CAMERA_STUB := true

# Platform
TARGET_BOARD_PLATFORM := msm8660
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200
TARGET_BOOTLOADER_BOARD_NAME := iproj
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_CPU_SMP := true

TARGET_BOOTANIMATION_PRELOAD := true

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_USE_SCORPION_BIONIC_OPTIMIZATION := true
TARGET_USE_SCORPION_PLD_SET := true
TARGET_SCORPION_BIONIC_PLDOFFS := 6
TARGET_SCORPION_BIONIC_PLDSIZE := 128

BOARD_FLASH_BLOCK_SIZE := 131072

COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE -DQCOM_ROTATOR_KERNEL_FORMATS -DHAVE_FM_RADIO -DWITH_QCOM_LPA -DSURFACEFLINGER_FORCE_SCREEN_RELEASE

TARGET_SPECIFIC_HEADER_PATH := device/lge/i_vzw/include

# Egl
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/lge/i_vzw/configs/egl.cfg

# QCOM stuff
BOARD_USES_QCOM_HARDWARE := true
TARGET_USES_OVERLAY := true
TARGET_HAVE_BYPASS  := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_GENLOCK := true
TARGET_QCOM_HDMI_OUT := true
TARGET_QCOM_HDMI_RESOLUTION_AUTO := true
TARGET_FORCE_CPU_UPLOAD := false
BOARD_USES_QCOM_LIBS := true
TARGET_NO_BYPASS_CROPPING := true
TARGET_USES_QCOM_LPA := true
TARGET_USES_ION := true

# XXX? DYNAMIC_SHARED_LIBV8SO := true

# Enable JIT
JS_ENGINE := v8
HTTP := chrome
WITH_JIT := true
ENABLE_JSC_JIT := true

BOARD_CDMA_NETWORK := true

# Wireless
BOARD_WPA_SUPPLICANT_DRIVER	:= NL80211
WPA_SUPPLICANT_VERSION		:= VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER		:= NL80211
BOARD_HOSTAPD_PRIVATE_LIB	:= lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE		:= bcmdhd
WIFI_DRIVER_FW_PATH_PARAM	:= "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA		:= "/system/etc/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P		:= "/system/etc/firmware/fw_bcmdhd_p2p.bin"
WIFI_DRIVER_FW_PATH_AP		:= "/system/etc/firmware/fw_bcmdhd_apsta.bin"

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
TARGET_NEEDS_BLUETOOTH_INIT_DELAY := true

# to enable the GPS HAL
BOARD_USES_QCOM_LIBRPC := true
BOARD_USES_QCOM_GPS := true
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := iprj
# AMSS version to use for GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 50000

TARGET_PROVIDES_LIBLIGHTS := true

# Partitions
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 422576128
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2147483648

# Kernel
BOARD_KERNEL_BASE := 0x40200000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_USE_PREBUILT_KERNEL := false

ifeq ($(BOARD_USE_PREBUILT_KERNEL),true)
# Prebuilt ICS kernel
TARGET_PREBUILT_KERNEL_DIR := device/lge/i_vzw/kernels/ics
else
# Build kernel from source
TARGET_KERNEL_SOURCE := kernel/lge/i_vzw
TARGET_KERNEL_CONFIG := spectrum_defconfig
endif

BOARD_KERNEL_CMDLINE := androidboot.hardware=i_vzw
BOARD_FORCE_RAMDISK_ADDRESS := 0x41a00000

ifneq ($(TARGET_PREBUILT_KERNEL_DIR),)
TARGET_PREBUILT_KERNEL := $(TARGET_PREBUILT_KERNEL_DIR)/kernel
TARGET_PREBUILT_MODULES := $(wildcard $(TARGET_PREBUILT_KERNEL_DIR)/*.ko)
PRODUCT_COPY_FILES += \
	$(TARGET_PREBUILT_KERNEL):kernel
PRODUCT_COPY_FILES += \
	$(foreach mod,$(TARGET_PREBUILT_MODULES),$(mod):system/lib/modules/$(notdir $(mod)))
endif

# Device Assert.. ics, cwm, gb
TARGET_OTA_ASSERT_DEVICE := i_vzw,vs920,VS920

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_CUSTOM_GRAPHICS := ../../../device/lge/i_vzw/recovery/recovery-gfx.c
