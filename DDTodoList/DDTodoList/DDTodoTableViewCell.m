//
//  DDTodoTableViewCell.m
//  DDTodoList
//
//  Created by Daniel Djurfelter on 03/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

#import "DDTodoTableViewCell.h"

@interface DDTodoTableViewCell()<UITextFieldDelegate>

@end

@implementation DDTodoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.textField.placeholder = NSLocalizedString(@"NewItem", nil);
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self notifyDelegate];
    return YES;
}

-(void)notifyDelegate {
    [self.cellDelegate tableViewCelldidFinishEditing:self];
}

@end
