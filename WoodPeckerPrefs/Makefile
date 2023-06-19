# ARCHS = arm64
# THEOS_DEVICE_IP = localhost -p 2222
# TARGET = iphone:clang:latest # 注意 theos 的 SDK 内是否有相应的版本
include ${THEOS}/makefiles/common.mk

BUNDLE_NAME = WoodPeckerPrefs
$(BUNDLE_NAME)_FRAMEWORKS = UIKit
$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = Preferences
# $(BUNDLE_NAME)_EXTRA_FRAMEWORKS = AltList
$(BUNDLE_NAME)_FILES = WPRootListController.m
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc  -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/bundle.mk


internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/WoodPeckerPrefs.plist$(ECHO_END)