//
//  Consts.h
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#ifndef Consts_h
#define Consts_h

#define FITMainViewController (FITDrawerViewController *)[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController]
#define FITNavigationController (UINavigationController *)[(FITDrawerViewController *)[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] rootViewController]

#endif /* Consts_h */
