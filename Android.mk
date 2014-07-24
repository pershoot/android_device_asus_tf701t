#
# Copyright (C) 2011 The Android Open-Source Project
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
#

# WARNING: Everything listed here will be built on ALL platforms,
# including x86, the emulator, and the SDK.  Modules must be uniquely
# named (liblights.tuna), and must build everywhere, or limit themselves
# to only building on ARM if they include assembly. Individual makefiles
# are responsible for having their own logic, for fine-grained control.

ifneq ($(filter tf701t,$(TARGET_DEVICE)),)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# link hardware to project for sensors
$(shell mkdir -p $(TARGET_OUT_SHARED_LIBRARIES)/hw; \
        cd $(TARGET_OUT_SHARED_LIBRARIES)/hw; \
        ln -sf sensors.mozart.so sensors.macallan.so)

# link to project for nvaudio_conf
$(shell mkdir -p $(TARGET_OUT_ETC); \
        cd $(TARGET_OUT_ETC); \
        ln -sf nvaudio_conf_mozart.xml nvaudio_conf.xml)

# copy audio_effects override
$(shell mkdir -p $(TARGET_OUT_ETC); \
        cp -pf device/asus/tf701t/audio/audio_effects.conf $(TARGET_OUT_ETC))

# copy keylayout overrides
$(shell mkdir -p $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/AVRCP.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Generic.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Vendor_0079_Product_0011.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Vendor_045e_Product_028e.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Vendor_046d_Product_c216.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Vendor_046d_Product_c219.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Vendor_046d_Product_c21f.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Vendor_054c_Product_0268.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Vendor_1038_Product_1412.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Vendor_12bd_Product_d015.kl $(TARGET_OUT_KEYLAYOUT); \
        cp -pf device/asus/tf701t/keylayout/Vendor_2378_Product_100a.kl $(TARGET_OUT_KEYLAYOUT))

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
