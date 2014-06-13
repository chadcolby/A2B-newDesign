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

- (void)sendMapView:(MKMapView *)currentMapView fromSender:(UIViewController *)sender
{
    if (!self.snapShotOptions) {
        NSLog(@"self");
        self.snapShotOptions = [[MKMapSnapshotOptions alloc] init];
    }
        self.snapShotOptions.region = currentMapView.region;
        self.snapShotOptions.size = currentMapView.frame.size;
        self.snapShotOptions.scale = [[UIScreen mainScreen] scale];
        
        self.sendingViewController = sender;
        
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
            [self sendMessageWithMapImage:snapShotImage fromViewController:nil];
            
        }];
}

- (void)sendMessageWithMapImage:(UIImage *)mapImage fromViewController:(UIViewController *)sendingVC
{
    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        messageComposeViewController.body = @"Here are some directions...";
        messageComposeViewController.messageComposeDelegate = self;
        if (self.sendingViewController) {
            [sendingVC presentViewController:messageComposeViewController animated:YES completion:^{
                
            }];
        }
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSLog(@"called");
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
        
    }];
}

@end
