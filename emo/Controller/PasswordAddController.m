//
//  PasswordAddController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "PasswordAddController.h"

@interface PasswordAddController ()

@end

@implementation PasswordAddController
@synthesize txtpassword, txtrepassword, btnsend, warringview1, warringview2;


- (void)viewDidLoad {
    self.passwordcheck = false;
    self.passwordcheck1 = false;
    if ([self.stype isEqualToString:@""]) {
        self.stype = @"edit";
    }
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"비밀번호 등록";
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
    self.btnsend.layer.cornerRadius = 10;
    self.txtpassword.delegate = self;
    self.txtrepassword.delegate = self;
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnsendPress:(id)sender {
    if (self.passwordcheck && self.passwordcheck1) {
        NSDictionary *resultDict = [ApiHandler changepassword:self.stype newpassword:self.txtpassword.text oldpassword:@"" repassword:self.txtrepassword.text];
        if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
            return;
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.txtpassword]) {
        if ([self checkPW:self.txtpassword.text]) {
            self.warringview1.hidden = YES;
            self.passwordcheck = true;
        } else {
            self.warringview1.hidden = NO;
            self.passwordcheck = false;
            self.btnsend.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
        }
    } else {
        if ([self.txtpassword.text isEqualToString:self.txtrepassword.text]) {
            self.warringview2.hidden = YES;
            self.passwordcheck1 = true;
           
            self.btnsend.backgroundColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
           
                
            
        } else {
            self.warringview2.hidden = NO;
            self.passwordcheck1 = false;
            self.btnsend.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.txtpassword]) {
        if ([self checkPW:self.txtpassword.text]) {
            self.warringview1.hidden = YES;
            self.passwordcheck = true;
        } else {
            self.warringview1.hidden = NO;
            self.passwordcheck = false;
            self.btnsend.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
        }
    } else {
        if ([self.txtpassword.text isEqualToString:self.txtrepassword.text]) {
            self.warringview2.hidden = YES;
            self.passwordcheck1 = true;
           
            self.btnsend.backgroundColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
           
                
            
        } else {
            self.warringview2.hidden = NO;
            self.passwordcheck1 = false;
            self.btnsend.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
        }
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    if ([textField isEqual:self.txtpassword]) {
        if ([self checkPW:self.txtpassword.text]) {
            self.warringview1.hidden = NO;
            self.passwordcheck = true;
        } else {
            self.warringview1.hidden = YES;
            self.passwordcheck = false;
        }
    } else {
        if ([self.txtpassword.text isEqualToString:self.txtrepassword.text]) {
            self.warringview2.hidden = YES;
            self.passwordcheck1 = true;
        } else {
            self.warringview2.hidden = NO;
            self.passwordcheck1 = false;
        }
    }
}

- (BOOL)checkPW:(NSString *)pw {
    
    NSString *check =  @"^[a-zA-Z0-9//s]{8,16}$";
    NSRange match = [pw rangeOfString:check options:NSRegularExpressionSearch];
    if (NSNotFound == match.location)
    {
        return NO;
        
    }
    return YES;
}
    
@end
