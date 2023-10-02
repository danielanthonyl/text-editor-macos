//
//  MainTextView.m
//  test
//
//  Created by daniel anthony on 01/10/2023.
//

#import "mainTextView.h"

@implementation MainTextView
- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    
    if(self){
        [self setSelectable:YES];
        [self setEditable:YES];
    }
    
    return self;
}

- (void)keyDown:(NSEvent *)event{
    NSString *keyPressed = [event characters];
    int keyCode = [event keyCode];
    int backspaceKeyCode = 51;
    int leftArrowKeyCode = 123;
    int rightArrowKeyCode = 124;
    BOOL wasShiftKeyPressed = [event modifierFlags] & NSEventModifierFlagShift;
    
    NSRange selectedRange = [self selectedRange];
    NSRange replacementRange = selectedRange;
    
    // delete function
    if(keyCode == backspaceKeyCode && selectedRange.length == 0 && selectedRange.location > 0) {
        NSRange deletionRange = NSMakeRange(selectedRange.location -1, 1);
        [self replaceCharactersInRange:deletionRange withString:@""];
        
        selectedRange.location -= 1;
        self.selectedRange = selectedRange;
        
        return;
    }
    
    // if shift was pressed
    if(wasShiftKeyPressed){
        if(keyCode == leftArrowKeyCode){
            if (selectedRange.location == 0) return;
            
            selectedRange.length ++;
            selectedRange.location --;
            self.selectedRange = selectedRange;
            
            return;
        }
        
        if(keyCode == rightArrowKeyCode){
            if(selectedRange.location + selectedRange.length < [[self string] length]){
                selectedRange.length++;
                self.selectedRange = selectedRange;
                return;
            }
            
            selectedRange.location++;
            self.selectedRange = selectedRange;
        }
        
        return;
    }
    
    // left-right controls
    if(keyCode == leftArrowKeyCode){
        if(selectedRange.length > 0){
            selectedRange.length = 0;
            self.selectedRange = selectedRange;
            
            return;
        }
        
        if (selectedRange.location == 0) return;
        
        selectedRange.location--;
        self.selectedRange = selectedRange;
        
        return;
    }
    
    if(keyCode == rightArrowKeyCode){
        if(selectedRange.length > 0){
            selectedRange.location += selectedRange.length;
            selectedRange.length = 0;
            self.selectedRange = selectedRange;
            return;
        }
        
        selectedRange.location++;
        self.selectedRange = selectedRange;
        return;
    }
    
    [self insertText:keyPressed replacementRange:replacementRange];

}

@end
