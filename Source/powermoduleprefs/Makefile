ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PowerModulePrefs
PowerModulePrefs_FILES = MRYRootListController.m
PowerModulePrefs_INSTALL_PATH = /Library/PreferenceBundles
PowerModulePrefs_FRAMEWORKS = UIKit
PowerModulePrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/PowerModulePrefs.plist$(ECHO_END)
