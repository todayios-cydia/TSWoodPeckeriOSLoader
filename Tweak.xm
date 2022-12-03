#include <UIKit/UIKit.h>
#include <objc/runtime.h>
#include <dlfcn.h>

%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSDictionary *pref = [NSDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/com.todayios-cydia.woodpecker.plist"];
	
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	NSArray *selectedApplications = [pref objectForKey:@"selectedApplications"];

	BOOL enabled = [selectedApplications containsObject:bundleIdentifier];
	NSLog(@"WoodPecker selectedApplications:%@ contains %@", selectedApplications, bundleIdentifier);

	NSString *dylibPath = @"/Library/Application Support/TSWoodPeckeriOSLoader/WoodPeckeriOS.framework/WoodPeckeriOS";
	if (![[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) {
		NSLog(@"WoodPeckeriOS dylib file not found: %@", dylibPath);
		return;
	} 

	if (enabled) {
		NSLog(@"WoodPeckeriOS dylib enabled");
		void *handle = dlopen([dylibPath UTF8String], RTLD_NOW);
		if (handle == NULL) {
			char *error = dlerror();
			NSLog(@"Load WoodPeckeriOS dylib fail: %s", error);
			return;
		}
	}	

	[pool drain];
}
