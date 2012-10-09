ifeq ($(TARGET_BOOTLOADER_BOARD_NAME),i_vzw)

LOCAL_PATH := $(call my-dir)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
