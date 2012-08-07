//
//  NSPosition.m
//  VIXcode
//
//  Created by Ryan Wang on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSPosition.h"

NSString * NSStringFromPosition(NSPosition position) {
    return [NSString stringWithFormat:@"{row:%lu column:%lu}",position.row,position.column];
}
