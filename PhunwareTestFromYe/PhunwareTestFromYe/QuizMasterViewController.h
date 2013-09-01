//
//  QuizMasterViewController.h
//  PhunwareTestFromYe
//
//  Created by Yukui Ye on 8/30/13.
//  Copyright (c) 2013 Yukui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizDetailViewController;

@interface QuizMasterViewController : UITableViewController

@property (strong, nonatomic) QuizDetailViewController *detailViewController;

@property (strong,nonatomic) NSArray *dataInfor;
@property (strong,nonatomic) NSMutableData *loadData;

@end
