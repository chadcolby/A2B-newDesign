//
//  CCDrawingView.h
//  A-2-B
//
//  Created by Chad D Colby on 6/4/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLine.h"
#import "CCFingerView.h"

@protocol DrawingEventDelegate <NSObject>

- (void)drawingEventFinishedWithLine:(CCLine *)finishedLine;

@optional

- (void)fingerViewCenterForCurrentLine:(CCLine *)currentLine;
- (void)routeRequestEnabled:(BOOL)enabled;

@end

@interface CCDrawingView : UIView

@property (unsafe_unretained) id <DrawingEventDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *completedLines;
@property (strong, nonatomic) NSMutableDictionary *linesInProgress;
@property (strong, nonatomic) CCFingerView *fingerView;

- (void) clearLines;
- (void) drawingDidEnd:(NSSet *)touches;

@end
