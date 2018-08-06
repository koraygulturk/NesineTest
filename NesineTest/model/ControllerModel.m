//
//  ControllerModel.m
//  NesineTest
//
//  Created by koray gulturk on 4.08.2018.
//  Copyright © 2018 kogo. All rights reserved.
//

#import "ControllerModel.h"

@implementation ControllerModel

-(id) initWithName:(NSString*) aName withType:(int) aType; {
    self.viewName = aName;
    self.vType = aType;
    self.count = 0;
    
    return self;
}

@end
