//
//  NSString+charHelp.h
//  VIXcode
//
//  Created by Ryan Wang on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/* iskeyword=@,48-57,_,192-255 */
BOOL iskeyword (unichar c){
    return c == '@' || isalnum(c) || isalpha(c);
}

@interface NSString (charHelp)

@end
