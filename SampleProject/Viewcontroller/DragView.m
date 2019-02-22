//
//  DragView.m
//  SampleProject
//
//  Created by 60000737 on 2018. 9. 7..
//  Copyright © 2018년 sky. All rights reserved.
//

#import "DragView.h"
#import "DragViewController.h"
#import "UIMacro.h"

@implementation DragView
{
    CGPoint newLocation;
    CGPoint lastLocation;
}

- (void)drawRect:(CGRect)rect
{
    [self setFrame:rect];
    [super drawRect:rect];
    
    //Drawing code
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureEvent:)];
    [self addGestureRecognizer:longPress];
}

#pragma mark - gesture status
- (void) longPressGestureEvent:(UILongPressGestureRecognizer *) gestureRecognizer
{
    DragViewController* vc = [[DragViewController alloc] initWithNibName:@"DragViewController" bundle:nil];
    CGPoint point = [gestureRecognizer locationInView:nil];
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"start gesture Recognize:%@",NSStringFromCGPoint(point));
        for(UIView *dView in vc.view.subviews)
        {
            if(point.x > dView.frame.origin.x && point.x < dView.frame.origin.x + dView.frame.size.width &&
               point.y > dView.frame.origin.y && point.y < dView.frame.origin.y + dView.frame.size.width)
            {
                vc.view = dView;
                newLocation = CGPointMake(point.x- dView.frame.origin.x , point.y - dView.frame.origin.y);
                lastLocation = CGPointMake(dView.frame.origin.x,dView.frame.origin.y);
                [vc.view bringSubviewToFront:self];
            }
        }

    }
    if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"state change Recognize:%@",NSStringFromCGPoint(point));
        
        CGRect newDragFrame = CGRectMake(point.x - newLocation.x , point.y - newLocation.y , self.frame.size.width, self.frame.size.height);
        self.frame = newDragFrame;
        
    }
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"state ended Recognize:%@",NSStringFromCGPoint(point));
        if(point.y >= (vc.view.frame.size.height/3)*2)
        {
            CGPoint cPoint = CGPointMake(point.x, (vc.view.frame.size.height/3)*2);
            [self setFrame:CGRectMake(0,cPoint.y,self.frame.size.width,self.frame.size.height)];
        }
        if(point.y >= (vc.view.frame.size.height/3) && point.y <= (vc.view.frame.size.height/3)*2)
        {
            CGPoint cPoint = CGPointMake(point.x, (vc.view.frame.size.height/3));
            [self setFrame:CGRectMake(0,cPoint.y,self.frame.size.width,self.frame.size.height)];
        }
        if(point.y <= vc.view.frame.size.height/3)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"longPressGestureNoti" object:nil];
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        }

    }
  
}
@end

