//
//  CCSnapShotController.h
//  A-2-B
//
//  Created by Chad D Colby on 6/12/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CCSnapShotController : NSObject

+ (CCSnapShotController *)sharedSnapShotController;

- (void)sendMapView:(MKMapView *)currentMapView withRoute:(MKRoute *)requestedRoute andRequest:(MKDirectionsRequest *)dirRequest fromSender:(UIViewController *)sender WithAddress:(NSString *)address;

@end
