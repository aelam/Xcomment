//
//  MehodHook.h
//  VIXcode
//
//  Created by Ryan Wang on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <objc/objc-class.h>

void HookSelector(Class originClass,SEL originSEL,Class targetClass,SEL targetSEL,SEL oldSELKeeper);

void InjectProperty(Class originClass,SEL setter,SEL getter,Class fakeClass);
