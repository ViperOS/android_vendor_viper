# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= ViperOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# init file
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/etc/init.local.rc:system/etc/init/init.viper.rc

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/viper/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/viper/prebuilt/common/bin/50-viper.sh:system/addon.d/50-viper.sh \
    vendor/viper/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/viper/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/viper/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/viper/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Lineage-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/viper/config/permissions/lineage-sysconfig.xml:system/etc/sysconfig/lineage-sysconfig.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/viper/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all Lineage-specific init rc files
$(foreach f,$(wildcard vendor/viper/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Lineage!
PRODUCT_COPY_FILES += \
    vendor/viper/config/permissions/org.lineageos.android.xml:system/etc/permissions/org.lineageos.android.xml \
    vendor/viper/config/permissions/privapp-permissions-lineage.xml:system/etc/permissions/privapp-permissions-lineage.xml

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/viper/config/permissions/lineage-hiddenapi-package-whitelist.xml:system/etc/permissions/lineage-hiddenapi-package-whitelist.xml

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/viper/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml \
    vendor/viper/prebuilt/common/sysconfig/turbo.xml:system/etc/sysconfig/turbo.xml

# Weather Client
PRODUCT_COPY_FILES += \
    vendor/viper/config/permissions/com.viper.weather.client.xml:system/etc/permissions/com.viper.weather.client.xml \
    vendor/viper/config/default-permissions/com.viper.weather.client.xml:system/etc/default-permissions/com.viper.weather.client.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/viper/config/permissions/lineage-power-whitelist.xml:system/etc/sysconfig/lineage-power-whitelist.xml

# Include Lineage audio files
include vendor/viper/config/lineage_audio.mk

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/viper/config/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/viper/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Required Lineage packages
PRODUCT_PACKAGES += \
    LineageParts \
    Development \
    Profiles

# Optional packages
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Custom Lineage packages
PRODUCT_PACKAGES += \
    AudioFX \
    LineageSettingsProvider \
    ExactCalculator \
    LockClock \
    WallpaperPicker \
    WeatherProvider

# ViperOS Packages
PRODUCT_PACKAGES += \
    GContacts \
    GDeskClock \
    GDialer \
    GMessaging \
    GCalculator \
    Launcher3QuickStep \
    Turbo \
    WeatherClient \
    VPapers \
    AmbientSensePrebuilt

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in Lineage
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_LINEAGE_CHARGER),true)
PRODUCT_PACKAGES += \
    lineage_charger_res_images \
    font_log.png \
    libhealthd.lineage
endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

PRODUCT_PROPERTY_OVERRIDES += \
    ro.opa.eligible_device=true

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    micro_bench \
    procmem \
    procrank \
    strace

# Conditionally build in su
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/viper/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/viper/overlay/common

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/viper/build/target/product/security/viper

-include vendor/viper-priv/keys/keys.mk

-include vendor/viper/config/version.mk

include vendor/themes/common.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/viper/config/partner_gms.mk

# Permissions
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/permissions/turbo.xml:system/etc/permissions/turbo.xml

# Ambient, Google app and Sound search tile - music recognition
PRODUCT_COPY_FILES +=  \
    vendor/viper/prebuilt/common/etc/ambient/matcher_tah.leveldb:system/etc/ambient/matcher_tah.leveldb
