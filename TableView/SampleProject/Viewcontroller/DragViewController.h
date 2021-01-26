//
//  DragViewController.h
//  SampleProject
//
//  Created by 60000737 on 2018. 8. 28..
//  Copyright © 2018년 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView* testView;

@property (nonatomic, weak) IBOutlet UISwitch*  onOffSwitch;


//- (void) longPressGestureStart:(UILongPressGestureRecognizer *)gestureRecognizer;
- (IBAction)switchAction:(id)sender;

@end
