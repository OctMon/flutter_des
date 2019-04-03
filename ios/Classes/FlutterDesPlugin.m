#import "FlutterDesPlugin.h"
#import <flutter_des/flutter_des-Swift.h>

@implementation FlutterDesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterDesPlugin registerWithRegistrar:registrar];
}
@end
