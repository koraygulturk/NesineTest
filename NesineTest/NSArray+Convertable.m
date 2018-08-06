//
//  NSArray+Convertable.m
//  NesineTest
//
//  Created by koray gulturk on 6.08.2018.
//  Copyright © 2018 kogo. All rights reserved.
//

#import "NSArray+Convertable.h"

@implementation NSArray (Convertable)
-(NSString *) converToJSON {
    NSLog(self);
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}
@end
