//
//  RegisterEmailController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "RegisterEmailController.h"
#import "RegisterPasswordController.h"

@interface RegisterEmailController ()

@end

@implementation RegisterEmailController
@synthesize txtemail, txtauth, viewauth, viewarring, btnsendauth, btnauthcheck, btnresendauth, pc;
CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

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
    

    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
    self.btnsendauth.layer.cornerRadius = 10;
    self.btnresendauth.layer.cornerRadius = 10;
    self.btnauthcheck.layer.cornerRadius = 10;
    
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
 

-(BOOL) validateEmail:(NSString*) emailString
{
     NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
     NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
     NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    NSLog(@"%lu", (unsigned long)regExMatches);
     if (regExMatches == 0) {
         return NO;
     }
     else
         return YES;
}

- (IBAction)btnauthPress:(id)sender {
    if ([self.txtauth.text isEqualToString:@""] ) {
        [FSToast showToast:self messge:@"인증번호를 입력하세요."];
        return;
    }
    if ([self.txtemail.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"이메일을 입력하세요."];
        return;;
    }
    if ([self validateEmail:self.txtemail.text]) {
        [self.viewarring setHidden:YES];
        [self.txtemail resignFirstResponder];
        [self.txtauth resignFirstResponder];
        NSDictionary *resultdict = [ApiHandler emailauthcheck:self.txtemail.text authnum:self.txtauth.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
           
           
            [self showpopup1];
            
        } else {
            [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
            return;
        }
    } else {
        [self.viewarring setHidden:NO];
    }
}

- (IBAction)btnsendPress:(id)sender {
    if ([self.txtemail.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"이메일을 입력하세요."];
        return;;
    }
    
    if ([self validateEmail:self.txtemail.text]) {
        [self.viewarring setHidden:YES];
        [self.txtemail resignFirstResponder];
        
        NSDictionary *resultdict = [ApiHandler emailauthsend:self.txtemail.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            [self.btnsendauth setHidden:YES];
            [self.btnresendauth setHidden:NO];
           
            self.viewauth.hidden = NO;
            [self showpopup];
            
        } else {
            [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
            return;
        }
        
    } else {
        [self.viewarring setHidden:NO];
    }
}

- (void)showpopup {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
    self.pc.view.frame = self.view.frame;
    popupview = self.pc.bgview;
    
    self.pc.popuptype = @"sendemail";
   // [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popupview];
    [self.pc startview];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hidepopup) userInfo:nil repeats:NO];
}

- (void)showpopup1 {

    self.pc.popuptype = @"emailauthcomplate";
   // [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popupview];
    [self.pc startview];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hidepopup1) userInfo:nil repeats:NO];
}


- (void)hidepopup {
    [self.pc hidenview];
}

- (void)hidepopup1 {
    [self.pc hidenview];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    RegisterPasswordController *dc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterPasswordController"];
    dc.email = self.txtemail.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.txtemail.text forKey:@"reg_email"];
    [defaults synchronize];
    [self.navigationController pushViewController:dc animated:YES];
}


- (IBAction)btnresendPress:(id)sender {
    if ([self.txtemail.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"이메일을 입력하세요."];
        return;;
    }
    
    if ([self validateEmail:self.txtemail.text]) {
        [self.viewarring setHidden:YES];
        [self.txtemail resignFirstResponder];
        
        NSDictionary *resultdict = [ApiHandler emailauthsend:self.txtemail.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            [self.btnsendauth setHidden:YES];
            [self.btnresendauth setHidden:NO];
           
            self.viewauth.hidden = NO;
            [self showpopup];
            
        } else {
            [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
            return;
        }
        
    } else {
        [self.viewarring setHidden:NO];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [self.view endEditing:YES];
}

-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField
 {
     CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =  midline - viewRect.origin.y  - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
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
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
   }
   else
   {
       animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
   }
   CGRect viewFrame = self.view.frame;
   viewFrame.origin.y -= animatedDistance;

   [UIView beginAnimations:nil context:NULL];
   [UIView setAnimationBeginsFromCurrentState:YES];
   [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
   [self.view setFrame:viewFrame];
   [UIView commitAnimations];
   return YES;
 }

- (BOOL) textFieldShouldEndEditing:(UITextField*)textField
{
     CGRect viewFrame = self.view.frame;
     viewFrame.origin.y += animatedDistance;
     [UIView beginAnimations:nil context:NULL];
     [UIView setAnimationBeginsFromCurrentState:YES];
     [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
     [self.view setFrame:viewFrame];
     [UIView commitAnimations];
    return true;
}

@end
