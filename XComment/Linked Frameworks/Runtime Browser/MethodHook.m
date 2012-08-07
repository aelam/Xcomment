//
//  MehodHook.m
//  VIXcode
//
//  Created by Ryan Wang on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MethodHook.h"


//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

void HookSelector(Class originClass,SEL originSEL,Class targetClass,SEL targetSEL,SEL oldSELKeeper) {
    Method origMethod = class_getInstanceMethod(originClass, originSEL);
    Method newMethod = class_getInstanceMethod(targetClass, targetSEL);
    
    IMP origImp_stret = class_getMethodImplementation_stret(originClass, originSEL);
    class_replaceMethod(originClass, originSEL, method_getImplementation(newMethod), method_getTypeEncoding(origMethod));
    
    class_addMethod(originClass, oldSELKeeper, origImp_stret, method_getTypeEncoding(origMethod));
    
}


void InjectProperty(Class originClass,SEL setter,SEL getter,Class fakeClass) {
    //    Method setterMethod = class_getInstanceMethod(fakeClass, setter);
    IMP setterIMP = class_getMethodImplementation(fakeClass, setter);
    class_addMethod(originClass,setter,setterIMP,@encode(void));
    
    //    Method getterMethod = class_getInstanceMethod(fakeClass,getter);
    IMP getterIMP = class_getMethodImplementation(fakeClass, getter);
    class_addMethod(originClass,getter,getterIMP,@encode(id));
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

