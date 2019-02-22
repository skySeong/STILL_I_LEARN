//
//  DebugListViewController.m
//  SampleProject
//
//  Created by 60000737 on 2018. 8. 6..
//  Copyright © 2018년 sky. All rights reserved.
//

#import "DebugListViewController.h"

#import "AppInfoViewController.h"
#import "DeviceInfoViewController.h"
#import "LocateInfoViewController.h"
#import "TestViewController.h"
#import "DragViewController.h"
#import "CalendarViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UIMacro.h"

#define SECTION_HEIGHT  40.0

@interface DebugListViewController () <UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate>
{
//    NSArray* arDebugData;
    UIImagePickerController* pickerController;
}

@end

@implementation DebugListViewController
@synthesize arDebugData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // navigationBar
    self.navigationItem.title = @"List";
    
    // Data
    // 배열의 0 : Section Name
    // 배열의 1 : Row Value Array
    
    arDebugData = @[
                       // 1st Menu
                       @[
                           @{@"name" : @"앱 정보", @"controller" : @"AppInfoViewController",@"index":@"0",@"subtitle":@"Information about this Application"},
                           @[
                               @{@"name" : @"앱 이름",
                                 @"index" : @"0",
                                 @"subtitle" : @"Info about App Name"
                                 },
                               @{@"name" : @"앱 버전",
                                 @"index" : @"1",
                                 @"subtitle" : @"Info about App Version"
                                 },
                               @{@"name" : @"최소지원 버전",
                                 @"index" : @"2",
                                 @"subtitle" : @"Info about minimum version OS for App"
                                 },
                               @{@"name" : @"번들명",
                                 @"index" : @"3",
                                 @"subtitle" : @"Info about Bundle name"
                                 },
                            ]
                           ],
                       // 2st Menu
                       @[
                           @{@"name" : @"디바이스 정보", @"controller" : @"DeviceInfoViewController", @"index":@"1",@"subtitle":@"Information about this Application"},
                           @[
                               @{@"name" : @"디바이스 OS버전",
                                 @"index" : @"0",
                                 @"subtitle" : @"Info about device OS version"
                                 },
                               @{@"name" : @"디바이스 통신사",
                                 @"index" : @"1",
                                 @"subtitle" : @"Info about device telecom"
                                 },
                               @{@"name" : @"디바이스 UUID",
                                 @"index" : @"2",
                                 @"subtitle" : @"Info about unique device UUID"
                                 },
                               @{@"name" : @"디바이스 모델",
                                 @"index" : @"3",
                                 @"subtitle" : @"Info about device model"
                                 },
                               @{@"name" : @"배터리 잔량",
                                 @"index" : @"4",
                                 @"subtitle" : @"Info about battery power remains"
                                 },
                               @{@"name" : @"Mac 주소",
                                 @"index" : @"5",
                                 @"subtitle" : @"Info about Mac address"
                                 },
                               ]
                           ],
                       // 3rd Menu
                       @[
                           @{@"name" : @"위치 정보", @"controller" : @"LocateInfoViewController", @"index"                                                                                                                                          :@"2"},
                           @[
                               @{ @"name" : @"", @"index" : @"",@"subtitle":@""},
                            ]
                        ],
                       // 4th Menu
                       @[
                           @{@"name" : @"카메라", @"controller:":@"", @"index":@"3"},
                           @[
                               @{@"name" : @"", @"index" : @"",@"subtitle":@""},
                            ]
                           ],
                       // 5th Menu
                       @[
                           @{@"name" : @"샘플", @"controller:":@"", @"index":@"4"},
                           @[
                               @{@"name" : @"테스트1", @"index" : @"0",@"subtitle":@"ScrollView"},
                               @{@"name" : @"테스트2", @"index" : @"1",@"subtitle":@"Drag and Drop"},
                               @{@"name" : @"테스트3", @"index" : @"2",@"subtitle":@"Calendar"},
                               ]
                           ],
                       
                    ];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self; 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longPressGestureStart:) name:@"longPressGestureStart" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableViewDataSource
// MARK: UITableView > Section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            {
                return 1;
            }break;
        case 1:
        {
            return 1;
        }break;
        case 4:
        {
            return [arDebugData[section][1] count];
        }break;
        default:
        {
            return 0;
        }
            break;
    }
//    return [arDebugData[section][1] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arDebugData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *cellIdentifier = @"DebugDepth1Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *menuName = [arDebugData[section] objectAtIndex:0];
    
//    NSLog(@"arDepth1[section][name] : %@", [_arDebugArray[section] valueForKey:@"name"]);
//    NSLog(@"arDepth1[section][name] : %@", [menuName valueForKey:@"name"]);
    
    cell.textLabel.text = [menuName valueForKey:@"name"];
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
    cell.backgroundColor = RGBA(51.0,51.0,51.0,0.7f);
    
    // ButtonEvent
    CGRect sectionRect = CGRectMake(0, 0, tableView.frame.size.width, SECTION_HEIGHT);
    UIButton* sectionBtn = [[UIButton alloc] initWithFrame:sectionRect];
    
    switch (section) {
        case 0:
        {
            sectionBtn.tag = 0;
        }break;
        case 1:
        {
            sectionBtn.tag = 1;
        }break;
        case 2:
        {
            sectionBtn.tag = 2;
        }break;
        case 3:
        {
            sectionBtn.tag = 3;
        }break;
        case 4:
        {
            sectionBtn.tag = 4;
        }break;
        case 5:
        {
            
        }break;
        default:
            break;
    }
    [sectionBtn addTarget:self action:@selector(buttonActionEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:sectionBtn];
    
    return cell;
}

// MARK: UITableView > Row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"indexPath.section : %d", (int)indexPath.section);
//    NSLog(@"indexPath.row : %d", (int)indexPath.row);

    static NSString *cellIdentifier = @"DebugDepth2Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary* menuDic = [arDebugData[indexPath.section] objectAtIndex:1];
    NSDictionary* dic = [arDebugData[indexPath.section] objectAtIndex:0];
    // Menu
    NSArray *menuName = [menuDic valueForKey:@"name"];
    NSString *menuStr = [menuName objectAtIndex:indexPath.row];
    // Subtitle
    NSArray *subTitle = [menuDic valueForKey:@"subtitle"];
    NSString *subStr = [subTitle objectAtIndex:indexPath.row];

    
//    NSLog(@"menuName : %@", [menuDic valueForKey:@"subtitle"]);
//    NSLog(@"menuStr : %@", menuStr);
    
    cell.textLabel.text = menuStr;
    cell.detailTextLabel.text = subStr;
    
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.detailTextLabel.font = [UIFont italicSystemFontOfSize:16.0];
    cell.textLabel.textColor = UIColorFromHEX(0x555555);
    cell.detailTextLabel.textColor = UIColorFromHEX(0x777777);
    cell.backgroundColor = UIColor.clearColor;
    
    // AppInfoCell
    if(indexPath.section == 0)
    {
        cell.textLabel.text = [dic valueForKey:@"name"];
        cell.detailTextLabel.text = [dic valueForKey:@"subtitle"];
    }
    // DeviceInfoCell
    if(indexPath.section == 1)
    {
        cell.textLabel.text = [dic valueForKey:@"name"];
        cell.detailTextLabel.text = [dic valueForKey:@"subtitle"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    NSLog(@"SectionHeight");
    if(section == 0)
    {
        return 0;
    }
    else if(section == 1)
    {
        return 0;
    }
    else return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"RowHeight");
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"Section : %d / Row: %d ::::::selected and its data is %@", indexPath.section, indexPath.row, cell.textLabel.text);
    
    NSDictionary* menuInfo = [arDebugData[indexPath.section] objectAtIndex:0];
    NSDictionary* menuDic = [arDebugData[indexPath.section] objectAtIndex:1];
    
    NSArray* menuName = [menuDic valueForKey:@"name"];
    NSString* nameStr = [menuName objectAtIndex:indexPath.row];
    
    NSString* moveStr = [menuInfo valueForKey:@"index"];    //1st menu index
    
    NSArray* indexArr = [menuDic valueForKey:@"index"];
    NSString* indexStr = [indexArr objectAtIndex:indexPath.row];    //2nd menu index
    
//    NSLog(@"moveStr: %@", moveStr);
    
    if([moveStr isEqualToString:@"0"])
    {
        // 앱 정보
        AppInfoViewController* appInfoVC = [[AppInfoViewController alloc] initWithNibName:@"AppInfoViewController" bundle:nil];
        appInfoVC.data = menuName;
        
        [self.navigationController pushViewController:appInfoVC animated:YES];
    }
    else if([moveStr isEqualToString:@"1"])
    {
        // 디바이스 정보
        DeviceInfoViewController* deviceVC = [[DeviceInfoViewController alloc] initWithNibName:@"DeviceInfoViewController" bundle:nil];
        deviceVC.data = menuName;
        
        [self.navigationController pushViewController:deviceVC animated:YES];
    }
    else if([moveStr isEqualToString:@"4"])
    {
        if([indexStr isEqualToString:@"0"])
        {
            // 웹뷰
            TestViewController* testVC = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
            testVC.data = nameStr;
            
            [self.navigationController pushViewController:testVC animated:YES];
        }
        if([indexStr isEqualToString:@"1"])
        {
            // 드래그
            DragViewController* dragVC = [[DragViewController alloc] initWithNibName:@"DragViewController" bundle:nil];
            
            [self.navigationController pushViewController:dragVC animated:YES];
        }
        if([indexStr isEqualToString:@"2"])
        {
            // 캘린더
            CalendarViewController* calendarVC = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
            
            [self.navigationController pushViewController:calendarVC animated:YES];
        }
    }
    else
    {
        //
    }
}

#pragma mark - private method
-(void) buttonActionEvent:(UIButton *)sender
{
    NSLog(@"sender tag : %d",(int)sender.tag);
    switch ([sender tag])
    {
        // Location Info
        case 2:
        {
            // 위치 정보
            LocateInfoViewController* locateVC = [[LocateInfoViewController alloc] initWithNibName:@"LocateInfoViewController" bundle:nil];
            
            [self.navigationController   pushViewController:locateVC animated:YES];
        }break;
        case 3:
        {
            // 카메라
//            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
            
            UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;

            pickerController = [[UIImagePickerController alloc] init];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: pickerController.sourceType];
            imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            
            imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }break;
            
        default:
            break;
    }
}

#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    pickerController.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
