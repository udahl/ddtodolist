//
//  DDTodoTableViewCell.h
//  DDTodoList
//
//  Created by Daniel Djurfelter on 03/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

@class DDTodoTableViewCell;
#import <UIKit/UIKit.h>

@protocol DDTodoTableViewCellDelegate <NSObject>

-(void)tableViewCelldidFinishEditing:(DDTodoTableViewCell *)cell;

@end

@interface DDTodoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) id<DDTodoTableViewCellDelegate> cellDelegate;
@property (weak, nonatomic) NSIndexPath *indexPath;

@end
