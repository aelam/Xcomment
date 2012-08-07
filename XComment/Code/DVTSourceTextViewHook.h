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
- (BOOL)origin_textView:(id)arg1 shouldChangeTextInRange:(struct _NSRange)arg2 replacementString:(id)arg3;
- (void)origin_setSelectedRange:(NSRange)range;
- (void)origin_keyDown:(NSEvent *)event;

@end

@interface DVTSourceTextViewHook : NSTextView<DVTSourceTextViewSwizzle>

#ifdef HOOK_ENABLED

+ (void)hook;

#endif

@end
