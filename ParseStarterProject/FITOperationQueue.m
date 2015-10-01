//
//  FITOperationQueue.m
//  Fitsei
//
//  Created by Konrad Roj on 01.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITOperationQueue.h"

@implementation FITOperationQueue

+ (void)asyncOperation:(operationBegin)begin successful:(operationEnded)end {
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Heating proteins...", nil) maskType:SVProgressHUDMaskTypeGradient];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        begin();
        dispatch_async(dispatch_get_main_queue(), ^{
            end();
            [SVProgressHUD dismiss];
        });
    });
}

@end
