//
//  DVTSourceTextView.m
//  XComment
//
//  Created by Ryan Wang on 12-8-6.
//  Copyright (c) 2012年 Ryan Wang. All rights reserved.
//

#import "DVTSourceTextViewHook.h"
#import "MethodHook.h"
#import "XCommentEvaluator.h"

@class DVTSourceTextView;

@implementation DVTSourceTextViewHook

#ifdef HOOK_ENABLED

+ (void)hook {

    Class originClass = NSClassFromString(@"DVTSourceTextView");
    Class targetClass= NSClassFromString(@"DVTSourceTextViewHook");
    
    HookSelector(originClass, @selector(setSelectedRange:), targetClass, @selector(setSelectedRange:), @selector(origin_setSelectedRange:));

    HookSelector(originClass, @selector(keyDown:), targetClass, @selector(keyDown:), @selector(origin_keyDown:));
}

#endif
    
- (BOOL)textView:(id)arg1 shouldChangeTextInRange:(struct _NSRange)arg2 replacementString:(id)arg3 {
        
    if([self respondsToSelector:@selector(origin_textView:shouldChangeTextInRange:replacementString:)]) {
        return [self origin_textView:arg1 shouldChangeTextInRange:arg2 replacementString:arg3];
    } else {        
        return YES;
    }
    
}

- (void)setSelectedRange:(NSRange)range {
    
    if ([self respondsToSelector:@selector(origin_setSelectedRange:)]) {
        [self origin_setSelectedRange:range];
    } else {
        [super setSelectedRange:range];
    }
}

- (void)keyDown:(NSEvent *)event {
    
    BOOL handled = [[XCommentEvaluator sharedEvaluator] handleCommentKeyEvent:event textView:self];
    if (!handled) {
        if([self respondsToSelector:@selector(origin_keyDown:)]) {
            [self origin_keyDown:event];
        } else {
            [super keyDown:event];
        }
    }
}

@end
