# Copyright (C) 2018 ViperOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Versioning System
# ViperOS Version.
VIPER_VERSION_NUMBER := v6.5
VIPER_VERSION_P := 6.5
VIPER_BUILD_DATE := $(shell date -u +%d-%m-%Y)
VIPER_DEVICE := $(VIPER_BUILD)

ifndef VIPER_BUILD_TYPE
    VIPER_BUILD_TYPE := UNOFFICIAL

endif

ifeq ($(VIPER_BUILD_TYPE), OFFICIAL)

PRODUCT_PACKAGES += \
    Updater

endif

# Set all versions
VIPER_VERSION := Viper-$(VIPER_DEVICE)-$(shell date +"%Y%m%d")-$(VIPER_VERSION_NUMBER)-$(VIPER_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.viper.buildtype=$(VIPER_BUILD_TYPE) \
    viper.ota.version=$(VIPER_VERSION) \
    ro.modversion=$(VIPER_VERSION_NUMBER) \
    ro.vipermodversion=$(VIPER_VERSION_P) \
    ro.viper.version=$(VIPER_VERSION) \
    ro.viper.build_date=$(VIPER_BUILD_DATE) \
    ro.viper.device=$(VIPER_DEVICE)
