//
//  ViewController.h
//  NesineTest
//
//  Created by koray gulturk on 3.08.2018.
//  Copyright © 2018 kogo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


-(void) increaseVisitCount: (NSNumber *) selectedRow;
-(void) addNewController:(NSString *) controllerName;
@end

