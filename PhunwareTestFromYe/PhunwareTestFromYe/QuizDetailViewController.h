//
//  QuizDetailViewController.h
//  PhunwareTestFromYe
//
//  Created by Yukui Ye on 8/30/13.
//  Copyright (c) 2013 Yukui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@end
