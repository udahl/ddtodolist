//
//  DDTodoItem.m
//  DDTodoList
//
//  Created by Daniel Djurfelter on 03/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

#import "DDTodoItem.h"

@implementation DDTodoItem

-(instancetype)initWithTitle:(NSString*)title {
    self = [super init];

    if(self) {
        self.title = title;
    }
    
    return self;
}

@end
