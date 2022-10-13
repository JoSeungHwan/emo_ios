//
//  PoliciesController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "PoliciesController.h"
#import "CZPicker/CZPicker.h"

@interface PoliciesController ()

@end

@implementation PoliciesController
@synthesize webView, stype, lblsubject, btnhistory;

- (void)viewDidLoad {
    self.historyarray = [[NSMutableArray alloc] init];
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"서비스 이용약관";
    lbltitle.font = [UIFont fontWithName:@"SBAggroB" size:18];
    lbltitle.textColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
    self.navigationItem.titleView = lbltitle;
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setFrame:CGRectMake(0, 0, 44, 44)];
   
    UIBarButtonItem *leftbarbtn = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem =leftbarbtn;
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setFrame:CGRectMake(0, 0, 44, 44)];
    [rightbtn setImage:[UIImage imageNamed:@"btnclose"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(btnbackPress:) forControlEvents:UIControlEventTouchUpInside];
  
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];

    
    NSDictionary *resultdict = [ApiHandler policies];
    NSLog(@"%@",[resultdict description]);
    NSArray *arr = [resultdict objectForKey:@"data"];
    
    for (int i = 0 ; i < [arr count] ; i ++) {
        NSDictionary *dt = [arr objectAtIndex:i];
        if ([[dt objectForKey:@"type_code"] isEqualToString:self.stype]) {
            [self.historyarray addObject:dt];
            if ([self.historyarray count] == 1) {
                [self.btnhistory setTitle:[dt objectForKey:@"start_at"] forState:UIControlStateNormal];
                [self.webView loadHTMLString:[dt objectForKey:@"content"] baseURL:nil];
            }
        }
    }
    

    if ([self.stype isEqualToString:@"1000"]) {
        self.lblsubject.text = @"서비스 이용약관";
        lbltitle.text = @"서비스 이용약관";
    } else if ([self.stype isEqualToString:@"2000"]) {
        self.lblsubject.text = @"개인정보수집 및 이용동의";
        lbltitle.text = @"개인정보수집 및 이용동의";
    } else if ([self.stype isEqualToString:@"3000"]) {
        self.lblsubject.text = @"마케팅 정보수신 동의";
        lbltitle.text = @"마케팅 동의";
    } else if ([self.stype isEqualToString:@"4000"]) {
        self.lblsubject.text = @"개인정보 처리방침";
        lbltitle.text = @"개인정보 처리방침";
    } else if ([self.stype isEqualToString:@"5000"]) {
        self.lblsubject.text = @"통합계정약관";
        lbltitle.text = @"OK벤처스 통합 계정 약관";
    }
    
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnhistoryPress:(id)sender {
   /* CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"날짜선택"
                            cancelButtonTitle:@"Cancel"
                            confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.needFooterView = YES;
    [picker show];*/

    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"날짜선택" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    [picker showInContainer:self.view];
}

/* comment out this method to allow
 CZPickerView:titleForRow: to work.
 */
- (NSAttributedString *)czpickerView:(CZPickerView *)pickerView
               attributedTitleForRow:(NSInteger)row{
    NSDictionary *dt = self.historyarray[row];
    NSAttributedString *att = [[NSAttributedString alloc]
                               initWithString:[dt objectForKey:@"start_at"]
                               attributes:@{
                                            NSFontAttributeName:[UIFont fontWithName:@"SBAggroB" size:18.0]
                                            }];
    return att;
}

- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    NSDictionary *dt = self.historyarray[row];
    return [dt objectForKey:@"start_at"];
}

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    return self.historyarray.count;
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    NSDictionary *dt = self.historyarray[row];
    NSLog(@"%@ is chosen!", [dt objectForKey:@"start_at"]);
    [self.webView loadHTMLString:[dt objectForKey:@"content"] baseURL:nil];
    [self.btnhistory setTitle:[dt objectForKey:@"start_at"] forState:UIControlStateNormal];
   
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows {
    for (NSNumber *n in rows) {
        NSInteger row = [n integerValue];
        NSDictionary *dt = self.historyarray[row];
        [self.webView loadHTMLString:[dt objectForKey:@"content"] baseURL:nil];
        [self.btnhistory setTitle:[dt objectForKey:@"start_at"] forState:UIControlStateNormal];
        NSLog(@"%@ is chosen!", [dt objectForKey:@"start_at"]);
    }
}

- (void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView {

    NSLog(@"Canceled.");
}

- (void)czpickerViewWillDisplay:(CZPickerView *)pickerView {
    NSLog(@"Picker will display.");
}

- (void)czpickerViewDidDisplay:(CZPickerView *)pickerView {
    NSLog(@"Picker did display.");
}

- (void)czpickerViewWillDismiss:(CZPickerView *)pickerView {
    NSLog(@"Picker will dismiss.");
}

- (void)czpickerViewDidDismiss:(CZPickerView *)pickerView {
    NSLog(@"Picker did dismiss.");
}

@end
