LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := mysendevent
LOCAL_SRC_FILES := $(LOCAL_PATH)/../mysendevent.c

#LOCAL_LDLIBS := -llog  # Add any libraries you need

include $(BUILD_EXECUTABLE)
