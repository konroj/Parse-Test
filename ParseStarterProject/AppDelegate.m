/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

// If you want to use any of the UI components, uncomment this line
// #import <ParseUI/ParseUI.h>

// If you are using Facebook, uncomment this line
// #import <ParseFacebookUtils/PFFacebookUtils.h>

// If you want to use Crash Reporting - uncomment this line
//#import <ParseCrashReporting/ParseCrashReporting.h>

#import "AppDelegate.h"
#import "FITDrawerViewController.h"

@implementation AppDelegate

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[ParseCrashReporting enable];
    [FITDishEntity registerSubclass];
    [FITProductEntity registerSubclass];
    [FITDayEntity registerSubclass];
    
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"uejry7qM0YFtG1cKvYJg2FsrLtLW6Yyy8DDiOJFH" clientKey:@"n4BcI97rFOxFYOQ7od6LABRqZsUWFVqRRyi4c1VU"];
    [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];

    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];

    if (application.applicationState != UIApplicationStateBackground) {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced in iOS 7).
        // In that case, we skip tracking here to avoid double counting the app-open.
        BOOL preBackgroundPush = ![application respondsToSelector:@selector(backgroundRefreshStatus)];
        BOOL oldPushHandlerOnly = ![self respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }

    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastDataFetchDate"];
    if (date == nil || [self daysBetweenDates:date second:[NSDate date]] > 6) {
        PFQuery *query = [PFQuery queryWithClassName:@"Dish"];
        NSArray *objects = [query findObjects];
        [PFObject pinAllInBackground:objects block:^(BOOL succeeded, NSError * _Nullable error) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastDataFetchDate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
    }
    
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@"logo"]];

    return YES;
}

- (NSInteger)daysBetweenDates:(NSDate *)startDate second:(NSDate *)endDate {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    
    return [components day];
}

#pragma mark Push Notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];

    [PFPush subscribeToChannelInBackground:@"" block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Fitsei successfully subscribed to push notifications on the broadcast channel.");
        } else {
            NSLog(@"Fitsei failed to subscribe to push notifications on the broadcast channel.");
        }
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];

    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

///////////////////////////////////////////////////////////
// Uncomment this method if you want to use Push Notifications with Background App Refresh
///////////////////////////////////////////////////////////
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    if (application.applicationState == UIApplicationStateInactive) {
//        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
//    }
//}

#pragma mark Facebook SDK Integration

///////////////////////////////////////////////////////////
// Uncomment this method if you are using Facebook
///////////////////////////////////////////////////////////
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    return [PFFacebookUtils handleOpenURL:url];
//}

@end
