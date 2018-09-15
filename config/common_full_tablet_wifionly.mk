# Inherit full common Viper stuff
$(call inherit-product, vendor/viper/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Viper LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/viper/overlay/dictionaries
