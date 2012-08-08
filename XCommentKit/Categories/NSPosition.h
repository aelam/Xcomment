//
//  NSPosition.h
//  VIXcode
//
//  Created by Ryan Wang on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 *
 * NSPoistion is used to record the position(row,column) of a charector or insertionPoint
 *  
 */

#import <Foundation/Foundation.h>

typedef struct _NSPosition {
    NSUInteger  row;
    NSUInteger  column;
}NSPosition;

typedef NSPosition *NSPositionPointer;

NS_INLINE NSPosition NSMakePosition(NSUInteger row, NSUInteger column) {
    NSPosition r;
    r.row = row;
    r.column = column;
    return r;
}

NS_INLINE BOOL NSEqualPosition(NSPosition p1, NSPosition p2) {
    return (p1.row == p2.row && p1.column == p2.column);
}

FOUNDATION_EXPORT NSString *NSStringFromPosition(NSPosition position);



