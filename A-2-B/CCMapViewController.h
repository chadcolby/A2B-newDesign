//
//  CCMapViewController.h
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCRouteRequestController.h"

@interface CCMapViewController : UIViewController

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
