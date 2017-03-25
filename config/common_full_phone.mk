# Inherit common VIPER stuff
$(call inherit-product, vendor/viper/config/common_full.mk)

# Required VIPER packages
PRODUCT_PACKAGES += \
    LatinIME

# Include VIPER LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/viper/overlay/dictionaries

$(call inherit-product, vendor/viper/config/telephony.mk)
