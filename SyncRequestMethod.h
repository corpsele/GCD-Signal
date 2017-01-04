//
//  SyncRequestMethod.h
//  Aoyou
//
//  Created by corpsele on 16/11/7.
//  Copyright © 2016年 Fantasy,Guoqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncRequestMethod : NSObject
{
    @private
    NSArray *_array;
    id _any;
    dispatch_group_t _group;
    dispatch_semaphore_t _semaphore;
    dispatch_queue_t _queue;
    BOOL _break;
}

+ (instancetype) sharedInstance:(NSArray *)array withAny:(id)any;

/**
 Initial

 @param array Method of Array，When Method Name not same will be crash
 @param any   current VC

 @return
 */
- (instancetype)initWithArray:(NSArray *)array withAny:(id)any;

/**
 Sent Signal to Continue
 */
- (void)setSignalForContinue;

/**
 Sent Signal to Stop GCD
 */
- (void)setSignalForBreak;

@end
