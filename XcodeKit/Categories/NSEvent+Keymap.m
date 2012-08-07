//
//  NSEvent+Keymap.m
//  VIXcode
//
//  Created by Ryan Wang on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSEvent+Keymap.h"

unichar ASCIIValueForEvent(NSEvent *event) {
    unichar buf = 0;
    
    if (event.type != NSKeyDown && event.type != NSKeyUp) {
        return buf;
    }
    
    NSString *characters = [event characters];
    if (characters && [characters length]) {
        [[event characters] getCharacters:&buf range:NSMakeRange(0,[characters length])];        
    }
    
    return buf;
    

}


@implementation NSEvent (Keymap)

- (unichar) ASCIIValue{
    unichar buf = 0;
    
    if (self.type != NSKeyDown && self.type != NSKeyUp) {
        return buf;
    }
    
    NSString *characters = [self characters];
    if (characters && [characters length]) {
        [[self characters] getCharacters:&buf range:NSMakeRange(0,[characters length])];        
    }
    
    return buf;
    
}


@end
