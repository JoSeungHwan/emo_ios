//
//  UserEditController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "UserEditController.h"
#import "User.h"
#import "PasswordAddController.h"
#import "PasswordChangeController.h"
#import "EmailAddController.h"
#import "EditAddinfoController.h"
#import "EmailChangeController.h"
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>
#import <KakaoOpenSDK/KakaoOpenSDK.h>

@interface UserEditController ()

@end

@implementation UserEditController
@synthesize btnapple, btnbirth, btnemail, btnkakao, btnnaver, btnphone, btngoogle, btnpassword, lblbirth, lblphone, lblemail, lblapple, lblnaver, lblkakao, lblgoogle, lblpassword, scrollView, kakaoview, googlecont, googleview, kakaocont, navercont, naverview, applecont, appleview, emailcont;

- (void)viewDidLoad {
    _thirdPartyLoginConn = [NaverThirdPartyLoginConnection getSharedInstance];
    _thirdPartyLoginConn.delegate = self;
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"설정";
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
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    User *user = [User sharedInstance];
    
    if (![user.linked_sns isEqualToString:@""]) {
        if ([user.linked_sns isEqualToString:@"1000"]) {
            self.kakaoview.hidden = NO;
            self.appleview.hidden = YES;
            self.googleview.hidden = YES;
            self.naverview.hidden = YES;
            self.lblkakao.text = @"해제";
        } else if ([user.linked_sns isEqualToString:@"2000"]) {
            self.kakaoview.hidden = YES;
            self.appleview.hidden = YES;
            self.googleview.hidden = YES;
            self.naverview.hidden = NO;
            self.lblnaver.text = @"해제";
            
            self.navercont.constant = 16;
        } else if ([user.linked_sns isEqualToString:@"3000"]) {
            self.kakaoview.hidden = YES;
            self.appleview.hidden = YES;
            self.googleview.hidden = NO;
            self.naverview.hidden = YES;
            self.lblgoogle.text = @"해제";
            self.googlecont.constant = 16;
        } else if ([user.linked_sns isEqualToString:@"4000"]) {
            self.kakaoview.hidden = YES;
            self.appleview.hidden = NO;
            self.googleview.hidden = YES;
            self.naverview.hidden = YES;
            self.lblapple.text = @"해제";
            self.applecont.constant = 16;
        }
        self.emailcont.constant = 110;
    } else {
        [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 780)];
    }
    
    if (![user.email isEqualToString:@""]) {
        self.lblemail.text = user.email;
    } else {
        self.lblemail.text = @"등록";
    }
    
    if (user.password_regist == 0) {
        self.lblpassword.text = @"등록";
    } else {
        self.lblpassword.text = @"변경";
    }
    NSString *addinfo = @"";
    if (![user.birth isEqualToString:@""]) {
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyyMMdd"];
        
        NSDateFormatter *dateformat1 = [[NSDateFormatter alloc] init];
        [dateformat1 setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *birthdt = [dateformat dateFromString:user.birth];
        addinfo = [dateformat1 stringFromDate:birthdt];
        
    }
    
    if (![user.gender isEqualToString:@""]) {
        if ([user.gender isEqualToString:@"M"]) {
            if ([addinfo isEqualToString:@""]) {
                addinfo = @"남";
            } else {
                addinfo = [addinfo stringByAppendingFormat:@"/ 남"];
            }
        } else {
            if ([addinfo isEqualToString:@""]) {
                addinfo = @"여";
            } else {
                addinfo = [addinfo stringByAppendingFormat:@"/ 여"];
            }
        }
    }
    
    if ([addinfo isEqualToString:@""]) {
        self.lblbirth.text = @"등록";
    } else {
        self.lblbirth.text = addinfo;
    }
    
    if (![user.phone isEqualToString:@""]) {
        self.lblphone.text = user.phone;
    } else {
        self.lblphone.text = @"등록";
    }
    [super viewWillAppear:animated];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)kakaoSessionDidChangeWithNotification {
    BOOL isOpened = [KOSession sharedSession].isOpen;
    
    if (isOpened) {
        [self requestMe:YES];
    }
    
}

- (void)requestMe:(BOOL)displayResult {
    
    // 사용자 정보 요청
    [KOSessionTask userMeTaskWithCompletion:^(NSError *error, KOUserMe *me) {
        if (error) {
           // [UIAlertController showMessage:error.description];
            
        } else {
            if (displayResult) {
                KOSession *session = [KOSession sharedSession];
                NSString *accessToken = session.token.accessToken;
                
                NSString *email = me.account.email;
                NSString *photoUrl = me.profileImageURL.absoluteString;
                NSString *nickname = me.nickname;
                // 결과 보여주기
                NSMutableString *message = [NSMutableString string];
                
                [message appendString:@"아이디: "];
                [message appendString:me.ID ? me.ID : @"없음 (signup 필요)"];
                
                if (me.properties) {
                    [message appendFormat:@"\n\n== 사용자 속성 ==\n%@", me.properties];
                }
                
                
            
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"Y" forKey:@"autologin"];
                [defaults setObject:@"1000" forKey:@"method"];
                [defaults setObject:me.ID forKey:@"snsid"];
                [defaults setObject:nickname forKey:@"sns_nickname"];
                [defaults setObject:email forKey:@"snsemail"];
                [defaults setObject:accessToken forKey:@"accessToken"];
                [defaults setObject:photoUrl forKey:@"sns_profile_image_url"];
                if (me.account.hasBirthday > 0) {
                    [defaults setObject:me.account.birthday forKey:@"sns_birth"];
                } else {
                    [defaults setObject:@"" forKey:@"sns_birth"];
                }
                
                if (me.account.hasPhoneNumber > 0) {
                    [defaults setObject:me.account.phoneNumber forKey:@"sns_phone"];
                } else {
                    [defaults setObject:@"" forKey:@"sns_phone"];
                }
               /* KOUserGender
                if (me.account.hasGender > 0) {
                    if (
                        me.account.gender == KOUserGenderFemale) {
                        [defaults setObject:@"F" forKey:@"sns_gender"];
                    } else if (me.account.gender == KOUserGenderMale) {
                        [defaults setObject:@"M" forKey:@"sns_gender"];
                    }
                }*/
                [defaults synchronize];
              //  [self dismissViewControllerAnimated:NO completion:nil];
                NSDictionary *resultdict = [ApiHandler snsconnect:@"1000" snsid:me.ID email:email];
                if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                    if ([[resultdict objectForKey:@"message"] isEqualToString:@"Ok"]) {
                        NSDictionary *datadict = [resultdict objectForKey:@"data"];
                        User *user = [User sharedInstance];
                        [user userinit:datadict];
                        [self viewWillAppear:nil];
                       
                    }
                }else {
                    [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
                }
            }
            
           
        }
    }];
}


- (IBAction)btnkakaoPress:(id)sender {
    if ([self.lblkakao.text isEqualToString:@"등록"]) {
        KOSession *session = [KOSession sharedSession];
        
        if (session.isOpen) {
            [session close];
        }
        
        [session openWithCompletionHandler:^(NSError *error) {
            if (!session.isOpen) {
                switch (error.code) {
                    case KOErrorCancelled:
                        break;
                    default:
                       
                        break;
                }
            }
        }];
    } else {
        if ([self.lblpassword.text isEqualToString:@"등록"]) {
            [FSToast showToast:self messge:@"비밀번호 등록 후 해제 가능합니다."];
            
        } else {
            NSDictionary *resultdict = [ApiHandler snsdisconnect];
            if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                NSDictionary *datadict = [resultdict objectForKey:@"data"];
                User *user = [User sharedInstance];
                [user userinit:datadict];
                [self viewWillAppear:nil];
            }
        }
    }
}

- (IBAction)btnapplePress:(id)sender {
    if ([self.lblapple.text isEqualToString:@"등록"]) {
        
    } else {
        if ([self.lblpassword.text isEqualToString:@"등록"]) {
            [FSToast showToast:self messge:@"비밀번호 등록 후 해제 가능합니다."];
            
        } else {
            NSDictionary *resultdict = [ApiHandler snsdisconnect];
            if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                NSDictionary *datadict = [resultdict objectForKey:@"data"];
                User *user = [User sharedInstance];
                [user userinit:datadict];
                [self viewWillAppear:nil];
            }
        }
    }
}

- (IBAction)btngooglePress:(id)sender {
    if ([self.lblgoogle.text isEqualToString:@"등록"]) {
        
    }else {
        if ([self.lblpassword.text isEqualToString:@"등록"]) {
            [FSToast showToast:self messge:@"비밀번호 등록 후 해제 가능합니다."];
            
        } else {
            NSDictionary *resultdict = [ApiHandler snsdisconnect];
            if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                NSDictionary *datadict = [resultdict objectForKey:@"data"];
                User *user = [User sharedInstance];
                [user userinit:datadict];
                [self viewWillAppear:nil];
            }
        }
    }
}

- (void)requestThirdpartyLogin
{
    // NaverThirdPartyLoginConnection의 인스턴스에 서비스앱의 url scheme와 consumer key, consumer secret, 그리고 appName을 파라미터로 전달하여 3rd party OAuth 인증을 요청한다.
    NaverThirdPartyLoginConnection *tlogin = [NaverThirdPartyLoginConnection getSharedInstance];
   // [tlogin requestDeleteToken];

   // NaverThirdPartyLoginConnection *tlogin = [NaverThirdPartyLoginConnection getSharedInstance];
    
    [tlogin setServiceUrlScheme:@"emomanse"];
    [tlogin setConsumerKey:@"tO7S16rhbsiBMPRRr5Tk"];
    [tlogin setConsumerSecret:@"4PmrJWi0rI"];
    [tlogin setAppName:@"이모만세"];
    [tlogin requestThirdPartyLogin];
}

- (void)requestAccessTokenWithRefreshToken
{
    NaverThirdPartyLoginConnection *tlogin = [NaverThirdPartyLoginConnection getSharedInstance];
    
    [tlogin setConsumerKey:@"tO7S16rhbsiBMPRRr5Tk"];
    [tlogin setConsumerSecret:@"4PmrJWi0rI"];
    
    [tlogin requestAccessTokenWithRefreshToken];
}

- (void)resetToken
{
    [_thirdPartyLoginConn resetToken];
}

- (void)requestDeleteToken
{
    NaverThirdPartyLoginConnection *tlogin = [NaverThirdPartyLoginConnection getSharedInstance];
    [tlogin requestDeleteToken];
}

- (void)naverLoginSuccess {
    if (NO == [_thirdPartyLoginConn isValidAccessTokenExpireTimeNow]) {
       NSLog(@"로그인 하세요.");
        return;
    }
    
    //xml
    //NSString *urlString = @"https://openapi.naver.com/v1/nid/getUserProfile.xml";  //  사용자 프로필 호출
    //json
    NSString *urlString = @"https://openapi.naver.com/v1/nid/me";
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", _thirdPartyLoginConn.accessToken];
    
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSString *decodingString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    if (error) {
        NSLog(@"Error happened - %@", [error description]);
       // [_mainView setResultLabelText:[error description]];
    } else {
        NSLog(@"recevied data - %@", decodingString);
        NSData *jsonData = [decodingString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        
        //    Note that JSONObjectWithData will return either an NSDictionary or an NSArray, depending whether your JSON string represents an a dictionary or an array.
        NSDictionary *jsonObject = [[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] objectForKey:@"response"];
        
        if (error) {
            NSLog(@"Error parsing JSON: %@", error);
            return;
        }
      
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"Y" forKey:@"autologin"];
        [defaults setObject:@"2000" forKey:@"method"];
        [defaults setObject:[jsonObject objectForKey:@"id"] forKey:@"snsid"];
        [defaults setObject:[jsonObject objectForKey:@"nickname"] forKey:@"sns_nickname"];
        [defaults setObject:[jsonObject objectForKey:@"email"] forKey:@"snsemail"];
        [defaults setObject:[jsonObject objectForKey:@"profile_image"] forKey:@"sns_profile_image_url"];
        if ([[jsonObject objectForKey:@"gender"] isEqual:[NSNull null]]) {
            [defaults setObject:@"" forKey:@"sns_gender"];
        } else {
            [defaults setObject:[jsonObject objectForKey:@"gender"] forKey:@"sns_gender"];
        }
        
        if ([[jsonObject objectForKey:@"mobile"] isEqual:[NSNull null]]) {
            [defaults setObject:@"" forKey:@"sns_phone"];
        } else {
            NSString *phone = [jsonObject objectForKey:@"mobile"];
            phone = [phone stringByReplacingOccurrencesOfString:@"+82" withString:@""];
            phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            [defaults setObject:phone forKey:@"sns_phone"];
        }
        [defaults setObject:@"" forKey:@"sns_birth"];
        [defaults synchronize];
        
       //  [self dismissViewControllerAnimated:NO completion:nil];
         NSDictionary *resultdict = [ApiHandler snsconnect:@"2000" snsid:[jsonObject objectForKey:@"id"] email:[jsonObject objectForKey:@"email"]];
         if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
             if ([[resultdict objectForKey:@"message"] isEqualToString:@"Ok"]) {
                 NSDictionary *datadict = [resultdict objectForKey:@"data"];
                 User *user = [User sharedInstance];
                 [user userinit:datadict];
                 [self viewWillAppear:nil];
                
             }
         }else {
             [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
         }
       // [_mainView setResultLabelText:decodingString];
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - SampleOAuthConnectionDelegate
- (void) presentWebviewControllerWithRequest:(NSURLRequest *)urlRequest   {
    // FormSheet모달위에 FullScreen모달이 뜰 떄 애니메이션이 이상하게 동작하여 애니메이션이 없도록 함
    
    /*NLoginThirdPartyOAuth20InAppBrowserViewController *inAppBrowserViewController = [[NLoginThirdPartyOAuth20InAppBrowserViewController alloc] initWithRequest:urlRequest];
    inAppBrowserViewController.parentOrientation = (UIInterfaceOrientation)[[UIDevice currentDevice] orientation];
    [self presentViewController:inAppBrowserViewController animated:NO completion:nil];*/
}

#pragma mark - OAuth20 deleagate

- (void)oauth20ConnectionDidOpenInAppBrowserForOAuth:(NSURLRequest *)request {
    [self presentWebviewControllerWithRequest:request];
}

- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailWithError:(NSError *)error {
        NSLog(@"%s=[%@]", __FUNCTION__, error);
    //[_mainView setResultLabelText:[NSString stringWithFormat:@"%@", error]];
}

- (void)oauth20ConnectionDidFinishRequestACTokenWithAuthCode {
    NSLog(@"%@",[NSString stringWithFormat:@"OAuth Success!\n\nAccess Token - %@\n\nAccess Token Expire Date- %@\n\nRefresh Token - %@", _thirdPartyLoginConn.accessToken, _thirdPartyLoginConn.accessTokenExpireDate, _thirdPartyLoginConn.refreshToken]);
    [self naverLoginSuccess];
}

- (void)oauth20ConnectionDidFinishRequestACTokenWithRefreshToken {
    NSLog(@"%@",[NSString stringWithFormat:@"Refresh Success!\n\nAccess Token - %@\n\nAccess sToken ExpireDate- %@", _thirdPartyLoginConn.accessToken, _thirdPartyLoginConn.accessTokenExpireDate ]);
    [self naverLoginSuccess];
}
- (void)oauth20ConnectionDidFinishDeleteToken {
    NSLog(@"%@",[NSString stringWithFormat:@"인증해제 완료"]);
}

- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFinishAuthorizationWithResult:(THIRDPARTYLOGIN_RECEIVE_TYPE)recieveType
{
    NSLog(@"Getting auth code from NaverApp success!");
}

- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailAuthorizationWithRecieveType:(THIRDPARTYLOGIN_RECEIVE_TYPE)recieveType
{
    NSLog(@"NaverApp login fail handler");
}


- (IBAction)btnnaverPress:(id)sender {
    if ([self.lblnaver.text isEqualToString:@"등록"]) {
        [self requestThirdpartyLogin];
    } else {
        if ([self.lblpassword.text isEqualToString:@"등록"]) {
            [FSToast showToast:self messge:@"비밀번호 등록 후 해제 가능합니다."];
            
        } else {
            NSDictionary *resultdict = [ApiHandler snsdisconnect];
            if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                NSDictionary *datadict = [resultdict objectForKey:@"data"];
                User *user = [User sharedInstance];
                [user userinit:datadict];
                [self viewWillAppear:nil];
            }
        }
    }
}

- (IBAction)btnemailPress:(id)sender {
    if ([self.lblemail.text isEqualToString:@"등록"]) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        EmailAddController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EmailAddController"];
        
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        EmailChangeController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EmailChangeController"];
        
        [self.navigationController pushViewController:dc animated:YES];
    }
}

- (IBAction)btnpasswordPress:(id)sender {
    if ([self.lblpassword.text isEqualToString:@"등록"]) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        PasswordAddController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PasswordAddController"];
        dc.stype = @"edit";
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        PasswordChangeController *dc = [storyboard instantiateViewControllerWithIdentifier:@"PasswordChangeController"];
        dc.stype = @"edit";
        [self.navigationController pushViewController:dc animated:YES];
    }
}

- (IBAction)btnbirthPress:(id)sender{
    if ([self.lblbirth.text isEqualToString:@"등록"]) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        EditAddinfoController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EditAddinfoController"];
        
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        EditAddinfoController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EditAddinfoController"];
        
        [self.navigationController pushViewController:dc animated:YES];
    }
}

- (IBAction)btnphonePress:(id)sender {
    if ([self.lblphone.text isEqualToString:@"등록"]) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        EditAddinfoController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EditAddinfoController"];
        
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        EditAddinfoController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EditAddinfoController"];
        
        [self.navigationController pushViewController:dc animated:YES];
    }
}
@end
