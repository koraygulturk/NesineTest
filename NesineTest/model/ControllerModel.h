//
//  ControllerModel.h
//  NesineTest
//
//  Created by koray gulturk on 4.08.2018.
//  Copyright © 2018 kogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControllerModel : NSObject

@property (assign) int *vType;
@property (assign) int *count;
@property (assign) NSString* viewName;

-(id) initWithName:(NSString *) aName withType:(int) aType;

@end
