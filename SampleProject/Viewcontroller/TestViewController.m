//
//  TestViewController.m
//  SampleProject
//
//  Created by 60000737 on 2018. 8. 23..
//  Copyright © 2018년 sky. All rights reserved.
//

#import "TestViewController.h"
#import "UIMacro.h"

@interface TestViewController () <UIWebViewDelegate, UIScrollViewDelegate>
{
    CGFloat contentHeight;
    UIActivityIndicatorView* loadingIndicator;
}

@property (nonatomic, weak) IBOutlet UIWebView* webView;
@property (nonatomic, weak) IBOutlet UIButton* topButton;
@property (nonatomic, weak) IBOutlet UILabel* infoLabel;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"WebView";
    
    // Draw WebView
    NSURL* url = [[NSURL alloc] initWithString:@"https://www.naver.com"];
    NSURLRequest*  urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:urlRequest];
    if (@available(iOS 11.0, *))
    {
        [_webView.scrollView setContentOffset:CGPointMake(0, self.navigationController.navigationBar.frame.size.height)];
        [_webView.scrollView setFrame:CGRectMake(0, self.view.safeAreaLayoutGuide.layoutFrame.origin.y, _webView.frame.size.width, _webView.frame.size.height)];
    }
    else
    {
        [_webView.scrollView setContentOffset:CGPointMake(0, -_webView.scrollView.contentInset.top)];
        [_webView.scrollView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, _webView.frame.size.width, _webView.frame.size.height)];
    }
    
    _topButton.backgroundColor = [UIColor blackColor];
    _topButton.hidden = YES;
    _infoLabel.hidden = YES;

    _webView.scrollView.bounces = NO;
    _webView.scrollView.delegate  = self;
    
//    NSLog(@"%@",NSStringFromCGPoint(_webView.scrollView.contentOffset));
//    NSLog(@"Scroll.Y:%f", _webView.scrollView.contentOffset.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate Delegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    // Indicator
    loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingIndicator.backgroundColor = RGB(255, 0, 100);
    [loadingIndicator setCenter:(CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2))];
    [self.view addSubview:loadingIndicator];
    [loadingIndicator startAnimating];
    loadingIndicator.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [loadingIndicator stopAnimating];
    loadingIndicator.hidden = YES;
//    NSLog(@">>>>> web contents size (height) : %f", webView.scrollView.contentSize.height);
    contentHeight = webView.scrollView.contentSize.height;
}

#pragma mark - ScrollView Delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentY = scrollView.contentOffset.y;
//    NSLog(@"ScrollOffset.Y:%f", contentY);
    _infoLabel.text = [NSString stringWithFormat:@"%f",contentY];
    
    if(contentY >= 200)
    {
        _topButton.hidden = NO;
        _infoLabel.hidden = NO;
    }
    else if(contentY <= 200)
    {
        _topButton.hidden = YES;
        _infoLabel.hidden = YES;
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    //
//    NSLog(@"ScrollViewDidScrollToTop");
}

#pragma mark - button Event
-(IBAction)changeContentsOffset:(id)sender
{
//    NSLog(@">>>>> offset y : %f", _webView.scrollView.contentOffset.y);
//    NSLog(@"frame.height:%f",_webView.scrollView.frame.size.height);

    CGFloat newOffsetY = _webView.scrollView.contentOffset.y - _webView.scrollView.frame.size.height;
//    NSLog(@"remainder: %f", newOffsetY);
    
    if(_webView.scrollView.contentOffset.y >= _webView.scrollView.frame.size.height)
    {
        [_webView.scrollView setContentOffset:CGPointMake(0, newOffsetY)
                                     animated:YES];
    }
    
    else if(newOffsetY <= 200)
    {
        [_webView.scrollView setContentOffset:CGPointMake(0, -_webView.scrollView.contentInset.top)
                                         animated:YES];
    }
    else
    {
        //
    }
}
@end
