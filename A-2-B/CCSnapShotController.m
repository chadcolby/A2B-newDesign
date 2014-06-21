//
//  CCSnapShotController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/12/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCSnapShotController.h"
#import <MessageUI/MessageUI.h>

@interface CCSnapShotController () <MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) MKMapSnapshotter *snapShotter;
@property (strong, nonatomic) MKMapSnapshotOptions *snapShotOptions;
@property (strong, nonatomic) UIViewController *sendingViewController;

@end

@implementation CCSnapShotController

+ (CCSnapShotController *)sharedSnapShotController
{
    static dispatch_once_t pred;
    static CCSnapShotController *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[CCSnapShotController alloc] init];
    });
    
    return shared;
    
}

- (void)sendMapView:(MKMapView *)currentMapView withRoute:(MKRoute *)requestedRoute andRequest:(MKDirectionsRequest *)dirRequest fromSender:(UIViewController *)sender WithAddress:(NSString *)address
{

    if (!self.snapShotOptions) {
        self.snapShotOptions = [[MKMapSnapshotOptions alloc] init];
    }
        self.snapShotOptions.region = currentMapView.region;
        self.snapShotOptions.size = currentMapView.frame.size;
        self.snapShotOptions.scale = [[UIScreen mainScreen] scale];
        
        self.sendingViewController = sender;
        self.snapShotter = [[MKMapSnapshotter alloc] initWithOptions:self.snapShotOptions];
        [self.snapShotter startWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
            if (error) {
                NSLog(@"Snapshot Error: %@", error.description);
                return;
            }
            UIGraphicsBeginImageContext(snapshot.image.size);
            CGRect imageRect = CGRectMake(0.0f, 0.0f, snapshot.image.size.width, snapshot.image.size.height);
            
            [snapshot.image drawInRect:imageRect];
            
            NSInteger firstIndexPoint = 0;
            NSInteger lastIndexPoint = 0;
            BOOL isFirstPoint = NO;
            
            NSMutableArray *pointsForDrawing = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < [requestedRoute.polyline pointCount]; i++) {
                MKMapPoint mapPoint = requestedRoute.polyline.points[i];
                CLLocationCoordinate2D coord = MKCoordinateForMapPoint(mapPoint);
                CGPoint snapshotPoint = [snapshot pointForCoordinate:coord];
                
                if (CGRectContainsPoint(imageRect, snapshotPoint)) {
                    [pointsForDrawing addObject:[NSValue valueWithCGPoint:snapshotPoint]];
                    lastIndexPoint = i;
                    if (i == 0) {
                        isFirstPoint = YES;
                    }
                    if (!isFirstPoint) {
                        isFirstPoint = YES;
                        firstIndexPoint = i;
                    }
                }
            }
            
            if (lastIndexPoint + 1 < requestedRoute.polyline.pointCount) {
                MKMapPoint point = requestedRoute.polyline.points[lastIndexPoint + 1];
                CLLocationCoordinate2D pointCoord = MKCoordinateForMapPoint(point);
                CGPoint pointInSnapshot = [snapshot pointForCoordinate:pointCoord];
                [pointsForDrawing addObject:[NSValue valueWithCGPoint:pointInSnapshot]];
            }
            
            if (firstIndexPoint != 0) {
                MKMapPoint point = requestedRoute.polyline.points[lastIndexPoint - 1];
                CLLocationCoordinate2D pointCoord = MKCoordinateForMapPoint(point);
                CGPoint pointForSnapshot = [snapshot pointForCoordinate:pointCoord];
                [pointsForDrawing addObject:[NSValue valueWithCGPoint:pointForSnapshot]];
            }
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 2.0f);
            
            for (NSValue *point in pointsForDrawing) {
                CGPoint pointToDraw = [point CGPointValue];
                if ([pointsForDrawing indexOfObject:point] == 0) {
                    CGContextMoveToPoint(context, pointToDraw.x, pointToDraw.y);
                } else {
                    CGContextAddLineToPoint(context, pointToDraw.x, pointToDraw.y);
                }
            }
            
            for (MKMapItem *item in @[dirRequest.source, dirRequest.destination]) {
                CGPoint annotationPoint = [snapshot pointForCoordinate:item.placemark.location.coordinate];
                if (CGRectContainsPoint(imageRect, annotationPoint)) {
                    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:nil];
                    pin.pinColor = [item isEqual:dirRequest.source] ? MKPinAnnotationColorGreen : MKPinAnnotationColorRed;
                    annotationPoint.x = annotationPoint.x + pin.centerOffset.x - (pin.bounds.size.width / 2);
                    annotationPoint.y = annotationPoint.y + pin.centerOffset.y - (pin.bounds.size.height / 2);
                    [pin.image drawAtPoint:annotationPoint];
                }
            }
            
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:185.f/255 green:61.f/255 blue:76.f/255 alpha:1.f].CGColor);
            CGContextStrokePath(context);
            
            UIImage *messageImage = UIGraphicsGetImageFromCurrentImageContext();
            NSData *attachmentData = UIImagePNGRepresentation(messageImage);
            [self sendMessageWithMapImage:attachmentData fromViewController:sender WithMessageBody:address];
            UIGraphicsEndImageContext();

        }];
    
}

- (void)sendMessageWithMapImage:(NSData *)mapdata fromViewController:(UIViewController *)sendingVC WithMessageBody:(NSString *)body
{
    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        messageComposeViewController.body = [NSString stringWithFormat:@"Heading to %@", body];
        messageComposeViewController.messageComposeDelegate = self;
        [messageComposeViewController addAttachmentData:mapdata typeIdentifier:@"public.data" filename:@"directions.png"];
        if (self.sendingViewController) {
            [sendingVC presentViewController:messageComposeViewController animated:YES completion:^{
            }];
        }
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Message sending failed" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Try Again", nil];
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"cancelled");
            break;
        case MessageComposeResultFailed:
            [failAlert show];
            break;
        case MessageComposeResultSent:
            NSLog(@"Success");
        default:
            break;
    }
    [self.sendingViewController dismissViewControllerAnimated:YES completion:^{
        self.sendingViewController = NULL;
    }];
}



@end
