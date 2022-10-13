//
//  AddInfoGenderController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "AddInfoGenderController.h"
#import "ProfileController.h"
#import "PhoneAddController.h"

@interface AddInfoGenderController ()

@end

@implementation AddInfoGenderController
@synthesize btnnext, btnman, btnback, btnwoman;

- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"추가 정보 입력";
    lbltitle.font = [UIFont fontWithName:@"SBAggroB" size:18];
    lbltitle.textColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
    self.navigationItem.titleView = lbltitle;
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setFrame:CGRectMake(0, 0, 44, 44)];
   
    UIBarButtonItem *leftbarbtn = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem =leftbarbtn;
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setFrame:CGRectMake(0, 0, 44, 44)];
    
    [rightbtn setTitle:@"Skip" forState:UIControlStateNormal];
    [rightbtn setFont:[UIFont fontWithName:@"SBAggroB" size:18]];
    [rightbtn setTitleColor:[UIColor colorWithRed:(239.0f/255.0f) green:(0.0f/255.0f) blue:(126.0f/255.0f) alpha:1] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(btnskipPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    
    self.btnnext.layer.cornerRadius = 10;
    self.btnback.layer.cornerRadius = 10;
    [super viewDidLoad];
    
}

- (IBAction)btnskipPress:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"method"] isEqualToString:@""]) {
    
        [defaults setValue:@"" forKey:@"reg_gender"];
        [defaults setValue:@"" forKey:@"reg_phone"];
    } else {
        [defaults setValue:@"" forKey:@"sns_gender"];
        [defaults setValue:@"" forKey:@"sns_phone"];
    }

    [defaults synchronize];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    ProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileController"];
   
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnmanPress:(id)sender {
    self.btnman.selected = true;
    self.btnwoman.selected = false;
}

- (IBAction)btnwomanPress:(id)sender {
    self.btnman.selected = false;
    self.btnwoman.selected = true;
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnnextPress:(id)sender {
    if (self.btnman.selected == false && self.btnwoman.selected == false) {
        [FSToast showToast:self messge:@"성별을 선택하세요."];
        return;
    }
    NSString *gender = @"";
    if (self.btnman.selected) {
        gender = @"M";
    } else {
        gender = @"F";
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"method"] isEqualToString:@""]) {
        [defaults setValue:gender forKey:@"reg_gender"];
    } else {
    
        [defaults setValue:gender forKey:@"sns_gender"];
    }
    
    [defaults synchronize];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PhoneAddController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PhoneAddController"];
   
    [self.navigationController pushViewController:dc animated:YES];
}

@end
