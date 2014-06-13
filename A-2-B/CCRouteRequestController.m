//
//  CCRouteRequestController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/4/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCRouteRequestController.h"
#import "CCDirDataSource.h"

@implementation CCRouteRequestController

+ (CCRouteRequestController *)sharedRequestController
{
    static dispatch_once_t pred;
    static CCRouteRequestController *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[CCRouteRequestController alloc] init];
    });
    
    return shared;
}

- (void)requestRouteWithStart:(CLLocationCoordinate2D)start AndEnd:(CLLocationCoordinate2D)end
{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:end.latitude
                                                         longitude:end.longitude];
    
    [geoCoder reverseGeocodeLocation:endLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.description);
        } else {
            MKPlacemark *endPlacemark = [[MKPlacemark alloc] initWithPlacemark:[placemarks lastObject]];
            MKPlacemark *startPlacemark = [[MKPlacemark alloc] initWithCoordinate:start addressDictionary:nil];
            MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
            [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:endPlacemark]];
            [directionsRequest setSource:[[MKMapItem alloc] initWithPlacemark:startPlacemark]];
            directionsRequest.transportType = MKDirectionsTransportTypeAny;
            
            MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (error) {
                    NSLog(@"ERROR: %@", error.description);
                } else
                {
                    NSMutableArray *routesArray = [[NSMutableArray alloc] initWithArray:response.routes];
                    NSMutableDictionary *routesInfo = [[NSMutableDictionary alloc] initWithCapacity:routesArray.count];
                    for (MKRoute *route in routesArray) {
                        [routesInfo setObject:route forKey:@"returnedRoute"];
                        [routesInfo setObject:[NSNumber numberWithDouble:route.expectedTravelTime] forKey:@"estimatedTravelTime"];
                        [routesInfo setObject:[NSNumber numberWithDouble:route.distance] forKey:@"totalDistance"];
                        
                        [[CCDirDataSource sharedDataSource] reloadCollectionViewWithRoute:route];
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"routesReturned" object:self userInfo:routesInfo];

                }
            }];
            
        }
    }];
}
@end
