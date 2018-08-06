//
//  AppDelegate.h
//  NesineTest
//
//  Created by koray gulturk on 3.08.2018.
//  Copyright © 2018 kogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end

