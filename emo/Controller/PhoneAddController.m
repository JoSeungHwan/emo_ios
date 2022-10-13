//
//  PhoneAddController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "PhoneAddController.h"
#import "ProfileController.h"

@interface PhoneAddController ()

@end

@implementation PhoneAddController
@synthesize btnauth, btnsend, btnresend, txtauth, txtphone, authView, pc;
static CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

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
    
    
    self.btnsend.layer.cornerRadius = 10;
    self.btnresend.layer.cornerRadius = 10;
    self.btnauth.layer.cornerRadius = 10;
    
    [super viewDidLoad];
}

- (IBAction)btnskipPress:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([[defaults objectForKey:@"method"] isEqualToString:@""]) {
        [defaults setValue:@"" forKey:@"reg_phone"];
    } else {
        [defaults setValue:@"" forKey:@"sns_phone"];
    }

    [defaults synchronize];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    ProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileController"];
   
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnsendPress:(id)sender {
    if ([self.txtphone.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"휴대폰번호를 입력하세요."];
        return;
    }
    [self.txtphone resignFirstResponder];
    self.btnsend.hidden = YES;
    self.btnresend.hidden = NO;
    NSString *phoneNumber = [[self.txtphone.text componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet]invertedSet]]componentsJoinedByString:@""];

        

    NSString *someRegexp = @"^0\\d{9,10}$";

    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", someRegexp];

    

    if ([myTest evaluateWithObject: phoneNumber]){

        //Matches

        NSDictionary *resultdict = [ApiHandler phoneauthsend:self.txtphone.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
           
           
            [self showpopup];
            
        } else {
            [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
            return;
        }

    }else{

        [FSToast showToast:self messge:@"휴대폰번호 형식이 맞지 않습니다."];
        return;
    }
    
}

- (void)showpopup {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
    self.pc.view.frame = self.view.frame;
    popupview = self.pc.bgview;
    
    self.pc.popuptype = @"phoneauth";
   // [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popupview];
    [self.pc startview];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hidepopup) userInfo:nil repeats:NO];
}

- (void)showpopup1 {

    self.pc.popuptype = @"phoneauthcomplate";
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([[defaults objectForKey:@"method"] isEqualToString:@""]) {
        [defaults setValue:self.txtphone.text forKey:@"reg_phone"];
    } else {
        [defaults setValue:self.txtphone.text forKey:@"sns_phone"];
    }

    [defaults synchronize];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    ProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileController"];
   
    [self.navigationController pushViewController:dc animated:YES];
}


- (IBAction)btnresendPress:(id)sender {
    if ([self.txtphone.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"휴대폰번호를 입력하세요."];
        return;
    }
    [self.txtphone resignFirstResponder];
    self.btnsend.hidden = YES;
    self.btnresend.hidden = NO;
    NSString *phoneNumber = [[self.txtphone.text componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet]invertedSet]]componentsJoinedByString:@""];

        

    NSString *someRegexp = @"^0\\d{9,10}$";

    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", someRegexp];

    

    if ([myTest evaluateWithObject: phoneNumber]){

        //Matches

        NSDictionary *resultdict = [ApiHandler phoneauthsend:self.txtphone.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
           
           
            [self showpopup];
            
        } else {
            [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
            return;
        }

    }else{

        [FSToast showToast:self messge:@"휴대폰번호 형식이 맞지 않습니다."];
        return;
    }
}

- (IBAction)btnauthPress:(id)sender {
    if ([self.txtphone.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"휴대폰번호를 입력하세요."];
        return;
    }
    if ([self.txtauth.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"인증번호를 입력하세요."];
        return;
    }
    NSDictionary *resultdict = [ApiHandler phoneauthcheck:self.txtphone.text authnum:self.txtauth.text];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
       
       
        [self showpopup1];
        
    } else {
        [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
        return;
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
