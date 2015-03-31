//
//  Character.m
//  LostCharacters
//
//  Created by Micah Lanier on 3/31/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "Character.h"

@implementation Character


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    self.name = dictionary[@"name"];
    self.passenger = dictionary[@"passenger"];
    //self.gender = di

    return self;
}


@end
