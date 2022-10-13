//
//  RuleController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "RuleController.h"
#import "PoliciesController.h"

@interface RuleController ()

@end

@implementation RuleController
@synthesize btnok, btnpri, btnuse, btncheck2, btncheck3, btncheck4, btncheck5, btndetail, bthcheck1, btnservice;
int email, tel, push,sms, marketting;

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"서비스약관";
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
    
    NSDictionary *resultdict = [ApiHandler markettingagree];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dt = [resultdict objectForKey:@"data"];
        email = [[dt objectForKey:@"email_agree"] intValue];
        tel = [[dt objectForKey:@"tel_agree"] intValue];
        push = [[dt objectForKey:@"push_agree"] intValue];
        sms = [[dt objectForKey:@"sms_agree"] intValue];
        marketting = [[dt objectForKey:@"marketting_agree"] intValue];
        
        if (marketting == 1) {
            self.bthcheck1.selected = true;
        } else {
            self.bthcheck1.selected = false;
        }
        
        if (email == 1) {
            self.btncheck2.selected = true;
        } else {
            self.btncheck2.selected = false;
        }
        
        if (push == 1) {
            self.btncheck3.selected = true;
        } else {
            self.btncheck3.selected = false;
        }
        
        if (sms == 1) {
            self.btncheck4.selected = true;
        } else {
            self.btncheck4.selected = false;
        }
        
        if (marketting == 1) {
            self.btncheck5.selected = true;
        } else {
            self.btncheck5.selected = false;
        }
    }
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnokPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PoliciesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PoliciesController"];
    dc.stype = @"5000";
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnservicePress:(id)sedner {
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

- (IBAction)btnpriPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PoliciesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PoliciesController"];
    dc.stype = @"4000";
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btncheck1Press:(id)sender {
    self.bthcheck1.selected = !self.bthcheck1.selected;
    if (self.bthcheck1.selected) {
        marketting = 1;
    } else {
        marketting = 0;
    }
    NSDictionary *resultdict = [ApiHandler markettingedit:email tel:tel sms:sms push:push];
}

- (IBAction)btncheck2Press:(id)sender {
    self.btncheck2.selected = !self.btncheck2.selected;
    if (self.btncheck2.selected == false) {
        self.bthcheck1.selected = false;
        email = 0;
    } else {
        email = 1;
        if (self.btncheck3.selected && self.btncheck4.selected && self.btncheck5.selected) {
            self.bthcheck1.selected = true;
            marketting = 1;
        } else {
            marketting = 0;
        }
    }
    NSDictionary *resultdict = [ApiHandler markettingedit:email tel:tel sms:sms push:push];
}

- (IBAction)btncheck3Press:(id)sender {
    self.btncheck3.selected = !self.btncheck3.selected;
    if (self.btncheck3.selected == false) {
        self.bthcheck1.selected = false;
        sms = 0;
    } else {
        sms = 1;
        if (self.btncheck2.selected && self.btncheck4.selected && self.btncheck5.selected) {
            self.bthcheck1.selected = true;
            marketting = 1;
        } else {
            marketting = 0;
        }
    }
    NSDictionary *resultdict = [ApiHandler markettingedit:email tel:tel sms:sms push:push];
}

- (IBAction)btncheck4Press:(id)sender {
    self.btncheck4.selected = !self.btncheck4.selected;
    if (self.btncheck4.selected == false) {
        self.bthcheck1.selected = false;
        push = 0;
    } else {
        push = 1;
        if (self.btncheck3.selected && self.btncheck2.selected && self.btncheck5.selected) {
            self.bthcheck1.selected = true;
            marketting = 1;
        } else {
            marketting = 0;
        }
    }
    NSDictionary *resultdict = [ApiHandler markettingedit:email tel:tel sms:sms push:push];
}

- (IBAction)btncheck5Press:(id)sender {
    self.btncheck5.selected = !self.btncheck5.selected;
    if (self.btncheck5.selected == false) {
        self.bthcheck1.selected = false;
        tel = 0;
    } else {
        tel = 1;
        if (self.btncheck3.selected && self.btncheck4.selected && self.btncheck2.selected) {
            self.bthcheck1.selected = true;
            marketting = 1;
        } else {
            marketting = 0;
        }
    }
    NSDictionary *resultdict = [ApiHandler markettingedit:email tel:tel sms:sms push:push];
}

- (IBAction)btndetailPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PoliciesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PoliciesController"];
    dc.stype = @"3000";
    [self.navigationController pushViewController:dc animated:YES];
}

@end
