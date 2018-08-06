//
//  ViewController.m
//  NesineTest
//
//  Created by koray gulturk on 3.08.2018.
//  Copyright © 2018 kogo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ControllerModel.h"
#import "DetailViewController.h"
#import "NSMutableArray+Convertable.h"
#import "NSArray+Convertable.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSMutableArray *list;
    NSMutableDictionary *visitCounter;
    NSNumber *selectedRow;
    NSMutableDictionary *listDict;
    
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    
    
    if (![defaults boolForKey:@"opened"]) {
        
        NSManagedObject *first = [NSEntityDescription insertNewObjectForEntityForName:@"ControllerMO" inManagedObjectContext:context];
        [first setValue:[NSNumber numberWithInt:0] forKey:@"type"];
        [first setValue:[NSNumber numberWithInt:0] forKey:@"count"];
        [first setValue:@"First View Controller" forKey:@"viewName"];
        
        [appDelegate saveContext];
        
        NSManagedObject *second = [NSEntityDescription insertNewObjectForEntityForName:@"ControllerMO" inManagedObjectContext:context];
        [second setValue:[NSNumber numberWithInt:1] forKey:@"type"];
        [second setValue:[NSNumber numberWithInt:0] forKey:@"count"];
        [second setValue:@"Second View Controller" forKey:@"viewName"];
        
        [appDelegate saveContext];
    
        NSManagedObject *third= [NSEntityDescription insertNewObjectForEntityForName:@"ControllerMO" inManagedObjectContext:context];
        [third setValue:[NSNumber numberWithInt:2] forKey:@"type"];
        [third setValue:[NSNumber numberWithInt:0] forKey:@"count"];
        [third setValue:@"Third View Controller" forKey:@"viewName"];
        
        [appDelegate saveContext];
        
        [defaults setBool:YES forKey:@"opened"];
    }
    
    NSFetchRequest *requestExamLocation = [NSFetchRequest fetchRequestWithEntityName:@"ControllerMO"];
    list = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:requestExamLocation error:nil]];
//    
//    for (ControllerModel *mo in arr) {
//        [list addObject:mo];
//    }
//    
//    NSString *str = [self->list converToJSON];
//    
//    NSLog(str);
}

- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max {
    return min + arc4random_uniform((uint32_t)(max - min + 1));
}
- (void) receiveDetailNotification:(NSNotification *) notification {
    [self increaseVisitCount:notification.object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifyFromDetail" object:nil];
}

- (void) receiveNewControllerNotification:(NSNotification *) notification {
    [self addNewController:notification.object];
}

- (void) increaseVisitCount:(NSNumber *) selectedRow {
    NSNumber *count = [list valueForKey:@"count"][[selectedRow intValue]];
    NSInteger countInt = [count integerValue];
    
    countInt++;
    
    NSManagedObject* obj = [list objectAtIndex:[selectedRow intValue]];
    [obj setValue:[NSNumber numberWithInt:countInt] forKey:@"count"];
    
    [appDelegate saveContext];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void) addNewController:(NSString *) controllerName; {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifyForNewContoller" object:nil];
    
    NSInteger *rnd = [self randomNumberBetween:0 maxNumber:2];

    NSManagedObject *new= [NSEntityDescription insertNewObjectForEntityForName:@"ControllerMO" inManagedObjectContext:context];
    [new setValue:[NSNumber numberWithInt:rnd] forKey:@"type"];
    [new setValue:[NSNumber numberWithInt:0] forKey:@"count"];
    [new setValue:controllerName forKey:@"viewName"];
    
    [appDelegate saveContext];
    
    NSFetchRequest *requestExamLocation = [NSFetchRequest fetchRequestWithEntityName:@"ControllerMO"];
    list = [context executeFetchRequest:requestExamLocation error:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        
        DetailViewController *detailViewController = segue.destinationViewController;
        NSNumber *type = [list valueForKey:@"type"][[selectedRow intValue]];
        NSString *name = [list valueForKey:@"viewName"][[selectedRow intValue]];
        detailViewController.type = type;
        detailViewController.viewName = name;
        detailViewController.rowIndex = selectedRow;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDetailNotification:)
                                                     name:@"notifyFromDetail"
                                                   object:nil];
    }
    
    if ([segue.identifier isEqualToString:@"addNewControllerSegue"]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNewControllerNotification:)
                                                     name:@"notifyForNewContoller"
                                                   object:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    NSString *cellId = @"cell";
   
    NSNumber *count = [list valueForKey:@"count"][indexPath.row];
    NSString *name = [list valueForKey:@"viewName"][indexPath.row];
    NSString *cellTitle = [NSString stringWithFormat:@"%@ (%@)", name, count];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    [cell.textLabel setText:cellTitle];
    
    return cell;
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    
    NSNumber *type = [list valueForKey:@"type"][indexPath.row];
    selectedRow = [NSNumber numberWithInt:indexPath.row];
    
    if ([type integerValue] == 0) {
        [self increaseVisitCount:[NSNumber numberWithInt:indexPath.row]];
    }
    
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

@end
