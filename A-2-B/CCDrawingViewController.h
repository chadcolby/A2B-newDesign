//
//  CCDrawingViewController.h
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCDrawingView.h"

@protocol RouteRequestDelegate <NSObject>

- (void)requestRouteFromLine:(CCLine *)finishedLine;
- (void)drawingEventCancelled;

@end

@interface CCDrawingViewController : UIViewController

@property (unsafe_unretained) id <RouteRequestDelegate> delegate;

@end
