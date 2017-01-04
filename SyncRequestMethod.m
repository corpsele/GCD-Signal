//
//  SyncRequestMethod.m
//  Aoyou
//
//  Created by corpsele on 16/11/7.
//  Copyright © 2016年 Fantasy,Guoqiang. All rights reserved.
//

#import "SyncRequestMethod.h"

@implementation SyncRequestMethod

static SyncRequestMethod *requestMethod = nil;

+ (instancetype) sharedInstance:(NSArray *)array withAny:(id)any
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestMethod = [[SyncRequestMethod alloc] initWithArray:array withAny:any];
    });
    return requestMethod;
}

- (instancetype)initWithArray:(NSArray *)array withAny:(id)any
{
    self = [super init];
    if (self) {
        _array = array;
        _any = any;
        _break = false;
        
        [self doThisThing];
    }
    return self;
}

- (void)doThisThing
{
    if (!_array || _array.count < 1) {
        return;
    }
    if (!_any) {
        return;
    }
    
    [self setEvent:_array];
    
}

- (void)setEvent:(NSArray *)arr
{
    _group = dispatch_group_create();
    _semaphore = dispatch_semaphore_create(1);
    _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak id _weakAny = _any;
    dispatch_group_async(_group, _queue, ^{
        for (int i = 0; i < arr.count; i++) {
            dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
            if (_break) {
                break;
            }
            SEL method = NSSelectorFromString(arr[i]);
            IMP imp = [_weakAny methodForSelector:method];
            if ([_weakAny respondsToSelector: method]) {
                void (*func)(id, SEL) = (void *)imp;
                func(_weakAny, method);
            }
        }
    });
    _break = false;
}

- (void)setSignalForContinue
{
    dispatch_semaphore_signal(_semaphore);
}

- (void)setSignalForBreak
{
    _break = true;
    dispatch_semaphore_signal(_semaphore);
}

@end
