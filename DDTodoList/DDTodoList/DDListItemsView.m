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

@interface DDListItemsView ()<UITableViewDelegate, DDTodoTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDTodoListViewModel *viewModel;

@end

@implementation DDListItemsView

-(void)viewDidLoad {
    [self setTitle:NSStringFromClass([self class])];
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
    [self registerForKeyboardEvents];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self unregisterForKeyboardEvents];
    [super viewWillDisappear:animated];
}

-(DDTodoListViewModel*)viewModel {
    if(!_viewModel) {
        _viewModel = [DDTodoListViewModel new];
    }
    
    return _viewModel;
}

- (IBAction)addItem:(id)sender {
    DDTodoItem *todo = [DDTodoItem new];
    NSIndexPath *indexPath = [self.viewModel addItem:todo];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
        DDTodoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.delegate = self;
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
    
    btn.backgroundColor = [UIColor greenColor];

    return @[btn];
}

#pragma mark - DDTodoTableViewCellDelegate

-(void)tableViewCelldidFinishEditing:(DDTodoTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.viewModel updateItemAtIndex:indexPath.row withTitle:cell.textField.text];
}

#pragma mark - Keyboard event handler

-(void)registerForKeyboardEvents {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)unregisterForKeyboardEvents {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self updateTableViewBottomInsets:keyboardSize.height];
}

-(void)keyboardWillHide {
    [self updateTableViewBottomInsets:.0];
}


-(void)updateTableViewBottomInsets:(CGFloat)inset {
    
    UIEdgeInsets contentInsets = self.tableView.contentInset;
    contentInsets.bottom = inset;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}


@end
