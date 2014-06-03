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
#import "CCMenuView.h"

@interface CCMapViewController () <MKMapViewDelegate, DrawingViewDelegate>

@property (strong, nonatomic) NSOperationQueue *operationQueue;

@property (strong, nonatomic) CCDirectionsViewController *directionsVC;
@property (strong, nonatomic) CCDrawingViewController *drawingVC;
@property (strong, nonatomic) CCMenuView *menuView;

@property (nonatomic) CLLocationCoordinate2D userLocation;

@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) UITapGestureRecognizer *tapToClose;

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
    [self.view insertSubview:self.directionsVC.view belowSubview:self.view];

    [self.directionsVC didMoveToParentViewController:self];
    [self.view bringSubviewToFront:self.directionsVC.view];
}

- (void)drawingViewSetUp
{
    self.drawingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"drawingVC"];
    self.drawingVC.delegate = self;
    [self.drawingVC.view removeGestureRecognizer:self.longPress];
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

- (void)closeMenu:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height, self.view.bounds.size.width, 100);
        self.menuButton.alpha = 1.0f;
        self.currentLocationButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.tapToClose.enabled = NO;
        self.longPress.enabled = YES;
    }];
}

#pragma mark - IBActions

- (IBAction)menuButtonPressed:(id)sender
{
    NSLog(@"menu");
    if (!self.menuView) {
        self.menuView = [[CCMenuView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 100)];
        [self.menuView removeGestureRecognizer:self.longPress];
        [self.view addSubview:self.menuView];
        self.tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu:)];
        self.tapToClose.numberOfTapsRequired = 1;
        self.tapToClose.numberOfTouchesRequired = 1;
        [self.view addGestureRecognizer:self.tapToClose];
        
        [self.menuView.directionsButton addTarget:self action:@selector(showDirections:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuView.forwardButton addTarget:self action:@selector(sendMap:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuView.clearButton addTarget:self action:@selector(clearMapView:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuView.settingsButton addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];

    } else {
        self.tapToClose.enabled = YES;
    }
    [self showMenuViewAnimated:YES];
}

- (IBAction)currentLocationButtonPressed:(id)sender
{
    NSLog(@"current location");
}

#pragma mark - CCButtons actions

- (void)showMenuViewAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.4f animations:^{
            self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height - 100, self.view.bounds.
                                             size.width, 100);
            self.menuView.alpha = 0.8f;
            self.currentLocationButton.alpha = 0.5;
        } completion:^(BOOL finished) {
            self.menuButton.alpha = 0.0f;
            self.currentLocationButton.alpha = 0.0f;
        }];
        self.longPress.enabled = NO;
    }
}

- (void)showDirections:(CCButtons *)sender
{
    NSLog(@"dirs");
    if (!self.directionsVC) {
        [self directionsViewSetUp];
    } else {
        
    }

    [UIView animateWithDuration:0.4f animations:^{
        self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
        self.view.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - 272);
        
    } completion:^(BOOL finished) {
        self.longPress.enabled = NO;
        self.tapToClose.enabled = NO;
    }];

}

- (void)sendMap:(CCButtons *)sender
{
    NSLog(@"send");
}

- (void)clearMapView:(CCButtons *)sender
{
    NSLog(@"clear");
}

- (void)showSettings:(CCButtons *)sender
{
    NSLog(@"settings");
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
