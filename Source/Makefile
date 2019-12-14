export ARCHS = arm64 armv7 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PowerModule
$(BUNDLE_NAME)_BUNDLE_EXTENSION = bundle
$(BUNDLE_NAME)_CFLAGS +=  -fobjc-arc -I$(THEOS_PROJECT_DIR)/headers
$(BUNDLE_NAME)_FILES = $(wildcard *.m)
$(BUNDLE_NAME)_LDFLAGS += $(THEOS_PROJECT_DIR)/Frameworks/ControlCenterUIKit.tbd
$(BUNDLE_NAME)_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk

after-stage::
    chmod 4755 $(THEOS_STAGING_DIR)/usr/bin/mobileldrestart

after-install::
	install.exec "killall -9 backboardd"

SUBPROJECTS += powermoduleprefs
SUBPROJECTS += mobileldrestart
include $(THEOS_MAKE_PATH)/aggregate.mk