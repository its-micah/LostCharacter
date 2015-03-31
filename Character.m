//
//  Character.m
//  LostCharacters
//
//  Created by Micah Lanier on 3/31/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "Character.h"

@implementation Character


-(instancetype)initWithPassengerName: (NSString *)passenger withActorName:(NSString *)name withSeatNumber:(NSString *)seatNumber withGender:(BOOL)isMale {

    self = [super init];

    self.name = name;
    self.passenger = passenger;
    self.seatNumber = seatNumber;
    self.gender = &(isMale);

    return self;
}


@end
