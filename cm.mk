# Release name
PRODUCT_RELEASE_NAME := Iproj

## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/cdma.mk)

TARGET_BOOTANIMATION_NAME := vertical-720x1280

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/i_vzw/full_i_vzw.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := i_vzw
PRODUCT_NAME := cm_i_vzw
PRODUCT_BRAND := Verizon
PRODUCT_MODEL := VS920 4G
PRODUCT_MANUFACTURER := LGE
PRODUCT_CHARACTERISTICS := phone
