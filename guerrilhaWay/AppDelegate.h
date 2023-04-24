//
//  AppDelegate.h
//  guerrilhaWay
//
//  Created by Samuel Bispo on 24/04/23.
//

#import <UIKit/UIKit.h>
#import <MobileRTC/MobileRTC.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, MobileRTCAuthDelegate>

// NAO FUNCIONOU SEM ISSO
@property (strong, nonatomic) UIWindow *window;

@end

