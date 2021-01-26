//
//  CalendarViewController.m
//  SampleProject
//
//  Created by 60000737 on 2018. 9. 20..
//  Copyright © 2018년 sky. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController () <EKEventViewDelegate, EKEventEditViewDelegate>

@property (nonatomic,retain) EKEventStore* eventStore;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    BOOL ret = [self checkAuthStatus];
    NSLog(@"checkauthStatus: %d", ret);
    
    if(ret)
    {
        if(_eventStore == nil)
        {
            _eventStore = [[EKEventStore alloc] init];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - calendar
-(BOOL) checkAuthStatus
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    while(1)
    {
        if(!_eventStore)
        {
            _eventStore = [[EKEventStore alloc] init];
        }
        [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError* error)
         {
             
         }];
        if(status == EKAuthorizationStatusNotDetermined)
        {
            // 미선택
        }
        if(status == EKAuthorizationStatusRestricted)
        {
            // iPhone 설정 > 사용자 정보보호에서 달력 접근 제한 시
            return NO;
        }
        if(status == EKAuthorizationStatusDenied)
        {
            // 접근 거부
            return NO;
        }
        if(status == EKAuthorizationStatusAuthorized)
        {
            // 접근 허용
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}

-(void)setCalendarEvent
{
    EKEvent* e = [EKEvent eventWithEventStore:_eventStore];
    e.title = @"Calendar";
    e.startDate = [NSDate date];
    e.calendar = [_eventStore defaultCalendarForNewEvents];

//    EKEventViewController* evController = [[EKEventViewController alloc] init];
//    evController.event = e;
//    
//    [self presentViewController:evController animated:YES completion:nil];
    
//    [_eventStore saveCalendar:<#(nonnull EKCalendar *)#> commit:<#(BOOL)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]
//    self.event
    
    //        e.calendar = [_eventStore defaultCalendarF.orNewReminders];
}
//-(NSArray *) getSuitableEventCalendars
//{
//    // get all calendars
//    NSArray* allCalendars = [_eventStore calendarsForEntityType:EKEntitiyTypeEvent];
//
//
//}
@end
