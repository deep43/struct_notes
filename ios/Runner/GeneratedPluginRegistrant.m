//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <drawerbehavior/DrawerbehaviorPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <sqflite/SqflitePlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [DrawerbehaviorPlugin registerWithRegistrar:[registry registrarForPlugin:@"DrawerbehaviorPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
