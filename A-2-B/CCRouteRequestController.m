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
            NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", endPlacemark.subThoroughfare, endPlacemark.thoroughfare, endPlacemark.locality, endPlacemark.administrativeArea, endPlacemark.postalCode];
            MKPlacemark *startPlacemark = [[MKPlacemark alloc] initWithCoordinate:start addressDictionary:nil];
            MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
            [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:endPlacemark]];
            [directionsRequest setSource:[[MKMapItem alloc] initWithPlacemark:startPlacemark]];
            directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
            
            MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (error) {
                    NSLog(@"ERROR: %@", error.description);
                } else
                {
                    NSMutableArray *routesArray = [[NSMutableArray alloc] initWithArray:response.routes];
                    NSMutableDictionary *routesInfo = [[NSMutableDictionary alloc] initWithCapacity:routesArray.count];
                    [routesInfo setObject:directionsRequest forKey:@"request"];
                    for (MKRoute *route in routesArray) {
                        NSString *timeString = [self formattedStringForDuration:route.expectedTravelTime];
                        double milesFromMeters = route.distance * 0.000621371;
                        NSString *distanceString = [NSString stringWithFormat:@"%.2f miles", milesFromMeters];
                        [routesInfo setObject:route forKey:@"returnedRoute"];
                        [routesInfo setObject:timeString forKey:@"estimatedTravelTime"];
                        [routesInfo setObject:distanceString forKey:@"totalDistance"];
                        [routesInfo setObject:addressString forKey:@"endAddressString"];
                        [routesInfo setObject:endLocation forKey:@"endLocationCoordinates"];
                        
                        [[CCDirDataSource sharedDataSource] reloadCollectionViewWithRoute:route];
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"routesReturned"object:self userInfo:routesInfo];

                }
            }];
            
        }
    }];
}

- (NSString*)formattedStringForDuration:(NSTimeInterval)duration
{
    NSInteger minutes = floor(duration/60);
    NSInteger seconds = round(duration - minutes * 60);
    return [NSString stringWithFormat:@"%ld:%02ld min.", (long)minutes, (long)seconds];
}
@end
