
//
//  AddViewController.m
//  NesineTest
//
//  Created by koray gulturk on 3.08.2018.
//  Copyright © 2018 kogo. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)addAction:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"notifyForNewContoller"
     object:self.textField.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
