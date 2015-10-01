//
//  FITOperationQueue.h
//  Fitsei
//
//  Created by Konrad Roj on 01.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^operationBegin)(void);
typedef void (^operationEnded)(void);

@interface FITOperationQueue : NSObject

+ (void)asyncOperation:(operationBegin)begin successful:(operationEnded)end;

@end
