//
//  DDKeyboardEventHandler.h
//  DDTodoList
//
//  Created by Daniel Djurfelter on 07/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DDKeyboardEventHandler : NSObject

-(instancetype)initWithResponder:(UIScrollView*)responder;
-(void)addKeyboardNotificationObserver;
-(void)removeKeyboardNotificationObserver;

@end
