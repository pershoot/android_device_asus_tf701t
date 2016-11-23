# Copyright (C) 2013 The Android Open Source Project
# Copyright (C) 2013 The CyanogenMod Project
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

ifneq ($(filter tf701t,$(TARGET_DEVICE)),)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := rm-wrapper
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := rm-wrapper.c
LOCAL_CFLAGS := -fPIE
LOCAL_LDFLAGS := -fPIE -pie -ldl -llog
LOCAL_SHARED_LIBRARIES := libc libdl liblog libm libstdc++
include $(BUILD_EXECUTABLE)

$(shell mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/sbin; \
        cp -pf $(LOCAL_PATH)/sbin/linker $(TARGET_RECOVERY_ROOT_OUT)/sbin; \
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/firmware; \
	cp -pf $(LOCAL_PATH)/firmware/* $(TARGET_RECOVERY_ROOT_OUT)/firmware; \
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/lib; \
	cp -pf $(ANDROID_BUILD_TOP)/vendor/asus/tf701t/proprietary/lib/librm31080.so $(TARGET_RECOVERY_ROOT_OUT)/lib; \
	cp -pf $(ANDROID_BUILD_TOP)/vendor/asus/tf701t/proprietary/lib/hw/ts.default.so $(TARGET_RECOVERY_ROOT_OUT)/lib; \
	cp -pf $(LOCAL_PATH)/lib/* $(TARGET_RECOVERY_ROOT_OUT)/lib)

endif
