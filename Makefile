export ARCHS = arm64
export DEBUG = 0
export FINALPACKAGE = 1

# 注意先USB 连接: iproxy 2222 22
# THEOS_DEVICE_IP = localhost -p 2222

# 注意 安装 theos 的路径
# THOES = /opt/theos
ROOTLESS = 1
ifeq ($(ROOTLESS),1)
 THEOS_PACKAGE_SCHEME=rootless
endif

ifeq ($(THEOS_PACKAGE_SCHEME), rootless)
 export TARGET = iphone:clang:latest:15.0
else
 export TARGET = iphone:clang:latest:12.0
endif

include ${THEOS}/makefiles/common.mk

TWEAK_NAME = TSWoodPeckeriOSLoader
$(TWEAK_NAME)_FRAMEWORKS = UIKit
$(TWEAK_NAME)_FILES = Tweak.xm

include ${THEOS}/makefiles/tweak.mk
SUBPROJECTS += WoodPeckerPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk

# before-package::
# 	@echo "Run WoodPeckeriOS dylib build script..."
# 	ruby ./build_dylib.rb

after-install::
	install.exec "killall -9 SpringBoard"
