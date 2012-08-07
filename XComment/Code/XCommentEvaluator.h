//
//  XCommentEvaluator.h
//  XComment
//
//  Created by Ryan Wang on 12-8-7.
//  Copyright (c) 2012年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCommentEvaluator : NSObject

+ (XCommentEvaluator *)sharedEvaluator;

- (BOOL)handleCommentKeyEvent:(NSEvent *)event textView:(NSTextView *)textView;

@end
