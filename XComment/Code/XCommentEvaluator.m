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
#import "RegexKitLite.h"

static int const kVirtualEnterKey = 36;
static int const kSpaceKey        = 32;
static int const kSlashKey        = 47;


static NSString *const kDoubleSlashPrefixParttern = @"^\\s+/{2}";

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
    
    NSRange selectedRange = [[[textView selectedRanges] objectAtIndex:0] rangeValue];
    
    NSRange currentLineRange = [textView currentLineRange];
    // 当前行首到 InsertPoint 的range
    NSRange searchRange = {currentLineRange.location, selectedRange.location - currentLineRange.location};
    
    NSString *searchString = [textView.string substringWithRange:searchRange];
    
    NSLog(@"%@",searchString);
    BOOL matchedDoubleSlash = [searchString isMatchedByRegex:kDoubleSlashPrefixParttern];
    NSLog(@"DoubleSlash : %d",matchedDoubleSlash);
    //    NSUInteger length = currentLineString.length;
    
    
    
//    NSMutableString *prefixSpaces = [NSMutableString string];
//
//    BOOL found = NO;
//    for (int i = 0; i < length; i ++) {
//        unichar c = [currentLineString characterAtIndex:i];
//        if(c == kSpaceKey) {
//            [prefixSpaces appendString:@" "];
//        } else if (c == kSlashKey){
//            if (i == length - 1) {
//                break;
//            } else {
//                unichar next = [currentLineString characterAtIndex:i+1];
//                if(next == kSlashKey) {
//                    found = YES;
//                    break;
//                }
//            }
//        } else {
//            break;
//        }
//        
//    }
    
//        NSLog(@"prefixSpaces [%@]", prefixSpaces);
//    NSLog(@"found // ? %d ",found);
    
    
    return YES;
    
    
//    NSLog(@"%@",currentLineString);
//    
//    
//    // Trim SPACE|TAB in the Begin
//    NSString *trimPrefix = [currentLineString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//
//    if (trimPrefix.length > 0) {
//        BOOL isCommentLine = [trimPrefix hasPrefix:@"//"];
//        if (isCommentLine) {
//            NSString *oldPrefix = [currentLineString substringToIndex:currentLineString.length - trimPrefix.length];
//            NSLog(@"origin : [%@]",currentLineString);
//            NSLog(@"trimPrefix : [%@]",trimPrefix);
//            NSLog(@"the prefix : [%@]",oldPrefix);
//            
//            NSString *insertText = [NSString stringWithFormat:@"\n%@//",oldPrefix?oldPrefix:@""];
//            NSLog(@"insertText : [%@]",insertText);
//            [textView insertText:insertText];
//            return YES;
//        }
//        
//    }
//    
    return NO;
}


@end
