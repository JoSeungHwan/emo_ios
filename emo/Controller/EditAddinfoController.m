//
//  EditAddinfoController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "EditAddinfoController.h"
#import "PoliciesController.h"
#import "User.h"

@interface EditAddinfoController ()

@end

@implementation EditAddinfoController
@synthesize btnsend, btnauth, btnbirth, btnresend, btnman, btncheck, btnwoman, btndetail, lblbirth, txtauth, txtphone, authview, pc;
static CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"추가 정보 관리";
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
    [rightbtn setTitle:@"저장" forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(btnsavePress:) forControlEvents:UIControlEventTouchUpInside];
    [rightbtn setFont:[UIFont fontWithName:@"SBAggroB" size:18]];
    [rightbtn setTitleColor:[UIColor colorWithRed:(239.0f/255.0f) green:(0.0f/255.0f) blue:(126.0f/255.0f) alpha:1] forState:UIControlStateNormal];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
        
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    self.btnman.layer.cornerRadius = 10;
    self.btnman.layer.borderColor = [[UIColor blackColor] CGColor];
    self.btnman.layer.borderWidth = 1;
    [self.btnman setBackgroundColor:[UIColor whiteColor]];
 
    self.btnwoman.layer.cornerRadius = 10;
    self.btnwoman.layer.borderColor = [[UIColor blackColor] CGColor];
    self.btnwoman.layer.borderWidth = 1;
    
    self.btnresend.layer.cornerRadius = 10;
    self.btnsend.layer.cornerRadius = 10;
    self.btnauth.layer.cornerRadius = 10;
    
    User *user = [User sharedInstance];
    
    if (user.additional_privacy_agree == 1) {
        self.btncheck.selected = true;
    }
    
    if (![user.birth isEqualToString:@""]) {
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyyMMdd"];
        
        NSDateFormatter *dateformat1 = [[NSDateFormatter alloc] init];
        [dateformat1 setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *birthdt = [dateformat dateFromString:user.birth];
        self.lblbirth.text = [dateformat1 stringFromDate:birthdt];
        self.selectbirth = user.birth;
    } else {
        self.selectbirth = @"";
    }
    
    if (![user.gender isEqualToString:@""]) {
        if ([user.gender isEqualToString:@"M"]) {
            self.btnman.selected = true;
            [self.btnman setBackgroundColor:[UIColor colorWithRed:(239.0f/255.0f) green:(0.0f/255.0f) blue:(126.0f/255.0f) alpha:1]];
        } else {
            self.btnwoman.selected = true;
            [self.btnwoman setBackgroundColor:[UIColor colorWithRed:(239.0f/255.0f) green:(0.0f/255.0f) blue:(126.0f/255.0f) alpha:1]];
        }
    }
    
    if (![user.phone isEqualToString:@""]) {
        self.txtphone.text = user.phone;
        self.authphone = user.phone;
    } else {
        self.authphone = @"";
    }
    
    [super viewDidLoad];
}


- (IBAction)btnsavePress:(id)sender {
    NSString *gender = @"";
    if (self.btnman.isSelected) {
        gender = @"M";
    } else if (self.btnwoman.isSelected) {
        gender = @"F";
    }
    NSString *add = @"0";
    if (self.btncheck.isSelected) {
        add = @"1";
    }
    
    NSDictionary *resultdict = [ApiHandler addinfoupdate:add gender:gender birth:self.selectbirth phone:self.authphone];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *datadict = [resultdict objectForKey:@"data"];
        User *user = [User sharedInstance];
        [user userinit:datadict];
        //user = [user init:datadict];
       // User *user = [[User alloc] init:datadict];
        
        NSLog(@"%@", user.nickname);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
        return;
    }
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnchecPress:(id)sender {
    self.btncheck.selected = !self.btncheck.selected;
}

- (IBAction)btndetailPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PoliciesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PoliciesController"];
    dc.stype = @"2000";
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnbirthPress:(id)sender {
    picker = [[UIDatePicker alloc] init];
    picker.backgroundColor = [UIColor whiteColor];
    [picker setValue:[UIColor blackColor] forKey:@"textColor"];
    
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    picker.datePickerMode = UIDatePickerModeDate;
    
    [picker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    picker.frame = CGRectMake(0.0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 300);
    [self.view addSubview:picker];
    
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 50)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneButtonClick)]];
    [toolbar sizeToFit];
    [self.view addSubview:toolbar];
}

-(void) dueDateChanged:(UIDatePicker *)sender {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dateformater1 = [[NSDateFormatter alloc] init];
    [dateformater1 setDateFormat:@"yyyyMMdd"];
    //[dateFormatter setDateStyle:NSDateFormatterLongStyle];
    //[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-14];
    NSDate *sevenDaysAgo = [gregorian dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
    NSLog(@"Picked the date %@  %@",[dateformater1 stringFromDate:sevenDaysAgo], [dateformater1 stringFromDate:[sender date]]);
    if ([[dateformater1 stringFromDate:sevenDaysAgo] intValue] < [[dateformater1 stringFromDate:[sender date]] intValue]) {
        [FSToast showToast:self messge:@"만 14세 이상만 가능합니다."];
        return;
    } else {
        self.selectbirth = [dateformater1 stringFromDate:[sender date]];
        NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
        self.lblbirth.text = [dateFormatter stringFromDate:[sender date]];
    }
}

-(void)onDoneButtonClick {
    [toolbar removeFromSuperview];
    [picker removeFromSuperview];
}

- (IBAction)btnmanPress:(id)sender {
    self.btnman.selected = true;
    self.btnwoman.selected = false;
    [self.btnman setBackgroundColor:[UIColor colorWithRed:(239.0f/255.0f) green:(0.0f/255.0f) blue:(126.0f/255.0f) alpha:1]];
    self.btnwoman.backgroundColor = [UIColor whiteColor];
}

- (IBAction)btnwomanPress:(id)sender {
    self.btnman.selected = false;
    self.btnwoman.selected = true;
    [self.btnwoman setBackgroundColor:[UIColor colorWithRed:(239.0f/255.0f) green:(0.0f/255.0f) blue:(126.0f/255.0f) alpha:1]];
    self.btnman.backgroundColor = [UIColor whiteColor];
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
    authview.hidden = YES;
    self.authphone = self.txtphone.text;
    
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
