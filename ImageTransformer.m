//
//  ImageTransformer.m
//  LostCharacters
//
//  Created by Micah Lanier on 3/31/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageTransformer.h"

@implementation ImageTransformer

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    if (!value) {
        return nil;
    }

    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return UIImagePNGRepresentation(value);

}

- (id)reverseTransformedValue:(id)value {
    return [UIImage imageWithData:value];
}

@end
