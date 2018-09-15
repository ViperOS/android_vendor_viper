# Inherit mini common Viper stuff
$(call inherit-product, vendor/viper/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/viper/config/telephony.mk)
