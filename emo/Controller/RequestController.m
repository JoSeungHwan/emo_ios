//
//  RequestController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "RequestController.h"

@interface RequestController ()

@end

@implementation RequestController
@synthesize btnsend, txtview, viewcont;

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"오류 및 건의사항";
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
    
    self.viewcont.layer.cornerRadius = 10;
    self.viewcont.layer.borderColor = [[UIColor colorWithRed:(232.0/255.0f) green:(232.0/255.0f) blue:(232.0/255.0f) alpha:1] CGColor];
    self.viewcont.layer.borderWidth = 1;
    self.viewcont.layer.shadowColor = [[UIColor colorWithRed:(242.0/255.0f) green:(242.0/255.0f) blue:(242.0/255.0f) alpha:1] CGColor];
    self.viewcont.layer.shadowOffset = CGSizeMake(10, 10);
    self.viewcont.layer.shadowRadius = 10;
    self.viewcont.layer.shadowOpacity = 0.5;
    
    self.btnsend.layer.cornerRadius = 10;
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnsendPress:(id)sender {
    NSDictionary *resultdict = [ApiHandler suggestionsadd:self.txtview.text];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        [FSToast showToast:self messge:@"요청되었습니다."];
        [NSTimer timerWithTimeInterval:1 target:self selector:@selector(btnbackPress:) userInfo:nil repeats:NO];
    }
}
 
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [self.view endEditing:YES];
}

@end
