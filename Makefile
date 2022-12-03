ARCHS = arm64
# 注意先USB 连接: iproxy 2222 22
THEOS_DEVICE_IP = localhost -p 2222
# 注意 安装 theos 的路径
# THOES = /opt/theos
TARGET = iphone:clang:13.7
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TSWoodPeckeriOSLoader
BUNDLE_NAME = $(TWEAK_NAME)
$(TWEAK_NAME)_FRAMEWORKS = UIKit
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = Preferences
$(TWEAK_NAME)_EXTRA_FRAMEWORKS = AltList
$(TWEAK_NAME)_FILES = Tweak.xm

include $(THEOS)/makefiles/tweak.mk

before-package::
	@echo "Run WoodPeckeriOS dylib build script..."
	./build_dylib.sh

after-install::
	install.exec "killall -9 SpringBoard"
