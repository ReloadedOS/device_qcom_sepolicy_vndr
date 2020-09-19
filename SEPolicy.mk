# Board specific SELinux policy variable definitions
ifeq ($(call is-vendor-board-platform,QCOM),true)
ifneq ($(VENDOR_SEPOLICY_INCLUDED),true)

SEPOLICY_PATH:= device/qcom/sepolicy_vndr
QSSI_SEPOLICY_PATH:= device/qcom/sepolicy
SYS_ATTR_PROJECT_PATH := $(TOP)/device/qcom/sepolicy/generic/public/attribute
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS := \
    $(SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS) \
    $(QSSI_SEPOLICY_PATH)/generic/public \
    $(QSSI_SEPOLICY_PATH)/generic/public/attribute

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS := \
    $(SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS) \
    $(QSSI_SEPOLICY_PATH)/generic/private

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS := \
    $(SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS) \
    $(QSSI_SEPOLICY_PATH)/qva/public \
    $(QSSI_SEPOLICY_PATH)/qva/public/attribute

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS := \
    $(SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS) \
    $(QSSI_SEPOLICY_PATH)/qva/private

#once all the services are moved to Product /ODM above lines will be removed.
# sepolicy rules for product images
PRODUCT_PUBLIC_SEPOLICY_DIRS := \
    $(PRODUCT_PUBLIC_SEPOLICY_DIRS) \
    $(QSSI_SEPOLICY_PATH)/generic/product/public \
    $(QSSI_SEPOLICY_PATH)/qva/product/public

PRODUCT_PRIVATE_SEPOLICY_DIRS := \
    $(PRODUCT_PRIVATE_SEPOLICY_DIRS) \
    $(QSSI_SEPOLICY_PATH)/generic/product/private \
    $(QSSI_SEPOLICY_PATH)/qva/product/private

ifeq (,$(filter sdm845 sdm710, $(TARGET_BOARD_PLATFORM)))
    BOARD_SEPOLICY_DIRS := \
       $(BOARD_SEPOLICY_DIRS) \
       $(SEPOLICY_PATH) \
       $(SEPOLICY_PATH)/generic/vendor/common \
       $(SEPOLICY_PATH)/generic/vendor/common/attribute \
       $(SEPOLICY_PATH)/qva/vendor/ssg \
       $(SEPOLICY_PATH)/qva/vendor/common

    ifeq ($(TARGET_SEPOLICY_DIR),)
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/generic/vendor/$(TARGET_BOARD_PLATFORM)
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/qva/vendor/$(TARGET_BOARD_PLATFORM)
    else
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/generic/vendor/$(TARGET_SEPOLICY_DIR)
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/qva/vendor/$(TARGET_SEPOLICY_DIR)
    endif

    ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/generic/vendor/test
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/qva/vendor/test
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/qva/vendor/test/sysmonapp
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/qva/vendor/test/mst_test_app
    endif
endif

ifneq (,$(filter sdm845 sdm710, $(TARGET_BOARD_PLATFORM)))
    BOARD_SEPOLICY_DIRS := \
                 $(BOARD_SEPOLICY_DIRS) \
                 $(SEPOLICY_PATH) \
                 $(SEPOLICY_PATH)/legacy/vendor/ssg \
                 $(SEPOLICY_PATH)/legacy/vendor/common

    ifeq ($(TARGET_SEPOLICY_DIR),)
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/legacy/vendor/$(TARGET_BOARD_PLATFORM)
    else
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/legacy/vendor/$(TARGET_SEPOLICY_DIR)
    endif
    ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/legacy/vendor/test
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/legacy/vendor/test/sysmonapp
      BOARD_SEPOLICY_DIRS += $(SEPOLICY_PATH)/legacy/vendor/test/mst_test_app
    endif
endif

ifeq (,$(filter msm8226 msm8610 msm8974 msm8909 msm8916 msm8952 msm8992 msm8994 msm8937 msm8953 msm8996 msm8998 sdm660 sdm710 sdm845, $(TARGET_BOARD_PLATFORM)))
BOARD_SEPOLICY_M4DEFS += \
    qdisplay_service=vendor_qdisplay_service \
    sysfs_graphics=vendor_sysfs_graphics \
    hal_keymaster_qti_exec=vendor_hal_keymaster_qti_exec \
    persist_block_device=vendor_persist_block_device \
    display_vendor_data_file=vendor_display_vendor_data_file \
    hal_perf_default=vendor_hal_perf_default \
    sysfs_battery_supply=vendor_sysfs_battery_supply \
    sysfs_usb_supply=vendor_sysfs_usb_supply
endif

VENDOR_SEPOLICY_INCLUDED := true

endif
endif
