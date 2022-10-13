//
//  FireController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "FireController.h"
#import "FXBlurView.h"
#import "UIImage+BlurredFrame.h"
#import "User.h"

@interface FireController ()

@end

@implementation FireController
@synthesize btncheck2, btncheck4, btncheck3, btnfire, btncheck1, txtcont, txtpassword, scrollView, passwordview, lblcheck1, lblcheck2, lblcheck3, lblcheck4, blurView, imgblur, btnok, popupview;
static CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
NSString *stype;

- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"회원 탈퇴";
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
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 900)];
    
    self.popupview.layer.cornerRadius = 10;
    self.popupview.layer.borderColor = [[UIColor colorWithRed:(232.0/255.0f) green:(232.0/255.0f) blue:(232.0/255.0f) alpha:1] CGColor];
    self.popupview.layer.borderWidth = 1;
    self.popupview.layer.shadowColor = [[UIColor colorWithRed:(242.0/255.0f) green:(242.0/255.0f) blue:(242.0/255.0f) alpha:1] CGColor];
    self.popupview.layer.shadowOffset = CGSizeMake(10, 10);
    self.popupview.layer.shadowRadius = 10;
    self.popupview.layer.shadowOpacity = 0.5;
    
    self.btnok.layer.cornerRadius = 10;
    
    User *user = [User sharedInstance];
    if ([user.sns_id isEqualToString:@""]) {
        self.passwordview.hidden = NO;
    } else {
        self.passwordview.hidden = YES;
    }
    
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btncheck1Press:(id)sender {
    self.btncheck1.selected = !self.btncheck1.selected;
    self.lblcheck1.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck2.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck3.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck4.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    
    if (self.btncheck1.selected) {
        stype = @"1000";
        self.lblcheck1.textColor = [UIColor colorWithRed:(239.0/255.0f) green:(0.0/255.0f) blue:(126.0/255.0f) alpha:1];
        self.btncheck2.selected = false;
        self.btncheck3.selected = false;
        self.btncheck4.selected = false;
        self.txtcont.text = @"";
    }
}

- (IBAction)btncheck2Press:(id)sender {
    self.btncheck2.selected = !self.btncheck2.selected;
    self.lblcheck1.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck2.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck3.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck4.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    if (self.btncheck2.selected) {
        stype = @"2000";
        self.lblcheck2.textColor = [UIColor colorWithRed:(239.0/255.0f) green:(0.0/255.0f) blue:(126.0/255.0f) alpha:1];
        self.btncheck1.selected = false;
        self.btncheck3.selected = false;
        self.btncheck4.selected = false;
        self.txtcont.text = @"";
    }
}

- (IBAction)btncheck3Press:(id)sender {
    self.btncheck3.selected = !self.btncheck3.selected;
    self.lblcheck1.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck2.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck3.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck4.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    if (self.btncheck3.selected) {
        stype = @"3000";
        self.lblcheck3.textColor = [UIColor colorWithRed:(239.0/255.0f) green:(0.0/255.0f) blue:(126.0/255.0f) alpha:1];
        self.btncheck2.selected = false;
        self.btncheck1.selected = false;
        self.btncheck4.selected = false;
        self.txtcont.text = @"";
    }
}

- (IBAction)btncheck4Press:(id)sender {
    self.btncheck4.selected = !self.btncheck4.selected;
    self.lblcheck1.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck2.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck3.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    self.lblcheck4.textColor = [UIColor colorWithRed:(85.0/255.0f) green:(85.0/255.0f) blue:(85.0/255.0f) alpha:1];
    if (self.btncheck4.selected) {
        stype = @"4000";
        self.lblcheck4.textColor = [UIColor colorWithRed:(239.0/255.0f) green:(0.0/255.0f) blue:(126.0/255.0f) alpha:1];
        self.btncheck2.selected = false;
        self.btncheck3.selected = false;
        self.btncheck1.selected = false;
        self.txtcont.text = @"";
    }
}

- (IBAction)btnfirePress:(id)sender {
    if ([stype isEqualToString:@""]) {
        [FSToast showToast:self messge:@"탈퇴사유를 선택하십시요."];
        return;
    }
    
    if (!self.passwordview.isHidden) {
        if ([self.txtpassword.text isEqualToString:@""]) {
            [FSToast showToast:self messge:@"비밀번호를 입력하십시요."];
            return;
        }
    }
    
    NSDictionary *resultdict = [ApiHandler fireuser:stype reason:txtcont.text password:self.txtpassword.text];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        UIImage *img = [self viewToImage:self.view];
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        img = [img applyLightEffectAtFrame:frame];
     
        self.imgblur.image = img;
        self.blurView.hidden = NO;
    } else {
        [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
    }
}

- (IBAction)btnokPress:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIImage*)viewToImage:(UIView*)view {
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:view.bounds.size];
    UIImage *image = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    }];
    return image;
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

@end
