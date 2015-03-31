//
//  Character.h
//  LostCharacters
//
//  Created by Micah Lanier on 3/31/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property NSString *name;
@property NSString *passenger;
@property BOOL *gender;
@property NSString *seatNumber;


-(instancetype)initWithPassengerName: (NSString *)passenger withActorName:(NSString *)name withSeatNumber:(NSString *)seatNumber withGender:(BOOL)isMale;


@end
