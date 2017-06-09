PRODUCT_BRAND ?= ViperOs

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Tethys.ogg \
    ro.config.alarm_alert=Oxygen.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/viper/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/viper/prebuilt/common/bin/50-viper.sh:system/addon.d/50-viper.sh \
    vendor/viper/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# System feature whitelists
PRODUCT_COPY_FILES += \
    vendor/viper/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/viper/config/permissions/power-whitelist.xml:system/etc/sysconfig/power-whitelist.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# VIPER-specific init file
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/etc/init.local.rc:root/init.viper.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is ViperOS!
PRODUCT_COPY_FILES += \
    vendor/viper/config/permissions/com.viper.android.xml:system/etc/permissions/com.viper.android.xml

# Include CM audio files
include vendor/viper/config/cm_audio.mk

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include vendor/viper/config/cmsdk_common.mk
endif

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

PRODUCT_PROPERTY_OVERRIDES := \
    ro.com.google.ime.theme_id=5

PRODUCT_PROPERTY_OVERRIDES := \
    ro.opa.eligible_device=true

PRODUCT_PROPERTY_OVERRIDES := \
    ro.substratum.verified=true
	
# PixelLauncher
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/apk/PixelLauncher/PixelLauncher.apk:system/priv-app/PixelLauncher/PixelLauncher.apk
	
# GoogleWallpaperPicker
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/apk/GoogleWallpaperPicker/GoogleWallpaperPicker.apk:system/app/GoogleWallpaperPicker/GoogleWallpaperPicker.apk
	
# Turbo
PRODUCT_COPY_FILES += \
    vendor/viper/prebuilt/common/apk/Turbo/Turbo.apk:system/priv-app/Turbo/Turbo.apk
	
# Required VIPER packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMAudioService \
    CMParts \
    Development \
    Profiles

# Optional VIPER packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom VIPER packages
PRODUCT_PACKAGES += \
    AudioFX \
    CMSettingsProvider \
    CustomTiles \
    ExactCalculator \
    LiveLockScreenService \
    ThemeInterfacer \
    WallpaperPicker \
    VPapers \
    Gallery2 \
    Jelly

# Omni packages
PRODUCT_PACKAGES += \
    OmniStyle \
    OmniJaws

# Extra tools in VIPER
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_VIPER_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

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

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Dex optimization not required
WITH_DEXPREOPT := false

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank
endif

DEVICE_PACKAGE_OVERLAYS += vendor/viper/overlay/common

# Versioning System
# ViperOs version.
VIPER_VERSION_CODENAME := Python
VIPER_VERSION_NUMBER := v2.0

VIPER_DEVICE := $(VIPER_BUILD)

ifndef VIPER_BUILD_TYPE
    VIPER_BUILD_TYPE := UNOFFICIAL
    
PRODUCT_PROPERTY_OVERRIDES += \
    ro.viper.buildtype=unofficial
endif

ifeq ($(VIPER_BUILD_TYPE), OFFICIAL)
PRODUCT_PACKAGES += \
    ViperOTA
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ota.manifest=https://download.viper-os.com/ota/$(shell echo "$(VIPER_DEVICE)" | sed 's/viper_*//') \
    ro.ota.build.date=$(shell date +%Y%m%d)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.viper.buildtype=official
endif

# Set all versions
VIPER_VERSION := Viper-$(VIPER_DEVICE)-$(PLATFORM_VERSION)-$(VIPER_VERSION_CODENAME)-$(VIPER_VERSION_NUMBER)-$(shell date +"%Y%m%d")-$(VIPER_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    viper.ota.version=$(VIPER_VERSION) \
    ro.viper.version=$(VIPER_VERSION)

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/viper/build/target/product/security/viper

-include vendor/viper-priv/keys/keys.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/viper/config/partner_gms.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
