//
//  NSString-RuntimeReporting.h
//  Runtime Browser
//
//  Created by John  C. Randolph on 7/22/04.
//  Copyright 2004-2009 John C. Randolph. All rights reserved.
//

@interface NSString (RuntimeReporting)

- (BOOL) hasSubclasses;
- (NSArray *) subclassNames;
- (NSArray *) methodNames;
- (NSArray *) ivarNames;
- (NSArray *) propertyNames;
- (NSArray *) protocolNames;

@end