//
//  AppDelegate.m
//  guerrilhaWay
//
//  Created by Samuel Bispo on 24/04/23.
//

#import "AppDelegate.h"
#import <MobileRTC/MobileRTC.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupSDK];
    
    return YES;
}

- (void)setupSDK {
    NSString *sdkKey = @"y_e_hgpcRlGcJDnCCDv5Cg";
    NSString *sdkSecret = @"Sj3QfVBvr5dG0iu1ah7eeFTPQFMEArce";
    
    MobileRTCSDKInitContext *context = [[MobileRTCSDKInitContext alloc] init];
    context.domain = @"zoom.us";
    context.enableLog = YES;
    BOOL sdkInitSuc = [[MobileRTC sharedRTC] initialize:context];
    if (sdkInitSuc) {
        MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
                if (authService) {
            authService.clientKey = sdkKey;
            authService.clientSecret = sdkSecret;
           // Set the authService delegate.
            authService.delegate = self;
            [authService sdkAuth];
        }
    }
}
// Include MobileRTCAuthDelegate methods
#pragma mark - MobileRTCAuthDelegate
/**
* To monitor the status and catch errors that might occur during the authorization process, implement the onMobileRTCAuthReturn method
*/
- (void)onMobileRTCAuthReturn:(MobileRTCAuthError)returnValue {
    switch (returnValue) {
        case MobileRTCAuthError_Success:
            NSLog(@"SDK successfully initialized.");
            break;
        case MobileRTCAuthError_KeyOrSecretEmpty:
            NSLog(@"SDK key/secret was not provided. Replace sdkKey and sdkSecret at the top of this file with your SDK key/secret.");
            break;
        case MobileRTCAuthError_KeyOrSecretWrong:
            NSLog(@"SDK key/secret is not valid.");
            break;
        case MobileRTCAuthError_Unknown:
            NSLog(@"SDK key/secret is not valid.");
            break;
        default:
            NSLog(@"SDK Authorization failed with MobileRTCAuthError: %u", returnValue);
    }
    
    // SE A SDK FOR INICIALIZADA CORRETAMENTE, ENTAO, INICIAR A REUNIAO
    if (returnValue == MobileRTCAuthError_Success) {
        BOOL isAuthorized = [[MobileRTC sharedRTC] isRTCAuthorized];
        NSLog(isAuthorized ? @"Authorized: Yes" : @"Authorized: No");
        
        MobileRTCMeetingJoinParam *joinParams = [[MobileRTCMeetingJoinParam alloc] init];
        joinParams.userName = @"Samuel Bispo";
        joinParams.meetingNumber = @"7327495810";
        joinParams.password = @"6jHams";
        joinParams.noAudio = YES;
        joinParams.noVideo = YES;
        
        MobileRTCMeetingService *meetingService = [[MobileRTC sharedRTC] getMeetingService];
        MobileRTCMeetError joinMeetingResult = [meetingService joinMeetingWithJoinParam:joinParams];
        NSLog(@"joinMeeting, joinMeetingResult=%lu", joinMeetingResult);
    }
}


@end
