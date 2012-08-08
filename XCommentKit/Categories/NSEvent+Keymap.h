//
//  NSEvent+Keymap.h
//  VIXcode
//
//  Created by Ryan Wang on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


unichar ASCIIValueForEvent(NSEvent *event);

@interface NSEvent (Keymap)

- (unichar) ASCIIValue;

@end
