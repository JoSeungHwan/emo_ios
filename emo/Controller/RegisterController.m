//
//  RegisterController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "RegisterController.h"
#import "PoliciesController.h"
#import "RegisterEmailController.h"

@interface RegisterController ()

@end

@implementation RegisterController
@synthesize btnok, btnuse, btnnext, btnservice, chkok, chksms, chktel, chkuse, checkok, chkpush, checkall, checksms, checktel, checkuse, chkemail, checkpush, checkemail, chkservice, checkservice, chkmarketing, checkmarketing;

- (void)viewDidLoad {
 
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"회원가입";
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
    
    
    self.btnnext.layer.cornerRadius = 10;
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkallPress:(id)sender {
    self.checkall.selected = !self.checkall.selected;
    self.checkok.selected = self.checkall.selected;
    self.checkuse.selected = self.checkall.selected;
    self.checkservice.selected = self.checkall.selected;
    self.checkmarketing.selected = self.checkall.selected;
    self.checkemail.enabled = self.checkall.selected;
    self.checksms.enabled = self.checkall.selected;
    self.checkpush.enabled = self.checkall.selected;
    self.checktel.enabled = self.checkall.selected;
    self.checkemail.selected = self.checkall.selected;
    self.checksms.selected = self.checkall.selected;
    self.checkpush.selected = self.checkall.selected;
    self.checktel.selected = self.checkall.selected;
    
    self.chkok = self.checkall.selected;
    self.chkservice = self.checkall.selected;
    self.chkuse = self.checkall.selected;
    self.chkmarketing = self.checkall.selected;
    self.chkemail = self.checkall.selected;
    self.chksms = self.checkall.selected;
    self.chkpush = self.checkall.selected;
    self.chktel = self.checkall.selected;
    
    if (self.checkall.selected){
        self.btnnext.backgroundColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
    } else {
        self.btnnext.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
    }
}

- (IBAction)checkokPress:(id)sender {
    self.checkok.selected = !self.checkok.selected;
    self.chkok = self.checkok.selected;
    if (self.checkok.selected == false) {
        self.checkall.selected = false;
    }
    if (self.chkok && self.chkuse && self.chkservice){
        self.btnnext.backgroundColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
    } else {
        self.btnnext.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
    }
}

- (IBAction)checkservicePress:(id)sender {
    self.checkservice.selected = !self.checkservice.selected;
    self.chkservice = self.checkservice.selected;
    if (self.checkservice.selected == false) {
        self.checkall.selected = false;
    }
    if (self.chkok && self.chkuse && self.chkservice){
        self.btnnext.backgroundColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
    } else {
        self.btnnext.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
    }
}

- (IBAction)checkusePress:(id)sender {
    self.checkuse.selected = !self.checkuse.selected;
    self.chkuse = self.checkuse.selected;
    if (self.checkuse.selected == false) {
        self.checkall.selected = false;
    }
    if (self.chkok && self.chkuse && self.chkservice){
        self.btnnext.backgroundColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
    } else {
        self.btnnext.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
    }
}

- (IBAction)checkmarketingPress:(id)sender {
    self.checkmarketing.selected = !self.checkmarketing.selected;
    self.chkmarketing = self.checkmarketing.selected;
    if (self.checkmarketing.selected == false) {
        self.checkall.selected = false;
        self.checkemail.enabled = false;
        self.checksms.enabled = false;
        self.checkpush.enabled = false;
        self.checktel.enabled = false;
        self.checkemail.selected = false;
        self.checksms.selected = false;
        self.checkpush.enabled = false;
        self.checktel.selected = false;
        self.chkemail = self.checkmarketing.selected;
        self.chksms = self.checkmarketing.selected;
        self.chkpush = self.checkmarketing.selected;
        self.chktel = self.checkmarketing.selected;
    } else {
        self.checkemail.enabled = true;
        self.checksms.enabled = true;
        self.checkpush.enabled = true;
        self.checktel.enabled = true;
    }
}

- (IBAction)checkEmailPress:(id)sender {
    self.checkemail.selected = !self.checkemail.selected;
    self.chkemail = self.checkemail.selected;
    if (self.checkemail.selected == false) {
        self.checkall.selected = false;
    }
}

- (IBAction)checksmsPress:(id)sender {
    self.checksms.selected = !self.checksms.selected;
 
    self.chksms = self.checksms.selected;
    if (self.checksms.selected == false) {
        self.checkall.selected = false;
    }
}

- (IBAction)checkpushPress:(id)sender {
    self.checkpush.selected = !self.checkpush.selected;
    self.chkpush = self.checkpush.selected;
    if (self.checkpush.selected == false) {
        self.checkall.selected = false;
    }
}

- (IBAction)checktelPress:(id)sender {
    self.checktel.selected = !self.checktel.selected;
    if (self.checktel.selected == false) {
        self.checkall.selected = false;
    }
}

- (IBAction)btnnextPress:(id)sender {
    if (self.chkok && self.chkservice && self.chkuse) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (self.chkok) {
            [defaults setValue:@"Y" forKey:@"ok_agree"];
        } else {
            [defaults setValue:@"N" forKey:@"ok_agree"];
        }
        
        if (self.chkservice) {
            [defaults setValue:@"Y" forKey:@"service_agree"];
        } else {
            [defaults setValue:@"N" forKey:@"service_agree"];
        }
        
        if (self.chkuse) {
            [defaults setValue:@"Y" forKey:@"use_agree"];
        } else {
            [defaults setValue:@"N" forKey:@"use_agree"];
        }
        
        if (self.chkmarketing) {
            [defaults setValue:@"Y" forKey:@"marketing_agree"];
        } else {
            [defaults setValue:@"N" forKey:@"marketing_agree"];
        }
        
        if (self.chkemail) {
            [defaults setValue:@"Y" forKey:@"email_agree"];
        } else {
            [defaults setValue:@"N" forKey:@"email_agree"];
        }
        
        if (self.chksms) {
            [defaults setValue:@"Y" forKey:@"sms_agree"];
        } else {
            [defaults setValue:@"N" forKey:@"sms_agree"];
        }
        
        if (self.chkpush) {
            [defaults setValue:@"Y" forKey:@"push_agree"];
        } else {
            [defaults setValue:@"N" forKey:@"push_agree"];
        }
        
        if (self.chktel) {
            [defaults setValue:@"Y" forKey:@"tel_agree"];
        } else {
            [defaults setValue:@"N" forKey:@"tel_agree"];
        }
        [defaults synchronize];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        RegisterEmailController *dc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterEmailController"];
        
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        [FSToast showToast:self messge:@"필수항목을 선택하세요."];
        return;
    }
}

- (IBAction)btnokPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PoliciesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PoliciesController"];
    dc.stype = @"5000";
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnservicePress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PoliciesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PoliciesController"];
    dc.stype = @"1000";
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnusePress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PoliciesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PoliciesController"];
    dc.stype = @"2000";
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnmarketingPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PoliciesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PoliciesController"];
    dc.stype = @"3000";
    [self.navigationController pushViewController:dc animated:YES];
}

@end
