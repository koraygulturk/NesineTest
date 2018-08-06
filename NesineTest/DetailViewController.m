//
//  DetailViewController.m
//  NesineTest
//
//  Created by koray gulturk on 4.08.2018.
//  Copyright © 2018 kogo. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController {
    UIView *containerView;
    UILabel *titleLabel;
    UILabel *descriptionLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"%@", self.viewName];
    
    containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    [containerView setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:containerView];
    
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // container view image constratint
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];
    
    [containerView addConstraints:@[height, width]];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100];
    
    [self.view addConstraints:@[centerX, top]];
    
    UIView *profileImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [profileImageView setBackgroundColor:[UIColor redColor]];
    [profileImageView.layer setCornerRadius:25];
    [profileImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [containerView addSubview:profileImageView];
    
    // profile image constratint
    NSLayoutConstraint *widthProfileImage = [NSLayoutConstraint constraintWithItem:profileImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    NSLayoutConstraint *heightProfileImage = [NSLayoutConstraint constraintWithItem:profileImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    
    [profileImageView addConstraints:@[heightProfileImage, widthProfileImage]];
    
    NSLayoutConstraint *centerProfileImageX = [NSLayoutConstraint constraintWithItem:profileImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *topProfileImage = [NSLayoutConstraint constraintWithItem:profileImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTop multiplier:1 constant:20];
    
    [containerView addConstraints:@[centerProfileImageX, topProfileImage]];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [containerView addSubview:titleLabel];
    
    NSLayoutConstraint *centerLabelX = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:profileImageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *topLabel = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:profileImageView attribute:NSLayoutAttributeTop multiplier:1 constant:60];
    
    NSLayoutConstraint *labelHeightConstraint = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30];
    NSLayoutConstraint *labelWidthConstraint = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
    
    [titleLabel addConstraints:@[labelHeightConstraint, labelWidthConstraint]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:[NSString stringWithFormat:@"Type %@", self.type]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [containerView addConstraints:@[centerLabelX, topLabel]];
    
    descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    [descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [containerView addSubview:descriptionLabel];
    
    NSLayoutConstraint *descriptionLabelCenterX = [NSLayoutConstraint constraintWithItem:descriptionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:profileImageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *topLabelDescription = [NSLayoutConstraint constraintWithItem:descriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:profileImageView attribute:NSLayoutAttributeTop multiplier:1 constant:80];
    
    NSLayoutConstraint *descriptionHeightConstraint = [NSLayoutConstraint constraintWithItem:descriptionLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30];
    NSLayoutConstraint *descriptionWidthConstraint = [NSLayoutConstraint constraintWithItem:descriptionLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
    
    [descriptionLabel addConstraints:@[descriptionHeightConstraint, descriptionWidthConstraint]];
    [descriptionLabel setTextColor:[UIColor whiteColor]];
    [descriptionLabel setFont:[UIFont systemFontOfSize:14]];
    [descriptionLabel setText:self.viewName];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [containerView addConstraints:@[descriptionLabelCenterX, topLabelDescription]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.type intValue] == 1) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"notifyFromDetail"
         object:_rowIndex];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
