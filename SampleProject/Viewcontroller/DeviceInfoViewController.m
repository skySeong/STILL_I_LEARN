//
//  DeviceInfoViewController.m
//  SampleProject
//
//  Created by 60000737 on 2018. 8. 8..
//  Copyright © 2018년 sky. All rights reserved.
//

#import "DeviceInfoViewController.h"
#import <sys/utsname.h>
// Mac Address
#import "MacAddress.h"
#import "AdSupport/ASIdentifierManager.h"
// 통신사 관련
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import "UIMacro.h"

struct utsname systemInfo;

@interface DeviceInfoViewController () <UITableViewDataSource>

@end

@implementation DeviceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // NavigationBar
    self.navigationItem.title = @"DeviceInfo";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",(int)_data.count);
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DeviceInfoCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
    }
    
    // Cell Customizing
    NSString* name = [NSString stringWithFormat:@"%@",[_data objectAtIndex:indexPath.row]];
    cell.textLabel.text = name;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = UIColor.blackColor;
    cell.detailTextLabel.text = @"";
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    _nameLabel.text = [NSString stringWithFormat:@"%@", _data];
    
    NSString* deviceName = @"";
    NSString* systemVersion = @"";
    NSString* deviceUUID = @"";
    NSString* model = @"";
    NSString* deviceTelecom = @"";
    NSString* macAddress = @"";
    
    // 배터리 정보
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    NSString* batteryLevel = [NSString stringWithFormat:@"%.0f%%", [UIDevice currentDevice].batteryLevel * 100.0f];
    // 통신사 정보
    CTTelephonyNetworkInfo* networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier* carrier = [networkInfo subscriberCellularProvider];
    
    if([name isEqualToString:@"디바이스 이름"])
    {
        deviceName = [UIDevice currentDevice].name;
        cell.detailTextLabel.text = deviceName;
    }
    else if([name isEqualToString:@"디바이스 OS버전"])
    {
        systemVersion = [UIDevice currentDevice].systemVersion;
        cell.detailTextLabel.text = systemVersion;
    }
    else if([name isEqualToString:@"디바이스 통신사"])
    {
        deviceTelecom = [NSString stringWithFormat:@"%@", [carrier carrierName]];
        cell.detailTextLabel.text = deviceTelecom;
    }
    else if([name isEqualToString:@"디바이스 UUID"])
    {
        deviceUUID =  [[[UIDevice currentDevice] identifierForVendor]UUIDString];
        cell.detailTextLabel.text = deviceUUID;
    }
    else if([name isEqualToString:@"디바이스 모델"])
    {
        model = [UIDevice currentDevice].model;
        cell.detailTextLabel.text = model;
    }
    else if([name isEqualToString:@"배터리 잔량"])
    {
        cell.detailTextLabel.text = batteryLevel;
    }
    else if([name isEqualToString:@"Mac 주소"])
    {
        char* macAddressString = (char *)malloc(18);
        macAddress = [[NSString alloc] initWithCString:getMacAddress(macAddressString, "en0") encoding:NSMacOSRomanStringEncoding];
        
        cell.detailTextLabel.text = macAddress;
    }
    
    return cell;
}
@end
