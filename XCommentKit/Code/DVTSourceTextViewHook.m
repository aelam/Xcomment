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
#import "RuntimeReporter.h"
#import "XSettingsManager.h"

@class DVTSourceTextView;


@implementation DVTSourceTextViewHook

+ (void)hook {

    Class originClass = NSClassFromString(@"DVTSourceTextView");
    Class targetClass= NSClassFromString(@"DVTSourceTextViewHook");

    HookSelector(originClass, @selector(keyDown:), targetClass, @selector(keyDown:), @selector(origin_keyDown:));

}

- (void)keyDown:(NSEvent *)event {

    BOOL isPluginEnabled = [[XSettingsManager sharedSettingsManager] isXCommentEnabled];

    if (isPluginEnabled) {
        BOOL handled = [[XCommentEvaluator sharedEvaluator] handleCommentKeyEvent:event textView:self];
        if (!handled) {
            if([self respondsToSelector:@selector(origin_keyDown:)]) {
                [self origin_keyDown:event];
            } else {
                [super keyDown:event];
            }
        
        }
    }
    else{
        if([self respondsToSelector:@selector(origin_keyDown:)]) {
            [self origin_keyDown:event];
        } else {
            [super keyDown:event];
        }
    }

    return;
}


@end
