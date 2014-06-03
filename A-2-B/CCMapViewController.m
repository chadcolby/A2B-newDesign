//
//  CCMapViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMapViewController.h"
#import "CCDirectionsViewController.h"
#import "CCDrawingViewController.h"
#import "CCButtons.h"

@interface CCMapViewController () <MKMapViewDelegate, DrawingViewDelegate>

@property (strong, nonatomic) NSOperationQueue *operationQueue;

@property (strong, nonatomic) CCDirectionsViewController *directionsVC;
@property (strong, nonatomic) CCDrawingViewController *drawingVC;

@property (nonatomic) CLLocationCoordinate2D userLocation;

@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;

@property (weak, nonatomic) IBOutlet CCButtons *menuButton;
- (IBAction)menuButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet CCButtons *currentLocationButton;
- (IBAction)currentLocationButtonPressed:(id)sender;

@end

@interface CCMapViewController ()

@end

@implementation CCMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self mapViewInitialSetUp];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.directionsVC) {
        [self.operationQueue addOperationWithBlock:^{
            [self directionsViewSetUp];
        }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - set up methods

- (void)mapViewInitialSetUp
{
    if (!self.mapView) {
        self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        self.mapView.delegate = self;
        self.mapView.showsUserLocation = YES;
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.mapView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addSubview:self.mapView];
        [self.view bringSubviewToFront:self.currentLocationButton];
        [self.view bringSubviewToFront:self.menuButton];
        self.operationQueue = [[NSOperationQueue alloc] init];
        
        if ([CLLocationManager locationServicesEnabled]) {
            if (!self.locationManager) {
                self.locationManager = [[CLLocationManager alloc] init];
                [self.locationManager startUpdatingLocation];
                MKCoordinateRegion mapRegion;
                mapRegion.center.latitude = self.locationManager.location.coordinate.latitude;
                mapRegion.center.longitude = self.locationManager.location.coordinate.longitude;
                MKCoordinateSpan  mapSpan = MKCoordinateSpanMake(0.1, 0.1);
                mapRegion.span = mapSpan;
                [self.mapView setRegion:mapRegion];
                [self.locationManager stopUpdatingLocation];
            }
        }
        self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
        self.longPress.allowableMovement = 10.0f;
        self.longPress.numberOfTouchesRequired = 1;
        self.longPress.minimumPressDuration = 0.8f;
        [self.mapView addGestureRecognizer:self.longPress];
    }
    
}


- (void)directionsViewSetUp
{
    self.directionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"directionsVC"];
    [self addChildViewController:self.directionsVC];
    self.directionsVC.view.frame = self.mapView.frame;
    [self.view insertSubview:self.directionsVC.view belowSubview:self.mapView];
    [self.directionsVC didMoveToParentViewController:self];

}

- (void)drawingViewSetUp
{
    self.drawingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"drawingVC"];
    self.drawingVC.delegate = self;
    [self addChildViewController:self.drawingVC];
    self.drawingVC.view.frame = self.mapView.frame;
    [self.view addSubview:self.drawingVC.view];
    [self.drawingVC didMoveToParentViewController:self];
}

#pragma mark - gesture recognizers

- (void)longPressDetected:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (!self.drawingVC) {
            [self drawingViewSetUp];
        } else {
            self.drawingVC.view.hidden = NO;
        }
        self.menuButton.alpha = 0.0f;
        self.currentLocationButton.alpha = 0.0f;
    }
}

#pragma mark - IBActions

- (IBAction)menuButtonPressed:(id)sender
{
    NSLog(@"menu");
}

- (IBAction)currentLocationButtonPressed:(id)sender
{
    NSLog(@"current location");
}

#pragma mark - DrawingViewDelegate

- (void)drawingEventCancelled
{
    [UIView animateWithDuration:0.4 animations:^{
        self.menuButton.alpha = 1.0f;
        self.currentLocationButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)drawingEventDidEnd
{
    
}
@end
