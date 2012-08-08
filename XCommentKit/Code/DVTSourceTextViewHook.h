//
//  DVTSourceTextView.h
//  XComment
//
//  Created by Ryan Wang on 12-8-6.
//  Copyright (c) 2012年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DVTSourceTextViewSwizzle <NSObject>

@optional

- (void)origin_keyDown:(NSEvent *)event;

@end

@interface DVTSourceTextViewHook : NSTextView<DVTSourceTextViewSwizzle>

+ (void)hook;

@end
