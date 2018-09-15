# ViperOS System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.viper.releasetype=$(VIPER_BUILD_TYPE) \
    ro.viper.build.version=$(VIPER_VERSION_NUMBER) \

# ViperOS Platform Display Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.viper.display.version=$(VIPER_VERSION)

# LineageOS Platform SDK Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)
