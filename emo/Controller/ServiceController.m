//
//  ServiceController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "ServiceController.h"

@interface ServiceController ()

@end

@implementation ServiceController
@synthesize btntab1, btntab2, imgcont1, imgcont2, scrollView;

- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"서비스 주요 정책";
    lbltitle.font = [UIFont fontWithName:@"SBAggroB" size:18];
    lbltitle.textColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
    self.navigationItem.titleView = lbltitle;
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setFrame:CGRectMake(0, 0, 44, 44)];
    [leftbtn setImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(btnbackPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarbtn = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem =leftbarbtn;
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setFrame:CGRectMake(0, 0, 44, 44)];

    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
        
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    if ([self.stype isEqualToString:@"type2"]) {
        self.btntab1.selected = false;
        self.btntab2.selected = true;
        self.imgcont1.hidden = YES;
        self.imgcont2.hidden = NO;
        UIImage *img = [UIImage imageNamed:@"content_2"];
        float scale= img.size.width /self.view.frame.size.width;
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, img.size.height / scale)];
    } else {
        UIImage *img = [UIImage imageNamed:@"content_1.jpg"];
        float scale= img.size.width /self.view.frame.size.width;
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, img.size.height / scale)];
    }
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btntab1Press:(id)sender {
    self.btntab1.selected = true;
    self.btntab2.selected = false;
    UIImage *img = [UIImage imageNamed:@"content_1.jpg"];
    float scale= img.size.width /self.view.frame.size.width;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, img.size.height / scale)];
    self.imgcont1.hidden = NO;
    self.imgcont2.hidden = YES;
    
}

- (IBAction)btntab2Press:(id)sender {
    self.btntab1.selected = false;
    self.btntab2.selected = true;
    self.imgcont1.hidden = YES;
    self.imgcont2.hidden = NO;
    UIImage *img = [UIImage imageNamed:@"content_2"];
    float scale= img.size.width /self.view.frame.size.width;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, img.size.height / scale)];
}

@end
