//
//  XCommentEvaluator.m
//  XComment
//
//  Created by Ryan Wang on 12-8-7.
//  Copyright (c) 2012年 Ryan Wang. All rights reserved.
//

#import "XCommentEvaluator.h"
#import "NSEvent+Keymap.h"
#import "NSTextView+Positions.h"
#import "RegexKitLite.h"
#import "NSString+charHelp.h"

static int const kVirtualEnterKey = 36;
static int const kSpaceKey        = 32;
static int const kSlashKey        = 47;


//static NSString *const kDoubleSlashPrefixParttern = @"^\\s{0,}/{2} {0,}|^((\\s{0,})[\\/]{0,})\\*[\\/]{0,}( {0,})";
//static NSString *const kDoubleSlashPrefixParttern = @"^((\\s{0,})[\\/]{0,})\\*[\\/]{0,}( {0,})|^((\\s{0,})[\\/]{0,})\\*( {0,})|^(\\s{0,})\\*[\\/]{0,}( {0,})";
static NSString *const kDoubleSlashPrefixParttern = @"^\\/{2}( {0,})|^\\/\\*( {0,})|^\\* {0,}\\/{0,}";

@implementation XCommentEvaluator

@synthesize selecedRange = _selecedRange;

+ (XCommentEvaluator *)sharedEvaluator {
    static XCommentEvaluator *evaluator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        evaluator = [[XCommentEvaluator alloc] init];
    });
    return evaluator;
}

- (BOOL)handleCommentKeyEvent:(NSEvent *)event textView:(NSTextView *)textView {
    
    if( event.keyCode != kVirtualEnterKey) {
        return NO;
    }
    
    NSRange selectedRange = [[[textView selectedRanges] objectAtIndex:0] rangeValue];
    
    NSRange currentLineRange = [textView currentLineRange];
    // 当前行首到 InsertPoint 的range
    NSRange searchRange = {currentLineRange.location, selectedRange.location - currentLineRange.location};
    
    NSString *searchString = [textView.string substringWithRange:searchRange];
    NSString *prefixSpaces = nil;
    
    NSString *trimedSpacesString = [searchString stringByTrimmingPrefixSpaces:&prefixSpaces];

    if (trimedSpacesString.length == 0) {
        return NO;
    }
    
    unichar firstUnspaceChar = [trimedSpacesString characterAtIndex:0];
       
    if(firstUnspaceChar != '/' && firstUnspaceChar != '*') {
        return NO;
    }

    NSString *matchedDoubleSlash = [trimedSpacesString stringByMatching:kDoubleSlashPrefixParttern];

    if(matchedDoubleSlash.length < 1) {
        return NO;
    }
//
//    NSLog(@"trimedSpacesString %@",trimedSpacesString);
//
//    NSLog(@"matchedDoubleSlash %@",matchedDoubleSlash);
    
    NSString *newString = matchedDoubleSlash;

    if ([matchedDoubleSlash rangeOfString:@"//"].length) {
    } else if ([matchedDoubleSlash rangeOfString:@"/*"].length) {
        NSLog(@"matchedDoubleSlash,%@",matchedDoubleSlash);

        NSRange searchedRange = [matchedDoubleSlash rangeOfString:@"/*"];
        
        if (searchedRange.location + searchedRange.length <= trimedSpacesString.length) {
            NSRange isCoupledRange = [trimedSpacesString rangeOfString:@"*/" options:0 range:NSMakeRange(searchedRange.location + searchedRange.length,trimedSpacesString.length - (searchedRange.location + searchedRange.length))];
            if (isCoupledRange.length) {
                return NO;
            }
        }
        newString = [matchedDoubleSlash stringByReplacingOccurrencesOfString:@"/*" withString:@" *" options:0 range:searchedRange];
    } else if ([trimedSpacesString rangeOfString:@"*/"].length) {
        return NO;
    } else {
        
    }

    if (trimedSpacesString && [trimedSpacesString length]) {
        [textView insertNewline:nil];
        [textView deleteToBeginningOfLine:nil];
        [textView insertText:[NSString stringWithFormat:@"%@%@",prefixSpaces,newString]];
        return YES;
    }
    
    return NO;

#if 0
    NSString *matchedDoubleSlash = [searchString stringByMatching:kDoubleSlashPrefixParttern];
    NSLog(@"searchString : [%@] ",searchString);
    NSLog(@"matchedDoubleSlash : [%@]",matchedDoubleSlash);
    NSString *newString = matchedDoubleSlash;
    if ([matchedDoubleSlash rangeOfString:@"//"].length) {
        
    } else if ([matchedDoubleSlash rangeOfString:@"/*"].length) {
        NSRange searchedRange = [matchedDoubleSlash rangeOfString:@"/*"];
        if (searchedRange.location + searchedRange.length + 2 < searchString.length) {
            NSRange isCoupledRange = [searchString rangeOfString:@"*/" options:0 range:NSMakeRange(searchedRange.location + searchedRange.length,searchString.length - (searchedRange.location + searchedRange.length))];
            if (isCoupledRange.length) {
                return NO;
            }
        }
        
        newString = [matchedDoubleSlash stringByReplacingOccurrencesOfString:@"/*" withString:@" *" options:0 range:searchedRange];
    } else if ([matchedDoubleSlash rangeOfString:@"*/"].length) {
        NSRange searchedRange = [matchedDoubleSlash rangeOfString:@"*/"];

        newString = [matchedDoubleSlash stringByReplacingOccurrencesOfString:@"*/" withString:@"*" options:0 range:searchedRange];
    } else {

    }
    
    if (matchedDoubleSlash && [matchedDoubleSlash length]) {
        [textView insertNewline:nil];
        [textView deleteToBeginningOfLine:nil];
        [textView insertText:[NSString stringWithFormat:@"%@",newString]];
        return YES;
    }

    return NO;
#endif
    
    
}

@end
