//
//  DDTodoItem.h
//  DDTodoList
//
//  Created by Daniel Djurfelter on 03/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDTodoItem : NSObject

-(instancetype)initWithTitle:(NSString*)title;
@property (nonatomic, strong) NSString* title;

@end
