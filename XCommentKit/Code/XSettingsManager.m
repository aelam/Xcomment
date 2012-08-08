//
//  XSettingsManager.m
//  VIXcode
//
//  Created by Ryan Wang on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XSettingsManager.h"

#define XCODE_VIM_ENABLED @"XCODE_VIM_ENABLED21"

@interface XSettingsManager (Private)

- (void)_addVIMItemOnMainMenu;

@end

@implementation XSettingsManager


- (void)insertMenu {
    [self _setDefaultsValues];
    [self _addVIMItemOnMainMenu];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////


+ (XSettingsManager *)sharedSettingsManager {
    static XSettingsManager *menuManager = nil;
    if(menuManager == nil) {
        menuManager = [[XSettingsManager alloc] init];
    }
    return menuManager;
}

- (BOOL)isXCommentEnabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:XCODE_VIM_ENABLED];
}

- (void)setXCommentEnabled:(BOOL)flag {
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:flag] forKey:XCODE_VIM_ENABLED];
    [[NSUserDefaults standardUserDefaults] synchronize];    
}


- (void)_setDefaultsValues {
    
    id xcodeVIMEnabled = [[NSUserDefaults standardUserDefaults] objectForKey:XCODE_VIM_ENABLED];
    NIF_INFO(@"xcodeVIMEnabled %@",xcodeVIMEnabled);
    
    if(xcodeVIMEnabled == nil) {
        NIF_INFO(@"First time set ");
        [self setXCommentEnabled:YES];
    }
}

- (void)_addVIMItemOnMainMenu {
    

    NSMenuItem	*menuItem = [[[NSMenuItem alloc] init] autorelease];

    NSMenu *menu = [[[NSMenu alloc] init] autorelease];
    
    [menuItem setTitle:NSLocalizedString(@"XComment+",@"")];

    [menu setTitle: NSLocalizedString(@"XComment+",@"")];
    
    NSString *keyEquivalentString = @"v";
    
    NSMenuItem *enabledItem = [menu addItemWithTitle: NSLocalizedString(@"Enabled",@"")
                    action: @selector(vimEnableSwitchAction:) keyEquivalent:keyEquivalentString];
    [enabledItem setKeyEquivalentModifierMask:NSCommandKeyMask|NSAlternateKeyMask];
    [enabledItem setTitle:[self isXCommentEnabled]?@"Enabled":@"Disabled"];
    [enabledItem setTarget:self];
    

    [menuItem setSubmenu: menu];
    
    [menu setAutoenablesItems:NO];
    [menuItem setEnabled:YES];
    
    [menuItem setTarget:self];
    [[NSApp mainMenu] addItem: menuItem];
}

- (void)vimEnableSwitchAction:(NSMenuItem *)sender
{
    [self setXCommentEnabled:![self isXCommentEnabled]];
    [sender setTitle:[self isXCommentEnabled]?@"Enabled":@"Disabled"];
 
    [[NSNotificationCenter defaultCenter] postNotificationName:XSettingsManagerEnableNotification object:nil];
    
}

@end
