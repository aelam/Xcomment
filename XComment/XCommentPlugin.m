//
//  XCommentPlugin.m
//  XComment
//
//  Created by Ryan Wang on 12-8-6.
//  Copyright (c) 2012年 Ryan Wang. All rights reserved.
//

#import "XCommentPlugin.h"
#import <XCommentKit/XCommentKit.h>

@implementation XCommentPlugin

+ (void)pluginDidLoad:(NSBundle *)plugin {
    //
    //
    //
    
    NSString *logPath = @"/Users/ryan/Desktop/VIXcode.log";
    [[NSFileManager defaultManager] removeItemAtPath:logPath error:nil];
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);

    NSString *privateFrameworksPath = [plugin privateFrameworksPath];
    NSString *commentFrameworkPath = [privateFrameworksPath stringByAppendingPathComponent:@"XCommentKit.framework"];
    NSBundle *realPluginBundle = [NSBundle bundleWithPath:commentFrameworkPath];
    [realPluginBundle load];

    Class XSettingsManagerClass = NSClassFromString(@"XSettingsManager");
    [[XSettingsManagerClass sharedSettingsManager] insertMenu];

    Class DVTSourceTextViewHookClass = NSClassFromString(@"DVTSourceTextViewHook");
    [DVTSourceTextViewHookClass hook];

    
}

@end
