//
//  NSString-RuntimeReporting.m
//  ClassTree
//
//  Created by John  C. Randolph on 7/22/04.
//  Copyright 2004-2009 John C. Randolph. All rights reserved.

#import "NSString-RuntimeReporting.h"
#import "RuntimeReporter.h"

@implementation NSString (RuntimeReporting)

- (BOOL) hasNoSubclasses { return ![self hasSubclasses]; }
- (BOOL) hasSubclasses { return [[RuntimeReporter subclassNamesForClassNamed:self] count] ? YES : NO; }
- (int) numberOfSubclasses { return [[RuntimeReporter subclassNamesForClassNamed:self] count]; }
- (NSArray *) subclassNames { return [RuntimeReporter subclassNamesForClassNamed: self]; }

- (NSArray *) methodNames // assumes the receiver contains a valid classname.
	{ 
	return 
		[[RuntimeReporter methodNamesForClassNamed:self]  
			sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	}

- (NSArray *) ivarNames // assumes the receiver contains a valid classname.
	{ 
	return 
		[[RuntimeReporter iVarNamesForClassNamed:self] 
		 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	}

- (NSArray *) propertyNames // assumes the receiver contains a valid classname.
	{ 
	return 
	[[RuntimeReporter propertyNamesForClassNamed:self]
	 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	}

- (NSArray *) protocolNames // assumes the receiver contains a valid classname.
	{ 
	return 
	[[RuntimeReporter protocolNamesForClassNamed:self] 
	 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	}

// KVC compliance stuff: This was needed for NSTreeController.  Not needed for the iPhone version.
//- (void) setSubclassNames:(NSArray *) names { NSLog(@"Can't set subclass names!"); }
//- (id) valueForUndefinedKey:(NSString *) key { return self; }
//- (void) setValue:(id)value forUndefinedKey:(NSString *)key { NSLog(@"unknown key:%@", key); }


@end
