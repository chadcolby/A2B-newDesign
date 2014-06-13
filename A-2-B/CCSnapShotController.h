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

@property (strong, nonatomic) MKMapSnapshotOptions *snapShotOptions;
@property (strong, nonatomic) UIViewController *callingVC;

+ (CCSnapShotController *)sharedSnapShotController;

- (void)sendMapView:(MKMapView *)currentMapView fromSender:(UIViewController *)sender;

@end
