//
//  CCDirecitonsListViewController.h
//  A-2-B
//
//  Created by Chad D Colby on 6/20/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCDirectionsView.h"

@protocol DirectionsViewDelegate <NSObject>

- (void)directionsViewClosed;

@end

@interface CCDirecitonsListViewController : UIViewController

@property (unsafe_unretained) id <DirectionsViewDelegate> delegate;
@property (strong, nonatomic) CCDirectionsView *directionCollectionView;

- (void)showDirections;

@end
