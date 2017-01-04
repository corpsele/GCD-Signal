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
 初始化

 @param array 方法名集合，如果方法名不一样就crash
 @param any   控制器

 @return 
 */
- (instancetype)initWithArray:(NSArray *)array withAny:(id)any;

/**
 给个信号继续运行
 */
- (void)setSignalForContinue;

/**
 给个信号跳出运行
 */
- (void)setSignalForBreak;

@end
