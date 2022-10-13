//
//  SettingController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "SettingController.h"
#import "AlramController.h"
#import "UserEditController.h"
#import "RuleController.h"
#import "ServiceController.h"
#import "RequestController.h"
#import "User.h"
#import "FireController.h"

@interface SettingController ()

@end

@implementation SettingController
@synthesize scrollView;

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"설정";
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
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 960);
    self.btnlanding.selected = false;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"landing"] isKindOfClass:[NSString class]]) {
        NSLog(@"%@",[defaults objectForKey:@"landing"]);
        if ([[defaults objectForKey:@"landing"] isEqualToString:@"Y"]) {
            self.btnlanding.selected = true;
        }
    }
    
    if ([[defaults objectForKey:@"autologin"] isEqualToString:@"Y"]) {
        self.btnautologin.selected = true;
    } else {
        self.btnautologin.selected = false;
    }
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnlandingPress:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"landing"] isKindOfClass:[NSString class]]) {
        if ([[defaults objectForKey:@"landing"] isEqualToString:@"Y"]) {
            self.btnlanding.selected = false;
            [defaults setObject:@"N" forKey:@"landing"];
            
        } else {
            self.btnlanding.selected = true;
            [defaults setObject:@"Y" forKey:@"landing"];
            
        }
    } else {
        self.btnlanding.selected = true;
        [defaults setObject:@"Y" forKey:@"landing"];
    }
    [defaults synchronize];
}

- (IBAction)btnautologinPress:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"autologin"] isEqualToString:@"Y"]) {
        [defaults setObject:@"N" forKey:@"autologin"];
        self.btnautologin.selected = false;
    } else {
        [defaults setObject:@"Y" forKey:@"autologin"];
        self.btnautologin.selected = true;
    }
    [defaults synchronize];
}

- (IBAction)btnalramPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    AlramController *dc = [storyboard instantiateViewControllerWithIdentifier:@"AlramController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnmyinfoPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    UserEditController *dc = [storyboard instantiateViewControllerWithIdentifier:@"UserEditController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnpolicePress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    RuleController *dc = [storyboard instantiateViewControllerWithIdentifier:@"RuleController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnrulePress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    ServiceController *dc = [storyboard instantiateViewControllerWithIdentifier:@"ServiceController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnrequestPress:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    RequestController *dc = [storyboard instantiateViewControllerWithIdentifier:@"RequestController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnlogoutPress:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"N" forKey:@"autologin"];
    [defaults setObject:@"" forKey:@"token"];
    [defaults synchronize];
    User *user= [User sharedInstance];
    user.token = @"";
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnfirePress:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    FireController *dc = [storyboard instantiateViewControllerWithIdentifier:@"FireController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}
@end
