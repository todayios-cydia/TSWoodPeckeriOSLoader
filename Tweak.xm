#include <UIKit/UIKit.h>
#include <objc/runtime.h>
#include <dlfcn.h>
#import <rootless.h>

#define WOODPECKER_IDENTIFIER @"com.todayios-cydia.woodpecker"
#define kPrefsPlistPath ROOT_PATH_NS(@"/var/mobile/Library/Preferences/com.todayios-cydia.woodpecker.plist")
#define WOODPECKER_SWITCH_KEY @"woodpecker-preference-switch"
#define DYLIB_PATH ROOT_PATH_NS(@"/Library/Application Support/TSWoodPeckeriOSLoader/WoodPeckeriOS.framework/WoodPeckeriOS")

#define HBLogDebug NSLog

%ctor {
	@autoreleasepool {
		NSDictionary *pref = [NSDictionary dictionaryWithContentsOfFile:kPrefsPlistPath];
		BOOL enabled = [[pref objectForKey:WOODPECKER_SWITCH_KEY] boolValue];
		NSString *dylibPath = DYLIB_PATH;
		if (![[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) {
			HBLogDebug(@"WoodPeckeriOS dylib file not found: %@", dylibPath);
			return;
		} 

		if (enabled) {
			HBLogDebug(@"WoodPeckeriOS dylib enabled: %d", enabled);
			void *handle = dlopen([dylibPath UTF8String], RTLD_NOW);
			if (handle == NULL) {
				char *error = dlerror();
				HBLogDebug(@"Load WoodPeckeriOS dylib fail: %s", error);
				return;
			}
		}
	}
}
