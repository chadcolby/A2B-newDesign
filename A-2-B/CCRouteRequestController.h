//
//  CCRouteRequestController.h
//  A-2-B
//
//  Created by Chad D Colby on 6/4/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CCRouteRequestController : NSObject

+ (CCRouteRequestController *)sharedRequestController;

- (void)requestRouteWithStart:(CLLocationCoordinate2D)start AndEnd:(CLLocationCoordinate2D)end;

@end
