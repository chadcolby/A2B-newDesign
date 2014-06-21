//
//  CCMapPinAnnotation.m
//  A-2-B
//
//  Created by Chad D Colby on 6/21/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMapPinAnnotation.h"

@implementation CCMapPinAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subTitle = _subTitle;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate AndAddress:(NSString *)addressString AndSubTitle:(NSString *)subTitleString
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _title = subTitleString;
        _subTitle = subTitleString;
    }
    return self;
}


+ (NSString *)reusableIdentifierForPinType:(NSString *)pinType
{
    NSString *type = nil;
    
    if ([pinType isEqualToString:@"start"]) {
        type = @"startPin";
    } else if ([pinType isEqualToString:@"end"]) {
        type = @"endPin";
    }
    return type;
}
@end
