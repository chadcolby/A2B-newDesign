//
//  CCDrawingViewController.h
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrawingViewDelegate <NSObject>

- (void)drawingEventDidEnd;
- (void)drawingEventCancelled;

@end

@interface CCDrawingViewController : UIViewController

@property (unsafe_unretained) id <DrawingViewDelegate> delegate;

@end
