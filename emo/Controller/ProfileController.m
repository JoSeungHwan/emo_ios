//
//  ProfileController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "ProfileController.h"
#import "User.h"



@interface ProfileController ()

@end

@implementation ProfileController
@synthesize imgProfile, btnimgedit, txtcomment, txtnickname, pc, btnmyedit, myinfoedit;


- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"프로필 정보";
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
    
    [rightbtn setTitle:@"완료" forState:UIControlStateNormal];
    [rightbtn setFont:[UIFont fontWithName:@"SBAggroB" size:18]];
    [rightbtn setTitleColor:[UIColor colorWithRed:(239.0f/255.0f) green:(0.0f/255.0f) blue:(126.0f/255.0f) alpha:1] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(btncomplatePress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width / 2;
    self.filepath = @"";
    if ([self.stype isEqualToString:@"useredit"]) {
        self.myinfoedit.hidden = NO;
        User *user = [User sharedInstance];
        self.txtnickname.text = user.nickname;
        self.txtcomment.text = user.introduction;
        if (self.txtcomment.text.length > 0) {
            self.lblhide.hidden = YES;
        }
        self.imgProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.profile_image_url]]];
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![[defaults objectForKey:@"method"] isEqualToString:@""]) {
            if (![[defaults objectForKey:@"sns_profile_image_url"] isEqualToString:@""]) {
                self.imgProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[defaults objectForKey:@"sns_profile_image_url"] ]]];
            }
            
            if (![[defaults objectForKey:@"sns_nickname"] isEqualToString:@""]) {
                self.txtnickname.text =  [defaults objectForKey:@"sns_nickname"];
            }
        }
    }
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btncomplatePress:(id)sender {
    [self.txtcomment resignFirstResponder];
    [self.txtnickname resignFirstResponder];
    if ([self.stype isEqualToString:@"useredit"]) {
        User *user = [User sharedInstance];
        if ([user.nickname isEqualToString:self.txtnickname.text]) {
            if ([self.filepath isEqualToString:@""]) {
                
                NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                [dic setValue:self.txtnickname.text forKey:@"nickname"];
                [dic setValue:self.txtcomment.text forKey:@"comment"];
                [dic setValue:self.reset forKey:@"reset"];
                [dic setValue:@"" forKey:@"profile_image_url"];
                NSDictionary *resultdict = [ApiHandler profileupdate:dic];
                if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                    NSDictionary *datadict = [resultdict objectForKey:@"data"];
                    [FSToast showToast:self messge:@"수정되었습니다."];
                    User *user = [User sharedInstance];
                    [user userinit:datadict];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"profilerefresh" object:self];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else {
                    [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
                }
            } else {
                NSLog(@"%@",self.filepath);
                NSDictionary *dict = [ApiHandler fileupload:self.filepath];
                NSLog(@"%@",[dict description]);
                if ([[[dict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                  
                    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                    [dic setValue:self.txtnickname.text forKey:@"nickname"];
                    [dic setValue:self.txtcomment.text forKey:@"comment"];
                    [dic setValue:self.reset forKey:@"reset"];
                    [dic setValue:[dict objectForKey:@"data"] forKey:@"profile_image_url"];
                    NSDictionary *resultdict = [ApiHandler profileupdate:dic];
                    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                        NSDictionary *datadict = [resultdict objectForKey:@"data"];
                        [FSToast showToast:self messge:@"수정되었습니다."];
                        User *user = [User sharedInstance];
                        [user userinit:datadict];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"profilerefresh" object:self];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }else {
                    [FSToast showToast:self messge:[dict objectForKey:@"message"]];
                }
            }
             
        } else {
            NSDictionary *resultdict = [ApiHandler nicknamecheck:self.txtnickname.text];
            if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                       bundle:nil];
                if (self.pc == nil) {
                    self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
                    self.pc.view.frame = self.view.frame;
                    popupview = self.pc.bgview;
                    [self.view addSubview:popupview];
                    [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                self.pc.popuptype = @"nickcheckok";
                
                [self.pc startview];
                [NSTimer timerWithTimeInterval:3 target:self selector:@selector(hidepopup) userInfo:nil repeats:NO];
                if ([self.filepath isEqualToString:@""]) {
                    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                    [dic setValue:self.txtnickname.text forKey:@"nickname"];
                    [dic setValue:self.txtcomment.text forKey:@"comment"];
                    [dic setValue:self.reset forKey:@"reset"];
                    [dic setValue:@"" forKey:@"profile_image_url"];
                    NSDictionary *resultdict = [ApiHandler profileupdate:dic];
                    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                        NSDictionary *datadict = [resultdict objectForKey:@"data"];
                        [FSToast showToast:self messge:@"수정되었습니다."];
                        User *user = [User sharedInstance];
                        [user userinit:datadict];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"profilerefresh" object:self];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else {
                        [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
                    }
                } else {
                    NSDictionary *dict = [ApiHandler fileupload:self.filepath];
                    NSLog(@"%@",[dict description]);
                    if ([[[dict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                        NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                      
                        [dic setValue:self.txtnickname.text forKey:@"nickname"];
                        [dic setValue:self.txtcomment.text forKey:@"comment"];
                        [dic setValue:self.reset forKey:@"reset"];
                        [dic setValue:[dict objectForKey:@"data"] forKey:@"profile_image_url"];
                        NSDictionary *resultdict = [ApiHandler profileupdate:dic];
                        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                            NSDictionary *datadict = [resultdict objectForKey:@"data"];
                            [FSToast showToast:self messge:@"수정되었습니다."];
                            User *user = [User sharedInstance];
                            [user userinit:datadict];
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"profilerefresh" object:self];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                    }else {
                        [FSToast showToast:self messge:[dict objectForKey:@"message"]];
                    }
                }
            } else {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                       bundle:nil];
                
                if (self.pc == nil) {
                    self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
                    self.pc.view.frame = self.view.frame;
                    popupview = self.pc.bgview;
                    [self.view addSubview:popupview];
                    [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                self.pc.popuptype = @"nickcheckerror";
                
                [self.pc startview];
                [NSTimer timerWithTimeInterval:3 target:self selector:@selector(hidepopup) userInfo:nil repeats:NO];
            }
        }
    } else {
       if ([self.txtnickname.text isEqualToString:@""]) {
            [FSToast showToast:self messge:@"닉네임을 입력하세요."];
            return;
        }
        NSDictionary *resultdict = [ApiHandler nicknamecheck:self.txtnickname.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
           
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                   bundle:nil];
            
            if (self.pc == nil) {
                self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
                self.pc.view.frame = self.view.frame;
                popupview = self.pc.bgview;
                [self.view addSubview:popupview];
                [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            self.pc.popuptype = @"nickcheckok";
            
            [self.pc startview];
            [NSTimer timerWithTimeInterval:3 target:self selector:@selector(hidepopup) userInfo:nil repeats:NO];
            if (![self.filepath isEqualToString:@""]) {
                NSDictionary *dict = [ApiHandler fileupload:self.filepath];
                NSLog(@"%@",[dict description]);
                if ([[[dict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                   
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:[defaults objectForKey:@"reg_email"] forKey:@"email"];
                    [dic setValue:[defaults objectForKey:@"reg_password"] forKey:@"password"];
                    [dic setValue:[defaults objectForKey:@"reg_repassword"] forKey:@"password_confirm"];
                    [dic setValue:@"1" forKey:@"policy_agree"];
                    [dic setValue:@"1" forKey:@"privacy_agree"];
                    if ([[defaults objectForKey:@"email_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"email_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"email_agree"];
                    }
                    if ([[defaults objectForKey:@"sms_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"sms_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"sms_agree"];
                    }
                    if ([[defaults objectForKey:@"push_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"push_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"push_agree"];
                    }
                    if ([[defaults objectForKey:@"tel_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"tel_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"tel_agree"];
                    }
                    
                    if ([[defaults objectForKey:@"additional_privacy_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"additional_privacy_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"additional_privacy_agree"];
                    }
                    [dic setValue:self.txtnickname.text forKey:@"nickname"];
                    [dic setValue:self.txtcomment.text forKey:@"introduction"];
                  
                    [dic setValue:[defaults objectForKey:@"reg_gender"] forKey:@"gender"];
                    [dic setValue:[defaults objectForKey:@"reg_birth"] forKey:@"birthday"];
                    [dic setValue:[defaults objectForKey:@"reg_phone"] forKey:@"phone"];
                    [dic setValue:[dict objectForKey:@"data"] forKey:@"profile_image_url"];
                    
                    NSDictionary *returndict = [ApiHandler registerinfo:dic];
                    if ([[[returndict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                        NSDictionary *datadict = [returndict objectForKey:@"data"];
                        User *user = [User sharedInstance];
                        [user userinit:datadict];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    } else {
                        [FSToast showToast:self messge:[returndict objectForKey:@"message"]];
                    }
                                              
                }
            } else {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                if ([[defaults objectForKey:@"method"] isEqualToString:@""]) {
                    [dic setValue:[defaults objectForKey:@"reg_email"] forKey:@"email"];
                    [dic setValue:[defaults objectForKey:@"reg_password"] forKey:@"password"];
                    [dic setValue:[defaults objectForKey:@"reg_repassword"] forKey:@"password_confirm"];
                    [dic setValue:@"1" forKey:@"policy_agree"];
                    [dic setValue:@"1" forKey:@"policy_agree"];
                    if ([[defaults objectForKey:@"email_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"email_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"email_agree"];
                    }
                    if ([[defaults objectForKey:@"sms_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"sms_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"sms_agree"];
                    }
                    if ([[defaults objectForKey:@"push_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"push_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"push_agree"];
                    }
                    if ([[defaults objectForKey:@"tel_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"tel_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"tel_agree"];
                    }
                    
                    if ([[defaults objectForKey:@"additional_privacy_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"additional_privacy_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"additional_privacy_agree"];
                    }
                    [dic setValue:self.txtnickname.text forKey:@"nickname"];
                    [dic setValue:self.txtcomment.text forKey:@"introduction"];
             
                    [dic setValue:[defaults objectForKey:@"reg_gender"] forKey:@"gender"];
                    [dic setValue:[defaults objectForKey:@"reg_birth"] forKey:@"birthday"];
                    [dic setValue:[defaults objectForKey:@"reg_phone"] forKey:@"phone"];
                    [dic setValue:@"" forKey:@"profile_image_url"];
                    NSDictionary *returndict = [ApiHandler registerinfo:dic];
                    if ([[[returndict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                        [FSToast showToast:self messge:@"등록되었습니다."];
                        NSDictionary *datadict = [returndict objectForKey:@"data"];
                        User *user = [User sharedInstance];
                        [user userinit:datadict];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    } else {
                        [FSToast showToast:self messge:[returndict objectForKey:@"message"]];
                    }
                } else {
                    
                    if ([[defaults objectForKey:@"additional_privacy_agree"] isEqualToString:@"Y"]) {
                        [dic setValue:@"1" forKey:@"additional_privacy_agree"];
                    } else {
                        [dic setValue:@"0" forKey:@"additional_privacy_agree"];
                    }
                    [dic setValue:self.txtnickname.text forKey:@"nickname"];
                    [dic setValue:self.txtcomment.text forKey:@"introduction"];
             
                    [dic setValue:[defaults objectForKey:@"sns_gender"] forKey:@"gender"];
                    [dic setValue:[defaults objectForKey:@"sns_birth"] forKey:@"birthday"];
                    [dic setValue:[defaults objectForKey:@"sns_phone"] forKey:@"phone"];
                    [dic setValue:[defaults objectForKey:@"sns_profile_image_url"] forKey:@"profile_image_url"];
                    NSDictionary *returndict = [ApiHandler loginSocialinfo:dic];
                    if ([[[returndict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                        [FSToast showToast:self messge:@"등록되었습니다."];
                        NSDictionary *datadict = [returndict objectForKey:@"data"];
                        User *user = [User sharedInstance];
                        [user userinit:datadict];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    } else {
                        [FSToast showToast:self messge:[returndict objectForKey:@"message"]];
                    }
                }
                
            }
        } else {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                   bundle:nil];
            
            if (self.pc == nil) {
                self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
                self.pc.view.frame = self.view.frame;
                popupview = self.pc.bgview;
                [self.view addSubview:popupview];
                [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            self.pc.popuptype = @"nickcheckerror";
            
            [self.pc startview];
            [NSTimer timerWithTimeInterval:3 target:self selector:@selector(hidepopup) userInfo:nil repeats:NO];
        }
   }
}

- (void)hidepopup {
    [self.pc hidenview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }

    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 12;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView.text.length > 1) {
        self.lblhide.hidden = YES;
    } else {
        self.lblhide.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // Prevent crashing undo bug – see note below.
    if (textView.text.length > 0) {
        self.lblhide.hidden = YES;
    } else {
        self.lblhide.hidden = NO;
    }
    if(range.length + range.location > textView.text.length)
    {
        return NO;
    }

    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    return newLength <= 40;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    CGRect textFieldRect = [self.view.window convertRect:textView.bounds fromView:textView];
   CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
   CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
   CGFloat numerator =  midline - viewRect.origin.y  - 0.2 * viewRect.size.height;
   CGFloat denominator = (0.8 - 0.2)
   * viewRect.size.height;
   CGFloat heightFraction = numerator / denominator;
   if (heightFraction < 0.0)
   {
       heightFraction = 0.0;
   }
   else if (heightFraction > 1.0)
   {
       heightFraction = 1.0;
   }
   UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  if (orientation == UIInterfaceOrientationPortrait ||
   orientation == UIInterfaceOrientationPortraitUpsideDown)
  {
       animatedDistance = floor(216 * heightFraction);
  }
  else
  {
      animatedDistance = floor(162 * heightFraction);
  }
  CGRect viewFrame = self.view.frame;
  viewFrame.origin.y -= animatedDistance;

  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:0.3];
  [self.view setFrame:viewFrame];
  [UIView commitAnimations];
  return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
   return true;
}

- (IBAction)btnimageeditPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    
    if (self.pc == nil) {
        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        [self.view addSubview:popupview];
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.pc = nil;
        [popupview removeFromSuperview];
        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        [self.view addSubview:popupview];
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.pc.popuptype = @"useredit";
    [self.pc.btndraw addTarget:self action:@selector(btndrawPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.pc.btnpic addTarget:self action:@selector(btnpicPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.pc.btncamera addTarget:self action:@selector(btncameraPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.pc startview];
    
    
    
}

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

- (IBAction)btndrawPress:(id)sender {
    
}

- (IBAction)btnpicPress:(id)sender {
    UIImagePickerController *picker;

    picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setAllowsEditing:YES];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentModalViewController:picker animated:YES];
}

- (IBAction)btncameraPress:(id)sender {
    UIImagePickerController *picker;

    picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setAllowsEditing:YES];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentModalViewController:picker animated:YES];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //successfully picked   / handed over
    NSLog(@"imagePickerController 호출");
    UIImage *pickedImage = info[UIImagePickerControllerEditedImage];
    [self.imgProfile setImage:pickedImage];//저장할 경로 얻기
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"latest_photo.png"];
    NSLog(@"paths  %@" , paths);
    NSLog(@"documentsDirectory %@" , documentsDirectory);
    NSLog(@"imagePath %@" , imagePath);
     //피커에서 이미지 선택 및 저장
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"mediaType %@", mediaType); //public.image        //파일에 저장하기
    if ([mediaType isEqualToString:@"public.image"]){//
        UIImage *pickedImage2 = info[UIImagePickerControllerEditedImage];
        //self.imgProfile.image = pickedImage2;
        NSData *webData = UIImagePNGRepresentation(pickedImage2);
        [webData writeToFile:imagePath atomically:YES];
        //self.filepath = [webData base64EncodedStringWithOptions:NSUTF8StringEncoding];
        self.filepath= imagePath;
        NSLog(@"저장되었습니다.");
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.pc hidenview];
    }else{
        NSLog(@"저장실패");
        [self.pc hidenview];
    }
    
}
  

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    // handle cancel
    NSLog(@"imagePickerControllerDidCancel 호출");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.pc hidenview];
    
}


- (IBAction)btnmyeditPress:(id)sender {
    
}

@end
