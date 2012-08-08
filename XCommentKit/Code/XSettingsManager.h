//
//  XSettingsManager.h
//  VIXcode
//
//  Created by Ryan Wang on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *XSettingsManagerEnableNotification = @"XSettingsManagerEnableNotification";

@interface XSettingsManager : NSObject

+ (XSettingsManager *)sharedSettingsManager;

- (BOOL)isXCommentEnabled;
- (void)setXCommentEnabled:(BOOL)flag;

- (void)insertMenu;

@end
