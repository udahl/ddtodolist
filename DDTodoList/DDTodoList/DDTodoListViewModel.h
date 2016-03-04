//
//  DDTodoListViewModel.h
//  DDTodoList
//
//  Created by Daniel Djurfelter on 03/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

@class DDTodoItem;
#import <UIKit/UIKit.h>

@interface DDTodoListViewModel : NSObject <UITableViewDataSource>

-(NSIndexPath*)addItem:(DDTodoItem*)item;
-(void)removeItemAtIndex:(NSInteger)itemIndex;
-(void)updateItemAtIndex:(NSInteger)itemIndex withTitle:(NSString*)title;

@end
