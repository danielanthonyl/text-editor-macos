//
//  mac_window.m
//  test
//
//  Created by daniel anthony on 30/09/2023.
//

#import "macWindow.h"

@interface YourClassName : NSObject

// Declare the openFontDialog: method
- (void)openFontDialog:(id)sender;

@end

@implementation YourClassName

// Implement the openFontDialog: method
- (void)openFontDialog:(id)sender {
    NSFontManager *fontManager = [NSFontManager sharedFontManager];
    NSFontPanel *fontPanel = [fontManager fontPanel:YES];

    [fontPanel makeKeyAndOrderFront:nil];
}

@end


void createWindow(void) {
    NSApplication *app = [NSApplication sharedApplication];
    
    //  make window shows on top and typing priority works
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    
    NSRect rect = NSMakeRect(0, 0, 400, 400);
    NSWindow *window = [[NSWindow alloc] initWithContentRect:rect
                                                   styleMask:(NSWindowStyleMaskTitled |
                                                              NSWindowStyleMaskClosable |
                                                              NSWindowStyleMaskResizable)
                                                     backing:NSBackingStoreBuffered
                                                       defer:NO];
    
    [window setTitle:@"Text Editor"];
    [window makeKeyAndOrderFront:nil];
    
    // Add text view
    NSRect textRect = NSMakeRect(30, 30, 300, 300);
    MainTextView *textView = [[MainTextView alloc] initWithFrame:textRect];
    
    [[window contentView] addSubview:textView];
    
    NSMenu *menuBar = [NSMenu new];
    [app setMainMenu:menuBar];
    
    NSMenuItem *appMenuItem = [NSMenuItem new];
    NSMenu *appMenu = [NSMenu new];
    [appMenuItem setSubmenu:appMenu];
    [menuBar addItem:appMenuItem];
    
    NSMenuItem *quitMenuItem = [[NSMenuItem alloc] initWithTitle:@"Quit"
                                                          action:@selector(terminate:) keyEquivalent:@"q"];
    [appMenu addItem:quitMenuItem];
    
    
    // create menu item.
    NSMenuItem *editMenuItem = [NSMenuItem new];
    // add menu item to the item bar container.
    [menuBar addItem:editMenuItem];
    // create a menu container.
    NSMenu *editMenu = [NSMenu new];
    // add name to it.
    [editMenu setTitle:@"Edit"];
    // on the item a submenu that will hold sub items.
    [editMenuItem setSubmenu:editMenu];
    
    YourClassName *yourInstance = [[YourClassName alloc] init];
    // create a font item, it's an item of the edit menu container.
    NSMenuItem *fontMenuItem = [[NSMenuItem alloc] initWithTitle:@"Font" action:@selector(openFontDialog:) keyEquivalent:@""];
    [fontMenuItem setTarget:yourInstance];
    // add the item as an item to the edit menu container.
    [editMenu addItem:fontMenuItem];
    
    [app run];
}
