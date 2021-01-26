//
//  DragViewController.m
//  SampleProject
//
//  Created by 60000737 on 2018. 8. 28..
//  Copyright © 2018년 sky. All rights reserved.
//

#import "DragViewController.h"
#import "DragView.h"
#import "UIMacro.h"

@interface DragViewController () <UIGestureRecognizerDelegate>
{
    CGPoint lastLocation;
    CGPoint newLocation;
    DragView* dragView;
}

@property (nonatomic, weak) IBOutlet NSLayoutConstraint* switchBtnTopConstraint;


@end

@implementation DragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Drag";
    
    dragView = [[DragView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height/3)*2 , self.view.frame.size.width , self.view.frame.size.height/3)];
    dragView.translatesAutoresizingMaskIntoConstraints = NO;
    [dragView setBackgroundColor:UIColorFromHEX(0xF281FF)];
    [self.view addSubview:dragView];
    
    NSLayoutConstraint* dragViewConstraint = [NSLayoutConstraint constraintWithItem:dragView
                                                                          attribute:NSLayoutAttributeCenterY
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeCenterY
                                                                         multiplier:1.f
                                                                           constant:(self.view.frame.size.height/3)*2];
    [dragView addConstraint:dragViewConstraint];
    
    dragView.hidden = NO;
    
    // 11.0 이하, Switch Button Draw
   if (@available(iOS 11.0, *))
   {
       //
   }
    else
    {
        [_switchBtnTopConstraint setConstant:_onOffSwitch.frame.origin.y +self.navigationController.navigationBar.frame.size.height];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISwitch Action
- (IBAction)switchAction:(id)sender
{
    _onOffSwitch = sender;
    
    if(_onOffSwitch.on)
    {
        dragView.hidden = NO;
    }
    else
    {
        dragView.hidden = YES;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"gestureRecognizer shouldReceiveTouch: tapCount:%d",(int)touch.tapCount);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press
{
    return YES;
}

@end
