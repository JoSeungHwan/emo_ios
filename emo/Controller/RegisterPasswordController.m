//
//  RegisterPasswordController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "RegisterPasswordController.h"
#import "AddInfoBirthController.h"

@interface RegisterPasswordController ()

@end

@implementation RegisterPasswordController
@synthesize txtpassword, txtrepassword, btnnext, warringview1, warringview2;
bool passwordcheck = false;
bool passwordcheck1 = false;

-(void)viewDidLoad {
    
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
    
    self.btnnext.layer.cornerRadius = 10;
    
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnnextPress:(id)sender {
    if (passwordcheck && passwordcheck1) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:self.txtpassword.text forKey:@"reg_password"];
        [defaults setValue:self.txtrepassword.text forKey:@"reg_repassword"];
        [defaults synchronize];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        AddInfoBirthController *dc = [storyboard instantiateViewControllerWithIdentifier:@"AddInfoBirthController"];
       
        [self.navigationController pushViewController:dc animated:YES];
    }
}

- (IBAction)btnbackgroundPress:(id)sender {
    [self.txtpassword resignFirstResponder];
    [self.txtrepassword resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.txtpassword]) {
        if ([self checkPW:self.txtpassword.text]) {
            self.warringview1.hidden = YES;
            passwordcheck = true;
        } else {
            self.warringview1.hidden = NO;
            passwordcheck = false;
            self.btnnext.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
        }
    } else {
        if ([self.txtpassword.text isEqualToString:self.txtrepassword.text]) {
            self.warringview2.hidden = YES;
            passwordcheck1 = true;
           
            self.btnnext.backgroundColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
           
                
            
        } else {
            self.warringview2.hidden = NO;
            passwordcheck1 = false;
            self.btnnext.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.txtpassword]) {
        if ([self checkPW:self.txtpassword.text]) {
            self.warringview1.hidden = YES;
            passwordcheck = true;
        } else {
            self.warringview1.hidden = NO;
            passwordcheck = false;
            self.btnnext.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
        }
    } else {
        if ([self.txtpassword.text isEqualToString:self.txtrepassword.text]) {
            self.warringview2.hidden = YES;
            passwordcheck1 = true;
           
            self.btnnext.backgroundColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
           
                
            
        } else {
            self.warringview2.hidden = NO;
            passwordcheck1 = false;
            self.btnnext.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
        }
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    if ([textField isEqual:self.txtpassword]) {
        if ([self checkPW:self.txtpassword.text]) {
            self.warringview1.hidden = NO;
            passwordcheck = true;
        } else {
            self.warringview1.hidden = YES;
            passwordcheck = false;
        }
    } else {
        if ([self.txtpassword.text isEqualToString:self.txtrepassword.text]) {
            self.warringview2.hidden = YES;
            passwordcheck1 = true;
        } else {
            self.warringview2.hidden = NO;
            passwordcheck1 = false;
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
