#include <UIKit/UIKit.h>
#include <objc/runtime.h>
#include <dlfcn.h>

%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSDictionary *pref = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.todayios-cydia.woodpecker.plist"];
	NSString *keyPath = [NSString stringWithFormat:@"TSWoodPeckeriOSLoaderEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]];
	BOOL TSWoodPeckeriOSLoaderEnabled = [[pref objectForKey:keyPath] boolValue];
	NSString *dylibPath = @"/Library/Application Support/TSWoodPeckeriOSLoader/WoodPeckeriOS.framework/WoodPeckeriOS";

	if (![[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) {
		NSLog(@"WoodPeckeriOS dylib file not found: %@", dylibPath);
		return;
	} 

	// NSLog(@"keyPath:%@ , TSWoodPeckeriOSLoaderEnabled: value:%d",keyPath,TSWoodPeckeriOSLoaderEnabled);
	if (TSWoodPeckeriOSLoaderEnabled) {
		void *handle = dlopen([dylibPath UTF8String], RTLD_NOW);
		if (handle == NULL) {
			char *error = dlerror();
			NSLog(@"Load WoodPeckeriOS dylib fail: %s", error);
			return;
		}
	}	

	[pool drain];
}
