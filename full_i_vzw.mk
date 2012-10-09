PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
# This is where we'd set a backup provider if we had one
#$(call inherit-product, device/sample/products/backup_overlay.mk)

$(call inherit-product, device/lge/i_vzw/device.mk)

# Screen density is actually considered a locale (since it is taken into account
# the the build-time selection of resources). The product definitions including
# this file must pay attention to the fact that the first entry in the final
# PRODUCT_LOCALES expansion must not be a density.
PRODUCT_LOCALES += xhdpi

# Discard inherited values and use our own instead.
PRODUCT_NAME := full_i_vzw
PRODUCT_DEVICE := i_vzw
PRODUCT_BRAND := Verizon
PRODUCT_MODEL := VS920 4G
PROUDCT_MANUFACTURER := LGE
