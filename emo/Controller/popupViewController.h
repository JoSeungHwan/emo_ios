//
//  popupViewController.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/19.
//

#ifndef popupViewController_h
#define popupViewController_h

@interface popupViewController : UIViewController {
    UIView *loginview;
    UIView *bgview;
    UIButton *btnback, *btnsendmail;
    NSString *popuptype;
    UIButton *btnlogin;
    UIView *emailloginview, *emailinputview, *emailpwview, *sendemailview, *authcheckview, *authview, *myinfoview, *nickokview, *nickuseview;
    UIView *phoneauth, *phoneauthcomplate, *emoticonorderView, *myprofilemoreview, *myprofilemoreview1;
    UIView *chatview, *promotionview;
    UIButton *btnmyreply, *btnmyroom, *btnmyreply1, *btnmyroom1, *btngrade;
    UIButton *btncheck, *btnemaillogin, *btnauthok, *btndraw, *btnpic, *btncamera, *btnreset, *btnchat, *btnpromotion;
    UITextField *txtemail, *txtpw;
    UIImageView *imgEmailloginbg, *imgphoneauthok, *imgphoneauth, *imgauthcheck, *imgauth, *imgmyinfo, *imgnickcheck, *imgnickok, *imgsendmail, *imgbookmark;
    UIButton *btnedit, *btndelete, *btnshare, *btnlink, *btnshare1, *btnlink1, *btnbookmark, *btnreport, *btnreport1, *btnreplyedit, *btnreplydelete;
    UIView *shareview, *linkview, *contentmymore, *contentmore, *shareview1, *linkview1, *bookmarkview, *replymoreview, *myreplymoreview, *reportview;
    UILabel *lblbookmark;
    UIView *reportitemtop, *reportitembottom;
    UIButton *btnreportcheck1, *btnreportcheck2, *btnreportcheck3, *btnreportcheck4, *btnreportcheck5, *btnreportcheck6, *btnreportcheck7 , *btnreportcheck8, *btnreportsend, *btnsave;
    UITextView *txtreplort;
    UIView *settingView, *settingitemView1, *settingitemView2, *settingitemView3, *categoryview, *userprofileview, *myemoticonview;
    UIButton *btnfollowingcheck, *btntooncheck, *btnreplytooncheck, *btnemoticoncheck, *btnuserreply, *btnlock, *btndona, *btnorderemoticon, *btnmyemoticon;
    
}
@property (nonatomic, retain) IBOutlet UIImageView *imgEmailloginbg, *imgphoneauthok, *imgphoneauth, *imgauthcheck, *imgauth, *imgmyinfo, *imgnickcheck, *imgnickok, *imgsendmail, *imgbookmark;
@property (nonatomic, retain) IBOutlet UIButton *btnback;
@property (nonatomic, retain) IBOutlet UIView *bgview;
@property (nonatomic, retain) IBOutlet UIView *loginview;
@property (nonatomic, retain) IBOutlet UIButton *btnlogin, *btnsendmail, *btnmyreply, *btnmyroom, *btnmyreply1, *btnmyroom1, *btngrade;
@property (nonatomic, retain) IBOutlet UIView *emailloginview, *emailinputview, *emailpwview, *sendemailview, *authcheckview, *authview, *myinfoview, *nickokview, *nickuseview, *emoticonorderView;
@property (nonatomic, retain) IBOutlet UIView *phoneauth, *phoneauthcomplate, *myprofilemoreview, *chatview, *promotionview, *myprofilemoreview1;
@property (nonatomic, retain) IBOutlet UIButton *btncheck, *btnemaillogin, *btnauthok, *btndraw, *btnpic, *btncamera, *btnreset, *btnchat, *btnpromotion;
@property (nonatomic, retain) IBOutlet UITextField *txtemail, *txtpw;
@property (nonatomic, retain) IBOutlet UIButton *btnedit, *btndelete, *btnshare, *btnlink, *btnshare1, *btnlink1, *btnbookmark, *btnreport, *btnreport1, *btnreplyedit, *btnreplydelete;
@property (nonatomic, retain) IBOutlet UIView *shareview, *linkview, *contentmymore, *contentmore, *shareview1, *linkview1, *bookmarkview, *replymoreview, *myreplymoreview, *reportview;
@property (nonatomic, retain) IBOutlet UILabel *lblbookmark;
@property (nonatomic, retain) IBOutlet UIView *reportitemtop, *reportitembottom;
@property (nonatomic, retain) IBOutlet UIButton *btnreportcheck1, *btnreportcheck2, *btnreportcheck3, *btnreportcheck4, *btnreportcheck5, *btnreportcheck6, *btnreportcheck7,  *btnreportcheck8, *btnreportsend;
@property (nonatomic, retain) IBOutlet UITextView *txtreplort;
@property (nonatomic, retain) IBOutlet UIView *settingView, *settingitemView1, *settingitemView2, *settingitemView3, *categoryview, *userprofileview, *myemoticonview;
@property (nonatomic, retain) IBOutlet UIButton *btnfollowingcheck, *btntooncheck, *btnreplytooncheck, *btnemoticoncheck, *btnsave, *btnuserreply, *btnlock, *btndona, *btnorderemoticon, *btnmyemoticon;
@property (nonatomic, retain) NSMutableArray *categoryList;

@property NSString *popuptype;

- (void)startview;
- (void)hidenview;
- (IBAction)backgroundPress:(id)sender;
- (IBAction)btnloginPress:(id)sender;


@end

#endif /* popupViewController_h */
