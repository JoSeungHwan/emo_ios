//
//  AddInfoBirthController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "AddInfoBirthController.h"
#import "AddInfoGenderController.h"
#import "ProfileController.h"
#import "PoliciesController.h"

@interface AddInfoBirthController ()

@end

@implementation AddInfoBirthController
@synthesize btnnext, btndate, btncheck, btndetail, lbldate, pc;
bool checkuse = false;

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
    [super viewDidLoad];
}

- (IBAction)btnnextPress:(id)sender {
    if (checkuse) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:@"Y" forKey:@"additional_privacy_agree"];
        if ([[defaults objectForKey:@"method"] isEqualToString:@""]) {
            
            [defaults setValue:self.lbldate.text forKey:@"reg_birth"];
    
        } else {
            [defaults setObject:self.lbldate.text forKey:@"sns_birth"];
        }
        [defaults synchronize];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        AddInfoGenderController *dc = [storyboard instantiateViewControllerWithIdentifier:@"AddInfoGenderController"];
       
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        
        self.pc.popuptype = @"autherror";
        [self.pc.btnauthok addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:popupview];
        [self.pc startview];
        
    }
}

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

- (IBAction)btnskipPress:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"method"] isEqualToString:@""]) {
        [defaults setValue:@"N" forKey:@"additional_privacy_agree"];
        [defaults setValue:@"" forKey:@"reg_birth"];
        [defaults setValue:@"" forKey:@"reg_gender"];
        [defaults setValue:@"" forKey:@"reg_phone"];
    } else {
        [defaults setValue:@"N" forKey:@"additional_privacy_agree"];
        [defaults setValue:@"" forKey:@"sns_birth"];
        [defaults setValue:@"" forKey:@"sns_gender"];
        [defaults setValue:@"" forKey:@"sns_phone"];
        
    }

    [defaults synchronize];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    ProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileController"];
   
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btncheckPress:(id)sender {
    self.btncheck.selected = !self.btncheck.selected;
    checkuse = self.btncheck.selected;
    if (checkuse) {
        self.btnnext.backgroundColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
    } else {
        self.btnnext.backgroundColor = [UIColor colorWithRed:(70.0f/255.0f) green:(70.0f/255.0f) blue:(70.0f/255.0f) alpha:1];
    }
}

- (IBAction)btndetailPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    PoliciesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PoliciesController"];
    dc.stype = @"2000";
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btndatePress:(id)sender {
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
    //[dateFormatter setDateStyle:NSDateFormatterLongStyle];
    //[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-14];
    NSDate *sevenDaysAgo = [gregorian dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
    
    if (sevenDaysAgo < [sender date]) {
        [FSToast showToast:self messge:@"만 14세 이상만 가능합니다."];
        return;
    } else {
        NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
        self.lbldate.text = [dateFormatter stringFromDate:[sender date]];
    }
}

-(void)onDoneButtonClick {
    [toolbar removeFromSuperview];
    [picker removeFromSuperview];
}

@end
