//
//  popupViewController.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/19.
//

#import <Foundation/Foundation.h>
#import "popupViewController.h"
#import "LoginController.h"
#import "Common.h"
@interface popupViewController ()

@end

@implementation popupViewController
@synthesize loginview, popuptype, btnback, bgview, btnlogin, btncheck, btnemaillogin, emailpwview, emailinputview, emailloginview, txtpw, txtemail, sendemailview, btnsendmail, authcheckview, authview, btnauthok, btnpic, btndraw, btncamera, btnreset, nickokview, myinfoview, phoneauth, phoneauthcomplate, emoticonorderView, nickuseview, imgauth, imgmyinfo, imgnickok, imgsendmail, imgauthcheck, imgnickcheck, imgphoneauth, imgphoneauthok, imgEmailloginbg, btngrade, btnmyroom, btnmyreply, btnchat, btnmyroom1, btnmyreply1, btnpromotion, promotionview, chatview, myprofilemoreview, myprofilemoreview1, myreplymoreview, reportview, replymoreview, reportitemtop, reportitembottom, contentmore, contentmymore, btnedit, btnsave, btndelete, btnreport, btnreportsend, btnlink, btnlink1, btnshare, btnshare1, btnreport1, btnbookmark, btnreplyedit, btntooncheck, btnreplydelete, btnreportcheck1, btnreportcheck2, btnreportcheck3, btnreportcheck4, btnreportcheck5, btnreportcheck6, btnreportcheck7, settingView, btnreportcheck8, btnemoticoncheck, btnfollowingcheck, btnreplytooncheck, txtreplort, lblbookmark, settingitemView3, settingitemView1, settingitemView2, linkview, linkview1, shareview, shareview1, bookmarkview;

- (void)viewDidLoad {
    self.btnauthok.layer.cornerRadius = 10;
    self.btnemaillogin.layer.cornerRadius = 10;
    self.btnreset.layer.cornerRadius = 10;
    
    self.chatview.layer.cornerRadius = 10;
    self.promotionview.layer.cornerRadius = 10;
    
    [self roundTopCornersOfView:self.btnmyroom by:10];
    [self roundBottomCornersOfView:self.btnmyreply by:10];
    [self roundTopCornersOfView:self.btnmyroom1 by:10];
    [self roundBottomCornersOfView:self.btnmyreply1 by:10];
    [self roundTopCornersOfView:self.btndelete by:10];
    [self roundBottomCornersOfView:self.btnedit by:10];
    [self roundTopCornersOfView:self.btnreplydelete by:10];
    [self roundBottomCornersOfView:self.btnreplyedit by:10];
    [self roundTopCornersOfView:self.reportitembottom by:10];
    [self roundBottomCornersOfView:self.reportitemtop by:10];
    
    [self roundTopCornersOfView:self.btnlock by:10];
    [self roundBottomCornersOfView:self.btnuserreply by:10];
    
    [self roundTopCornersOfView:self.btnmyemoticon by:10];
    [self roundBottomCornersOfView:self.btnorderemoticon by:10];
    
    self.btngrade.layer.cornerRadius = 10;
    self.shareview.layer.cornerRadius = 10;
    self.linkview.layer.cornerRadius = 10;
    self.shareview1.layer.cornerRadius = 10;
    self.linkview1.layer.cornerRadius = 10;
    self.bookmarkview.layer.cornerRadius = 10;
    self.btnreport.layer.cornerRadius = 10;
    self.btnreport1.layer.cornerRadius = 10;
    self.btnreportsend.layer.cornerRadius = 10;
    
    self.settingitemView1.layer.cornerRadius = 20;
    self.settingitemView2.layer.cornerRadius = 20;
    self.settingitemView3.layer.cornerRadius = 20;
    
    self.btndona.layer.cornerRadius = 10;
    
    self.btnsave.layer.cornerRadius = 10;
    
    Common *common = [Common sharedInstance];
    int ihet = 0;
    ihet = round([common.contentcategory count] / 2) * 50;
    
    self.settingView.frame = CGRectMake(0, self.settingView.frame.origin.y, self.view.frame.size.width, 460 + ihet);
       
    //560;
    self.categoryList = [[NSMutableArray alloc] init];
    int frameh = 0;
    int wd = self.settingitemView3.frame.size.width/2;
    if ([common.contentcategory count] > 0 ) {
        for (int i = 0 ; i < [common.contentcategory count] ; i++) {
            NSDictionary *dict = [common.contentcategory objectAtIndex:i];
            if (i > 0) {
                if (i % 2 == 0) {
                    frameh = frameh + 35;
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"check1"] forState:UIControlStateHighlighted];
                    [btn setImage:[UIImage imageNamed:@"check1"] forState:UIControlStateSelected];
                    btn.tag = [[dict objectForKey:@"code"] intValue];
                    btn.frame = CGRectMake(20, frameh+10, 31, 31);
                    [self.categoryview addSubview:btn];
                    
                    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(60, frameh+10, 100, 31)];
                    lbl.text = [dict objectForKey:@"name"];
                    lbl.textColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
                    lbl.font = [UIFont fontWithName:@"NotoSansKR-Regular" size:13.0] ;
                    [self.categoryview addSubview:lbl];
                    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:btn,@"button",dict,@"data", nil];
                    [self.categoryList addObject:dic];
                } else {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"check1"] forState:UIControlStateHighlighted];
                    [btn setImage:[UIImage imageNamed:@"check1"] forState:UIControlStateSelected];
                    btn.tag = [[dict objectForKey:@"code"] intValue];
                    btn.frame = CGRectMake(20 +wd, frameh+10, 31, 31);
                    [self.categoryview addSubview:btn];
                    
                    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(60 + wd, frameh+10, 100, 31)];
                    lbl.text = [dict objectForKey:@"name"];
                    lbl.textColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
                    lbl.font = [UIFont fontWithName:@"NotoSansKR-Regular" size:13.0] ;
                    [self.categoryview addSubview:lbl];
                    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:btn,@"button",dict,@"data", nil];
                    [self.categoryList addObject:dic];
                }
            } else {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"check1"] forState:UIControlStateHighlighted];
                [btn setImage:[UIImage imageNamed:@"check1"] forState:UIControlStateSelected];
                btn.tag = [[dict objectForKey:@"code"] intValue];
                btn.frame = CGRectMake(20, 10, 31, 31);
                [self.categoryview addSubview:btn];
                
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 31)];
                lbl.text = [dict objectForKey:@"name"];
                lbl.textColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
                lbl.font = [UIFont fontWithName:@"NotoSansKR-Regular" size:13.0] ;
                [self.categoryview addSubview:lbl];
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:btn,@"button",dict,@"data", nil];
                [self.categoryList addObject:dic];
                
            }
        }
    }
    
    [super viewDidLoad];
}

-(void)roundBottomCornersOfView: (UIView*) view by: (NSInteger) radius {
    CGRect rect = view.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                         byRoundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight
                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layers = [CAShapeLayer layer];
    layers.frame = rect;
    layers.path = path.CGPath;
    view.layer.mask = layers;

    CAShapeLayer*   borderShape = [CAShapeLayer layer];
    borderShape.frame = rect;
    borderShape.path = path.CGPath;
    borderShape.fillColor = nil;
    [view.layer addSublayer:borderShape];
}

-(void)roundTopCornersOfView: (UIView*) view by: (NSInteger) radius {
    CGRect rect = view.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                         byRoundingCorners:UIRectCornerBottomLeft |UIRectCornerBottomRight
                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layers = [CAShapeLayer layer];
    layers.frame = rect;
    layers.path = path.CGPath;
    view.layer.mask = layers;

    CAShapeLayer*   borderShape = [CAShapeLayer layer];
    borderShape.frame = rect;
    borderShape.path = path.CGPath;
 
    borderShape.fillColor = nil;
 
    [view.layer addSublayer:borderShape];
}

- (void)animationview:(UIView *)contentView {
    [self.view bringSubviewToFront:contentView];
           
    CGRect rectformedicationTableViewcell;// = CGRectZero;

    rectformedicationTableViewcell = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, contentView.frame.size.height);

    contentView.frame = rectformedicationTableViewcell;

    if([contentView superview]) {
        contentView.hidden = YES;
    }
    contentView.hidden = NO;

    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                           [contentView setFrame:CGRectMake(0.0f, self.view.frame.size.height - contentView.frame.size.height, self.view.frame.size.width, contentView.frame.size.height)];

                     }
                     completion:nil];
}


- (void)startview {
    if ([self.popuptype isEqualToString:@"login"]) {
        [self.view bringSubviewToFront:self.loginview];
        UIImage *img = [UIImage imageNamed:@"loginpopupbg.png"];
        float scale = img.size.width / self.view.frame.size.width;
        
        CGRect rectformedicationTableViewcell;// = CGRectZero;

        rectformedicationTableViewcell = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, img.size.height / scale);

        self.loginview.frame = rectformedicationTableViewcell;

        if([self.loginview superview]) {
            self.loginview.hidden = YES;
        }
        self.loginview.hidden = NO;

        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                               [self.loginview setFrame:CGRectMake(0.0f, self.view.frame.size.height - img.size.height / scale, self.view.frame.size.width, img.size.height / scale)];

                         }
                         completion:nil];
    } else if ([self.popuptype isEqualToString:@"emaillogin"]) {
        [self animationview:self.emailloginview];
        
    } else if ([self.popuptype isEqualToString:@"sendemail"]) {
        [self animationview:self.sendemailview];
        
    } else if ([self.popuptype isEqualToString:@"emailauthcomplate"]) {
        [self animationview:self.authcheckview];
        
    }  else if ([self.popuptype isEqualToString:@"autherror"]) {
        [self animationview:self.authview];
       
    }  else if ([self.popuptype isEqualToString:@"useredit"]) {
        [self animationview:self.myinfoview];
        
    } else if ([self.popuptype isEqualToString:@"nickcheckok"]) {
        [self animationview:self.nickokview];
       
    } else if ([self.popuptype isEqualToString:@"nickcheckerror"]) {
        [self animationview:self.nickuseview];
       
    } else if ([self.popuptype isEqualToString:@"phoneauth"]) {
        [self animationview:self.phoneauth];
        
    } else if ([self.popuptype isEqualToString:@"phoneauthcompate"]) {
        [self animationview:self.phoneauthcomplate];
        
    } else if ([self.popuptype isEqualToString:@"emoticonordercomplate"]) {
        [self animationview:self.emoticonorderView];
        
    } else if ([self.popuptype isEqualToString:@"myprofile"]) {
        [self animationview:self.myprofilemoreview];
    } else if ([self.popuptype isEqualToString:@"myprofile1"]) {
        [self animationview:self.myprofilemoreview1];
    } else if ([self.popuptype isEqualToString:@"mycontentmore"]) {
        [self animationview:self.contentmymore];
    } else if ([self.popuptype isEqualToString:@"contentmore"]) {
        [self animationview:self.contentmore];
    } else if ([self.popuptype isEqualToString:@"myrepliemore"]) {
        [self animationview:self.myreplymoreview];
    } else if ([self.popuptype isEqualToString:@"repliemore"]) {
        [self animationview:self.replymoreview];
    } else if ([self.popuptype isEqualToString:@"report"]) {
        [self animationview:self.reportview];
    } else if ([self.popuptype isEqualToString:@"setting"]) {
        [self animationview:self.settingView];
    } else if ([self.popuptype isEqualToString:@"userprofile"]) {
        [self animationview:self.userprofileview];
    } else if ([self.popuptype isEqualToString:@"myemoticon"]) {
        [self animationview:self.myemoticonview];
    } else if ([self.popuptype isEqualToString:@"reportcomplate"]) {
        
    }
}

- (void)anihideview:(UIView *)contentView {
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                           [contentView setFrame:CGRectMake(0.0f, self.view.frame.size.height , self.view.frame.size.width, contentView.frame.size.height)];

                     }
                     completion:^(BOOL finished){
        [UIView animateWithDuration:1.0 animations:^{[self.bgview removeFromSuperview];}];
    }];
}

- (void)hidenview {
    if ([self.popuptype isEqualToString:@"login"]) {
        [self anihideview:self.loginview];

        
    } else if ([self.popuptype isEqualToString:@"emaillogin"]) {
        [self anihideview:self.emailloginview];
        
    } else if ([self.popuptype isEqualToString:@"sendemail"]) {
        [self anihideview:self.sendemailview];
        
    } else if ([self.popuptype isEqualToString:@"emailauthcomplate"]) {
        [self anihideview:self.authcheckview];
        
    } else if ([self.popuptype isEqualToString:@"autherror"]) {
        [self anihideview:self.authview];
       
    } else if ([self.popuptype isEqualToString:@"useredit"]) {
        [self anihideview:self.myinfoview];
        
    } else if ([self.popuptype isEqualToString:@"nickcheckok"]) {
        [self anihideview:self.nickokview];
       
    } else if ([self.popuptype isEqualToString:@"nickcheckerror"]) {
        [self anihideview:self.nickuseview];
       
    } else if ([self.popuptype isEqualToString:@"phoneauth"]) {
        [self anihideview:self.phoneauth];
        
    } else if ([self.popuptype isEqualToString:@"phoneauthcomplate"]) {
        [self anihideview:self.phoneauthcomplate];
        
    } else if ([self.popuptype isEqualToString:@"emoticonordercomplate"]) {
        [self anihideview:self.emoticonorderView];
        
    } else if ([self.popuptype isEqualToString:@"myprofile"]) {
        [self anihideview:self.myprofilemoreview];
    } else if ([self.popuptype isEqualToString:@"myprofile1"]) {
        [self anihideview:self.myprofilemoreview1];
    } else if ([self.popuptype isEqualToString:@"mycontentmore"]) {
        [self anihideview:self.contentmymore];
    } else if ([self.popuptype isEqualToString:@"contentmore"]) {
        [self anihideview:self.contentmore];
    } else if ([self.popuptype isEqualToString:@"myrepliemore"]) {
        [self anihideview:self.myreplymoreview];
    } else if ([self.popuptype isEqualToString:@"repliemore"]) {
        [self anihideview:self.replymoreview];
    } else if ([self.popuptype isEqualToString:@"report"]) {
        [self anihideview:self.reportview];
    } else if ([self.popuptype isEqualToString:@"setting"]) {
        [self anihideview:self.settingView];
    } else if ([self.popuptype isEqualToString:@"userprofile"]) {
        [self anihideview:self.userprofileview];
    } else if ([self.popuptype isEqualToString:@"myemoticon"]) {
        [self anihideview:self.myemoticonview];
    } else if ([self.popuptype isEqualToString:@"reportcomplate"]) {
        
    }
    
   // [self.bgview removeFromSuperview];
    
}

- (IBAction)backgroundPress:(id)sender {
   // [self.bgview removeFromSuperview];
}


@end
