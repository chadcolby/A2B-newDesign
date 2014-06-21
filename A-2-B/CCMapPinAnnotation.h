//
//  CCMapPinAnnotation.h
//  A-2-B
//
//  Created by Chad D Colby on 6/21/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CCMapPinAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *subTitle;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate AndAddress:(NSString *)addressString AndSubTitle:(NSString *)subTitleString;
+ (NSString *)reusableIdentifierForPinType:(NSString *)pinType;

@end
