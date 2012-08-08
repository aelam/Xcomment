//
//  GAppDelegate.h
//  XCommentUITests
//
//  Created by Ryan Wang on 12-8-6.
//  Copyright (c) 2012年 Ryan Wang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCommentKit/XCommentKit.h>

@class DVTSourceTextViewHook;

@interface GAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet DVTSourceTextViewHook *textView;


@end
