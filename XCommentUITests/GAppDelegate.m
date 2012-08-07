//
//  GAppDelegate.m
//  XCommentUITests
//
//  Created by Ryan Wang on 12-8-6.
//  Copyright (c) 2012年 Ryan Wang. All rights reserved.
//

#import "GAppDelegate.h"
#import "DVTSourceTextViewHook.h"

@implementation GAppDelegate
@synthesize textView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
//    NSString *path = @(__FILE__);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TestCases" ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [textView setString:string];
}

@end
