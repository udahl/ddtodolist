//
//  DDTodoListViewModel.m
//  DDTodoList
//
//  Created by Daniel Djurfelter on 03/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

#import "DDTodoListViewModel.h"
#import "DDTodoTableViewCell.h"
#import "DDTodoItem.h"

static NSString* DDTodoListViewModelStorageKey = @"DDTodoListItems.items";

@interface DDTodoListViewModel ()<DDTodoTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray<DDTodoItem*> *listItems;

@end

@implementation DDTodoListViewModel

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listItems.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DDTodoTableViewCell class])];
    [self configureCell:(DDTodoTableViewCell*)cell withItemAtIndexPath:indexPath];
    return cell;
}

-(void)configureCell:(DDTodoTableViewCell*)cell withItemAtIndexPath:(NSIndexPath*)indexPath {
    DDTodoItem *todo = [self.listItems objectAtIndex:indexPath.row];
    cell.cellDelegate  = self;
    cell.indexPath = indexPath;
    cell.textField.text = todo.title;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: {
            [self removeItemAtIndex:indexPath.row];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                      withRowAnimation:UITableViewRowAnimationLeft];
            });
        }
        default:
            break;
    }
}

#pragma mark - DDTodoTableViewCellDelegate

-(void)tableViewCelldidFinishEditing:(DDTodoTableViewCell *)cell
{
    [self updateItemAtIndex:cell.indexPath.row withTitle:cell.textField.text];
}

#pragma mark - Properties

-(NSMutableArray<DDTodoItem*>*)listItems
{
    if(!_listItems) {
        _listItems = [self loadListFromDatasource];
    }
    return _listItems;
}

-(NSMutableArray*)loadListFromDatasource
{
    NSArray *defaults = [[NSUserDefaults standardUserDefaults] arrayForKey:DDTodoListViewModelStorageKey];
    NSMutableArray *listItems = [NSMutableArray new];
    for (NSString* todo in defaults) {
        [listItems addObject:[[DDTodoItem alloc] initWithTitle:todo]];
    }
    return listItems;
}

-(void)syncronize {
    NSMutableArray *array = [NSMutableArray new];
    for(DDTodoItem* item in self.listItems) {
        [array addObject:(item.title ? item.title : @"")];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:array forKey:DDTodoListViewModelStorageKey];
    [defaults synchronize];
    
    NSLog(@"Saved todolist! %@", @(self.listItems.count));
}

#pragma mark - Public

-(NSIndexPath*)addItem:(DDTodoItem*)item {
    [self.listItems addObject:item];
    [self syncronize];
    return [NSIndexPath indexPathForRow:self.listItems.count-1 inSection:0];
}

-(void)removeItemAtIndex:(NSInteger)itemIndex {
    [self.listItems removeObjectAtIndex:itemIndex];
    [self syncronize];
}

-(void)updateItemAtIndex:(NSInteger)itemIndex withTitle:(NSString*)title {
    DDTodoItem *item = [self.listItems objectAtIndex:itemIndex];
    if (title && ![title isEqualToString:item.title]) {
        [self.listItems objectAtIndex:itemIndex].title = title;
        [self syncronize];
    }
}

@end
