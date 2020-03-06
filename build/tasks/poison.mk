# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
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

# -----------------------------------------------------------------
# Viper OTA update package

LINEAGE_TARGET_PACKAGE := $(PRODUCT_OUT)/$(CUSTOM_VERSION).zip

.PHONY: otapackage poison
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
poison: otapackage
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(LINEAGE_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(LINEAGE_TARGET_PACKAGE) > $(LINEAGE_TARGET_PACKAGE).md5sum
	@echo -e ${CL_CYN}""${CL_CYN}
	@echo -e ${CL_CYN}" ██▒   █▓ ██▓ ██▓███  ▓█████  ██▀███   ▒█████    ██████     ██▓███   ██▀███   ▒█████   ▄▄▄██▀▀▀▓█████  ▄████▄  ▄▄▄█████▓ "${CL_CYN}
	@echo -e ${CL_CYN}"▓██░   █▒▓██▒▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒▒██▒  ██▒▒██    ▒    ▓██░  ██▒▓██ ▒ ██▒▒██▒  ██▒   ▒██   ▓█   ▀ ▒██▀ ▀█  ▓  ██▒ ▓▒ "${CL_CYN}
	@echo -e ${CL_CYN}" ▓██  █▒░▒██▒▓██░ ██▓▒▒███   ▓██ ░▄█ ▒▒██░  ██▒░ ▓██▄      ▓██░ ██▓▒▓██ ░▄█ ▒▒██░  ██▒   ░██   ▒███   ▒▓█    ▄ ▒ ▓██░ ▒░ "${CL_CYN}
	@echo -e ${CL_CYN}"  ▒██ █░░░██░▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄  ▒██   ██░  ▒   ██▒   ▒██▄█▓▒ ▒▒██▀▀█▄  ▒██   ██░▓██▄██▓  ▒▓█  ▄ ▒▓▓▄ ▄██▒░ ▓██▓ ░  "${CL_CYN}
	@echo -e ${CL_CYN}"   ▒▀█░  ░██░▒██▒ ░  ░░▒████▒░██▓ ▒██▒░ ████▓▒░▒██████▒▒   ▒██▒ ░  ░░██▓ ▒██▒░ ████▓▒░ ▓███▒   ░▒████▒▒ ▓███▀ ░  ▒██▒ ░  "${CL_CYN}
	@echo -e ${CL_CYN}"   ░ ▐░  ░▓  ▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░   ▒▓▒░ ░  ░░ ▒▓ ░▒▓░░ ▒░▒░▒░  ▒▓▒▒░   ░░ ▒░ ░░ ░▒ ▒  ░  ▒ ░░    "${CL_CYN}
	@echo -e ${CL_CYN}"   ░ ░░   ▒ ░░▒ ░      ░ ░  ░  ░▒ ░ ▒░  ░ ▒ ▒░ ░ ░▒  ░ ░   ░▒ ░       ░▒ ░ ▒░  ░ ▒ ▒░  ▒ ░▒░    ░ ░  ░  ░  ▒       ░     "${CL_CYN}
	@echo -e ${CL_CYN}"     ░░   ▒ ░░░          ░     ░░   ░ ░ ░ ░ ▒  ░  ░  ░     ░░         ░░   ░ ░ ░ ░ ▒   ░ ░ ░      ░   ░          ░       "${CL_CYN}
	@echo -e ${CL_CYN}"      ░   ░              ░  ░   ░         ░ ░        ░                 ░         ░ ░   ░   ░      ░  ░░ ░                "${CL_CYN}
	@echo -e ${CL_CYN}"     ░                                                                                                ░                  "${CL_CYN}
	@echo -e ${CL_CYN}"                                              Feel the venom in your vein                                                "${CL_CYN}
	@echo -e ${CL_CYN}""${CL_CYN}
	@echo -e ${CL_CYN}"===================================================-Package complete-===================================================="${CL_RST}
	@echo -e ${CL_CYN}"File   : "${CL_MAG} $(PRODUCT_OUT)/$(CUSTOM_VERSION).zip${CL_RST}
	@echo -e ${CL_CYN}"MD5    : "${CL_MAG}" `cat $(LINEAGE_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1`"${CL_RST}
	@echo -e ${CL_CYN}"Size   : "${CL_MAG}" `ls -lah $(LINEAGE_TARGET_PACKAGE) | cut -d ' ' -f 5`"${CL_RST}
	@echo -e ${CL_CYN}"========================================================================================================================="${CL_RST}

