//
//  CCSnapShotController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/12/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCSnapShotController.h"

@interface CCSnapShotController ()

@property (strong, nonatomic) MKMapSnapshotter *snapShotter;

@end

@implementation CCSnapShotController

- (id)initWithMapView:(MKMapView *)currentMapView
{
    self = [super init];
    
    if (self) {
        self.snapShotOptions = [[MKMapSnapshotOptions alloc] init];
        self.snapShotOptions.region = currentMapView.region;
        self.snapShotOptions.size = currentMapView.frame.size;
        self.snapShotOptions.scale = [[UIScreen mainScreen] scale];
        
        NSURL *snapShotFileURL = [NSURL fileURLWithPath:@"path/to/file.png"];
        
        self.snapShotter = [[MKMapSnapshotter alloc] initWithOptions:self.snapShotOptions];
        [self.snapShotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
            if (error) {
                NSLog(@"Snapshot Error: %@", error.description);
                return;
            }
            
            UIImage *snapShotImage = snapshot.image;
            NSData *snapShotData = UIImagePNGRepresentation(snapShotImage);
            [snapShotData writeToURL:snapShotFileURL atomically:YES];
            
        }];
    }
    return self;
}

@end
