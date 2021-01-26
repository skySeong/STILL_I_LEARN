//
//  AppInfoViewController.m
//  SampleProject
//
//  Created by 60000737 on 2018. 8. 8..
//  Copyright © 2018년 sky. All rights reserved.
//

#import "AppInfoViewController.h"
#import "UIMacro.h"

@interface AppInfoViewController () <UITableViewDelegate, UITableViewDataSource>
{
    
}
@property (retain,nonatomic) IBOutlet UITableView* appInfoTableView;
@end

@implementation AppInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // NavigationBar
    self.navigationItem.title = @"AppInfo";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",(int)_data.count);
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AppInfoCell";
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
    
    // DetaiTextlLabel
    NSString* appName = @"";
    NSString* appVersion = @"";
    NSString* minimumVersion = @"";
    NSString* bundleId = @"";
    
    // Draw label
    if([name isEqualToString:@"앱 이름"])
    {
        appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
        cell.detailTextLabel.text = appName;
    }
    else if([name isEqualToString:@"앱 버전"])
    {
        appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        cell.detailTextLabel.text = appVersion;
    }
    else if([name isEqualToString:@"최소지원 버전"])
    {
        minimumVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"MinimumOSVersion"];
        cell.detailTextLabel.text = minimumVersion;
    }
    else if([name isEqualToString:@"번들명"])
    {
        bundleId = [[NSBundle mainBundle] bundleIdentifier];
        cell.detailTextLabel.text = bundleId;
    }
    
    return cell;
}
@end
