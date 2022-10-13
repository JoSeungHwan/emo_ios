//
//  FindIDController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "FindIDController.h"

@interface FindIDController ()
    
@end

@implementation FindIDController
@synthesize txtphone, txtemail, btnsend, btntab2, btntab1, btnsend1, viewid, viewpwd;

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"계정정보 찾기";
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
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btntab1Press:(id)sender {
    self.btntab1.selected = true;
    self.btntab2.selected = false;
    
    self.viewid.hidden = NO;
    self.viewpwd.hidden = YES;
}

- (IBAction)btntab2Press:(id)sender {
    self.btntab2.selected = true;
    self.btntab1.selected = false;
    
    self.viewpwd.hidden = NO;
    self.viewid.hidden = YES;
}

- (IBAction)btnsendPress:(id)sender {
    if ([self.txtphone.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"핸드폰번호를 입력하세요."];
    } else {
        NSDictionary *resultdict = [ApiHandler findid:self.txtphone.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            
        } else {
            [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
        }
    }
}

- (IBAction)btnsend1Press:(id)sender {
    if ([self.txtemail.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"이메일주소를 입력하세요."];
    } else {
        NSDictionary *resultdict = [ApiHandler findpwd:self.txtemail.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            
        } else {
            [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
        }
    }
}

@end
