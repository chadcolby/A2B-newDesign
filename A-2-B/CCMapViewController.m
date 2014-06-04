//
//  CCMapViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMapViewController.h"
#import "CCDrawingViewController.h"
#import "CCButtons.h"
#import "CCMenuView.h"
#import "CCHexCollectionView.h"
#import "CCRouteRequestController.h"

@interface CCMapViewController () <MKMapViewDelegate, RouteRequestDelegate>

@property (strong, nonatomic) CCDrawingViewController *drawingVC;
@property (strong, nonatomic) CCMenuView *menuView;
@property (strong, nonatomic) CCHexCollectionView *collectionView;

@property (nonatomic) CLLocationCoordinate2D userLocation;

@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) UITapGestureRecognizer *tapToClose;

@property (strong, nonatomic) MKRoute *routeForMap;

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
    self.collectionView = [[CCHexCollectionView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height,
                                                                                CGRectGetWidth(self.view.frame), 222)];
    self.collectionView.delegate = (id)self;
    [self.view addSubview:self.collectionView];
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
    if (!self.collectionView) {
        [self directionsViewSetUp];
    } else {
        
    }

    [UIView animateWithDuration:0.4f animations:^{
        self.menuView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height, self.view.bounds.size.width, 100);
        self.collectionView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height - 222, self.view.bounds.size.width, 222);        
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

- (void)requestRouteFromLine:(CCLine *)finishedLine
{
    if (finishedLine) {
        CLLocationCoordinate2D endCoord = [self.mapView convertPoint:finishedLine.endPoint toCoordinateFromView:self.mapView];
        [[CCRouteRequestController sharedRequestController] requestRouteWithStart:self.locationManager.location.coordinate AndEnd:endCoord];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMapViewWithRoutes:) name:@"routesReturned" object:nil];
    }
    
    self.menuButton.alpha = 1.0f;
    self.currentLocationButton.alpha = 1.0f;
    
}

- (void)updateMapViewWithRoutes:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"routesReturned"]) {
        NSLog(@"Routes %@", notification.userInfo);
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"routesReturned" object:nil];
        self.routeForMap = [notification.userInfo objectForKey:@"returnedRoute"];
        
        [self.mapView addOverlay:self.routeForMap.polyline];
    }
}

#pragma mark - MapView Delegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if (self.routeForMap != nil) {
        MKPolylineRenderer *routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:self.routeForMap.polyline];
        routeLineRenderer.strokeColor = [UIColor colorWithRed:185.f/255 green:61.f/255 blue:76.f/255 alpha:1.f];
        routeLineRenderer.lineWidth = 3;
        
        return routeLineRenderer;
    } else {
        return nil;
    }
}

@end
