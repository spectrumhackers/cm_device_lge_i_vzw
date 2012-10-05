ifeq ($(TARGET_BOOTLOADER_BOARD_NAME),VS920)

LOCAL_PATH := $(call my-dir)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
