//
//  DDListItemsView.m
//  DDTodoList
//
//  Created by Daniel Djurfelter on 03/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

#import "DDListItemsView.h"
#import "DDTodoListViewModel.h"
#import "DDTodoItem.h"
#import "DDTodoTableViewCell.h"
#import "DDKeyboardEventHandler.h"

@interface DDListItemsView ()<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDTodoListViewModel *viewModel;
@property (strong, nonatomic) DDKeyboardEventHandler* keyboardHandler;

@end

@implementation DDListItemsView

-(void)viewDidLoad {
    [self setTitle:NSLocalizedString(@"ProductName", nil)];
    [self setupTableView];
}

-(void)setupTableView
{
    self.tableView.dataSource = self.viewModel;
    self.tableView.delegate = self;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    NSString *cellId = NSStringFromClass([DDTodoTableViewCell class]);
    
    [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil]
         forCellReuseIdentifier:cellId];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.keyboardHandler addKeyboardNotificationObserver];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.keyboardHandler removeKeyboardNotificationObserver];
    [super viewWillDisappear:animated];
}

#pragma mark - Properties

-(DDTodoListViewModel*)viewModel {
    if(!_viewModel) {
        _viewModel = [DDTodoListViewModel new];
    }
    
    return _viewModel;
}

-(DDKeyboardEventHandler*)keyboardHandler {
    if (!_keyboardHandler) {
        _keyboardHandler = [[DDKeyboardEventHandler alloc] initWithResponder:self.tableView];
    }
    
    return _keyboardHandler;
}

- (IBAction)addItem:(id)sender {
    DDTodoItem *todo = [DDTodoItem new];
    NSIndexPath *indexPath = [self.viewModel addItem:todo];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
        DDTodoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell.textField becomeFirstResponder];
    });
}

#pragma mark - UITableViewDelegate

-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView
               editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *btn = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                   title:NSLocalizedString(@"Done", @"")
                                                                 handler:^(UITableViewRowAction* action, NSIndexPath* indexPath) {
                                                                     [self.viewModel tableView:self.tableView
                                                                            commitEditingStyle:UITableViewCellEditingStyleDelete
                                                                             forRowAtIndexPath:indexPath];
                                                                 }];

    return @[btn];
}

@end
