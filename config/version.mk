# Copyright (C) 2019 LineageOS
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

CUSTOM_ANDROID_NAME := Ten
CUSTOM_ANDROID_VERSION := 10
CUSTOM_BUILD_DATE=$(shell date +"%Y%m%d-%H%M")
CUSTOM_DEVICE := $(LINEAGE_BUILD)

ifndef CUSTOM_BUILD_TYPE
    CUSTOM_BUILD_TYPE := UNOFFICIAL
endif
ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)
    CUSTOM_VERSION := $(CUSTOM_ANDROID_VERSION)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_DEVICE)
#    PRODUCT_PACKAGES += \
#        Updater
else
    CUSTOM_VERSION := $(CUSTOM_DEVICE)-$(CUSTOM_ANDROID_VERSION)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_DEVICE)-$(CUSTOM_BUILD_TYPE)
endif


PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=$(CUSTOM_ANDROID_VERSION) \
    ro.custom.build.version=$(CUSTOM_ANDROID_VERSION) \
    ro.custom.version=$(CUSTOM_AOSP_VERSION) \
    ro.custom.buildtype=$(CUSTOM_BUILD_TYPE) \
    ro.custom.build.date=$(CUSTOM_BUILD_DATE) \
    ro.custom.device=$(CUSTOM_DEVICE)

