# Charger
ifeq ($(WITH_LINEAGE_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.viper
endif

include vendor/viper/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/viper/config/BoardConfigQcom.mk
endif

include vendor/viper/config/BoardConfigSoong.mk
