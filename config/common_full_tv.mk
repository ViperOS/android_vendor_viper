# Inherit full common Viper stuff
$(call inherit-product, vendor/viper/config/common_full.mk)

PRODUCT_PACKAGES += \
    AppDrawer \
    LineageCustomizer

DEVICE_PACKAGE_OVERLAYS += vendor/viper/overlay/tv
