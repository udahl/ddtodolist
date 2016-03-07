//
//  DDKeyboardEventHandler.m
//  DDTodoList
//
//  Created by Daniel Djurfelter on 07/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

#import "DDKeyboardEventHandler.h"

@interface DDKeyboardEventHandler()

@property (weak, nonatomic) UIScrollView* keyboardResponder;
@property (nonatomic) CGFloat initialBottomInset;

@end

@implementation DDKeyboardEventHandler

-(instancetype)initWithResponder:(UIScrollView*)responder {
    self = [super init];
    if (self) {
        self.keyboardResponder = responder;
        self.initialBottomInset = responder.contentInset.bottom;
    }
    return  self;
}

-(void)addKeyboardNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)removeKeyboardNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self updateTableViewBottomInsets:keyboardSize.height];
}

-(void)keyboardWillHide {
    [self updateTableViewBottomInsets:self.initialBottomInset];
}


-(void)updateTableViewBottomInsets:(CGFloat)inset {
    
    UIEdgeInsets contentInsets = self.keyboardResponder.contentInset;
    contentInsets.bottom = inset;
    self.keyboardResponder.contentInset = contentInsets;
    self.keyboardResponder.scrollIndicatorInsets = contentInsets;
}

@end
