//
//  LocateInfoViewController.m
//  SampleProject
//
//  Created by 60000737 on 2018. 8. 8..
//  Copyright © 2018년 sky. All rights reserved.
//

#import "LocateInfoViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "UIMacro.h"

@interface LocateInfoViewController () <CLLocationManagerDelegate,MKMapViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, retain) IBOutlet MKMapView* mapView;
@property (nonatomic, retain) IBOutlet UIButton* showButton;

// Popupview
@property (nonatomic, retain) IBOutlet UIView* locatePopupView;
@property (nonatomic, retain) IBOutlet UILabel* latNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* longNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* latDetailLabel;
@property (nonatomic, retain) IBOutlet UILabel* longDetailLabel;


// constraints
@property (nonatomic, strong) IBOutlet NSLayoutConstraint* locatePopupViewTopConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint* locatePopupViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint* showButtonBottomConstraint;

@end

@implementation LocateInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // NavigationBar
    self.navigationItem.title = @"LocationInfo";
    
    _latNameLabel.text = @"위도";
    _longNameLabel.text = @"경도";
    
    // Location
    BOOL ret = [self checkLocationService];
    NSLog(@"checkLocationService: %d", ret);
    
    if(ret)
    {
        if(_locationManager == nil)
        {
            _locationManager = [[CLLocationManager alloc] init];
        }
        _locationManager.delegate = self;
        [_locationManager startUpdatingLocation];
        
        _latDetailLabel.text = [NSString stringWithFormat:@"(%lf)", _locationManager.location.coordinate.latitude];
        _longDetailLabel.text = [NSString stringWithFormat:@"(%lf)", _locationManager.location.coordinate.longitude];
        
    }
    else
    {
        //
    }
    
    // MKMapView
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    
    // init LocateView
    [self initLocateView];
    
    
    // Test UIResponde recognizer
    UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [tapRec setDelegate:self];
    [_mapView addGestureRecognizer:tapRec];
    
    UISwipeGestureRecognizer* swipeRec = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [swipeRec setDelegate:self];
    [_mapView addGestureRecognizer:swipeRec];
    
    UIPinchGestureRecognizer* pinchRec = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [pinchRec setDelegate:self];
    [_mapView addGestureRecognizer:pinchRec];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (BOOL)checkLocationService
{
    while (1)
    {
        if([CLLocationManager locationServicesEnabled])
        {
            if(!_locationManager)
            {
                _locationManager = [[CLLocationManager alloc] init];
            }
        }
        
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
        {
            // 아직 미선택
        }
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)
        {
            // 사용 제한
            return NO;
        }
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
        {
            // 허용 안함
            return NO;
        }
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)
        {
            // 항상 허용
            return YES;
        }
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
        {
            // 앱 사용하는 동안에만
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

#pragma mark - CLLocationManger Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *newLocation = locations.lastObject;
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    
    _latDetailLabel.text = [NSString stringWithFormat:@"(%lf)", coordinate.latitude];
    _longDetailLabel.text = [NSString stringWithFormat:@"(%lf)", coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"LocationMaanger didFailWithError");
}

#pragma mark - MKMapView Delegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    
    region.span = span;
    region.center = _locationManager.location.coordinate;
    
    [mapView setRegion:region animated:YES];
}

#pragma mark - Animation
-(void)initLocateView
{
    
    NSLog(@"%f", self.view.frame.size.height);
    NSLog(@"%f", _mapView.frame.size.height);
    NSLog(@"%f", _locatePopupViewTopConstraint.constant);
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [_locatePopupViewTopConstraint setConstant: - _locatePopupView.frame.size.height];
                         
                         _locatePopupView.hidden = NO;
                         _showButton.hidden = YES;
                         
                         [self.view layoutIfNeeded];
                         [self.view setNeedsLayout];
                         
                     }completion:^(BOOL finished) {
                         //
                         
                     }];
    
}

-(void)showLocateView
{
    
        [UIView animateWithDuration:1.0
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                            [_showButtonBottomConstraint setConstant:_locatePopupView.frame.size.height];
                             _locatePopupView.hidden =NO;
                             
                             [self.view layoutIfNeeded];
                             [self.view setNeedsLayout];
                             
                         }completion:^(BOOL finished) {
                             //
                             [UIView animateWithDuration:1.0
                                              animations:^{
                                                  
                                                   [_locatePopupViewTopConstraint setConstant: -_locatePopupView.frame.size.height];
                                                  
                                                  _showButton.hidden = YES;
                                                  
                                                  [self.view layoutIfNeeded];
                                                  [self.view setNeedsLayout];
                                                  
                                              }completion:nil];
                         }];
}

- (void)hideLocateView
{
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [_locatePopupViewTopConstraint setConstant: 0 + _locatePopupView.frame.size.height];
                         
                         [self.view layoutIfNeeded];
                         [self.view setNeedsLayout];
                         
                     }completion:^(BOOL finished) {
                         //
                         [UIView animateWithDuration:1.0
                                          animations:^{
                                              
                                              [self.view addSubview:_showButton];
                                              [_showButtonBottomConstraint setConstant:- 16];
                                              
                                              _showButton.hidden = NO;
                                              
                                              [self.view layoutIfNeeded];
                                              [self.view setNeedsLayout];
                         }completion:nil];
                         
                     }];
}

#pragma mark - Button Action
-(IBAction)buttonAction:(id)sender
{
    UIButton *btn = sender;
    
    if(btn.tag == 100)
    {
        [self hideLocateView];
    }
    if(btn.tag == 110)
    {
        [self showLocateView];
    }
}

#pragma mark - private method
-(void)tapRecognized: (UIGestureRecognizer* )sender
{
    NSLog(@"tapRecognized:");
    [self hideLocateView];

    CGPoint tapPoint = [sender locationInView:_mapView];
    CLLocationCoordinate2D coord = [_mapView convertPoint:tapPoint toCoordinateFromView:_mapView];
    NSUInteger numberOfTouches = [sender numberOfTouches];

    if(numberOfTouches == 1)
    {
        
        NSLog(@"Tap location %.0f,%.0f", tapPoint.x,tapPoint.y);
        NSLog(@"Longitude %f, Latitude %f", coord.longitude, coord.latitude);
    }
    else
    {
        NSLog(@"Number of touches was %d ,ignored",(int)numberOfTouches);
    }

    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] init];
    [doubleTap setNumberOfTapsRequired:2];
    [doubleTap setCancelsTouchesInView:NO];
    [_mapView addGestureRecognizer:doubleTap];

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [tapGesture requireGestureRecognizerToFail:doubleTap];
    [_mapView addGestureRecognizer:tapGesture];

    UIGestureRecognizer* builtInDoubleTap = nil;
    NSArray* gestureRecognizers = [_mapView gestureRecognizers];
    for(UIGestureRecognizer* recognizer in gestureRecognizers)
    {
        NSLog(@"recognizer:%@",recognizer);
        if([[recognizer class] isKindOfClass:[UITapGestureRecognizer class]])
        {
            if([(UITapGestureRecognizer *)recognizer numberOfTapsRequired] == 2)
            {
                NSLog(@"Found Double tap Recognizer : %@", recognizer);
                builtInDoubleTap = recognizer;
                break;
            }
        }
    }
}

@end
