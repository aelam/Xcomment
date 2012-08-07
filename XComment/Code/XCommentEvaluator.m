//
//  XCommentEvaluator.m
//  XComment
//
//  Created by Ryan Wang on 12-8-7.
//  Copyright (c) 2012年 Ryan Wang. All rights reserved.
//

#import "XCommentEvaluator.h"
#import "NSEvent+Keymap.h"
#import <XcodeKit/XcodeKit.h>

static int const kVirtualEnterKey = 36;
static int const kSpaceKey        = 32;
static int const kSlashKey        = 47;

@implementation XCommentEvaluator

+ (XCommentEvaluator *)sharedEvaluator {
    static XCommentEvaluator *evaluator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        evaluator = [[XCommentEvaluator alloc] init];
    });
    return evaluator;
}

- (BOOL)handleCommentKeyEvent:(NSEvent *)event textView:(NSTextView *)textView {
    
    NSLog(@"%@",event);
    NSLog(@"%d",'\n');
    if( event.keyCode != kVirtualEnterKey) {
        return NO;
    }
    
    NSRange currentLineRange = [textView currentLineRange];
    NSString *currentLineString = [textView.string substringWithRange:currentLineRange];
  
    if (currentLineString.length > 0) {
        
        NSScanner *scanner = [NSScanner scannerWithString:currentLineString];
        NSCharacterSet *commentCharSet = [NSCharacterSet characterSetWithCharactersInString:@"/*"];
//        [scanner scanCharactersFromSet:commentCharSet intoString:<#(NSString *__autoreleasing *)#>]
        [scanner setCharactersToBeSkipped:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    
    NSLog(@"%@",currentLineString);
    
    
    // Trim SPACE|TAB in the Begin
    NSString *trimPrefix = [currentLineString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (trimPrefix.length > 0) {
        BOOL isCommentLine = [trimPrefix hasPrefix:@"//"];
        if (isCommentLine) {
            NSString *oldPrefix = [currentLineString substringToIndex:currentLineString.length - trimPrefix.length];
            NSLog(@"origin : [%@]",currentLineString);
            NSLog(@"trimPrefix : [%@]",trimPrefix);
            NSLog(@"the prefix : [%@]",oldPrefix);
            
            NSString *insertText = [NSString stringWithFormat:@"\n%@//",oldPrefix?oldPrefix:@""];
            NSLog(@"insertText : [%@]",insertText);
            [textView insertText:insertText];
            return YES;
        }
        
    }
    
    return NO;
}


@end
