$(call inherit-product, vendor/viper/config/common_mini.mk)

# Required VIPER packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/viper/config/telephony.mk)
