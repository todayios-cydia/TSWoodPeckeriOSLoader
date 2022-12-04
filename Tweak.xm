#include <UIKit/UIKit.h>
#include <objc/runtime.h>
#include <dlfcn.h>

%ctor {
	@autoreleasepool {
		NSDictionary *pref = [NSDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/com.todayios-cydia.woodpecker.plist"];
	
		NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
		NSArray *selectedApplications = [pref objectForKey:@"selectedApplications"];

		BOOL enabled = [selectedApplications containsObject:bundleIdentifier];
		HBLogDebug(@"WoodPecker selectedApplications:%@ contains %@", selectedApplications, bundleIdentifier);

		NSString *dylibPath = @"/Library/Application Support/TSWoodPeckeriOSLoader/WoodPeckeriOS.framework/WoodPeckeriOS";
		if (![[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) {
			HBLogDebug(@"WoodPeckeriOS dylib file not found: %@", dylibPath);
			return;
		} 

		if (enabled) {
			HBLogDebug(@"WoodPeckeriOS dylib enabled");
			void *handle = dlopen([dylibPath UTF8String], RTLD_NOW);
			if (handle == NULL) {
				char *error = dlerror();
				HBLogDebug(@"Load WoodPeckeriOS dylib fail: %s", error);
				return;
			}
		}
	}
}
