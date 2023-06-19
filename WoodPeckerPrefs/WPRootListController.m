#include "WPRootListController.h"

@implementation WPRootListController

- (NSArray *)specifiers {
 if (!_specifiers) {
 	_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
 }
 return _specifiers;
}

- (void)twitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/manajay_dlj"] options:@{} completionHandler:nil];
}

-(void)respringAction{
    NSURL *relaunchURL = [NSURL URLWithString:@"prefs:root=TSWoodPeckeriOSLoader"];
    SBSRelaunchAction *restartAction = [NSClassFromString(@"SBSRelaunchAction") actionWithReason:@"RestartRenderServer" options:4 targetURL:relaunchURL];
    [[NSClassFromString(@"FBSSystemService") sharedService] sendActions:[NSSet setWithObject:restartAction] withResult:nil];
}

@end