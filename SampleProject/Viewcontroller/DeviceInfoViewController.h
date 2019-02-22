//
//  DeviceInfoViewController.h
//  SampleProject
//
//  Created by 60000737 on 2018. 8. 8..
//  Copyright © 2018년 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceInfoViewController : UIViewController

@property (nonatomic, retain) NSArray* data;

@property (retain,nonatomic) IBOutlet UILabel* nameLabel;
@property (retain,nonatomic) IBOutlet UILabel* detailLabel;

@end
