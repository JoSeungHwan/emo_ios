//
//  LoginController.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/24.
//

#import <Foundation/Foundation.h>
#import "LoginController.h"
#import "popupViewController.h"
#import "User.h"
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>
#import <KakaoOpenSDK/KakaoOpenSDK.h>
#import "RegisterController.h"
#import "FindIDController.h"
#import "AddInfoBirthController.h"
#import "AddInfoGenderController.h"
#import "PhoneAddController.h"

@interface LoginController ()

@end

@implementation LoginController
@synthesize btnidpw, btnapple, btnemail, btnkakao, btnnaver, btngoogle, btnregister, pc, btnapple1, btnsave;

- (void)viewDidLoad {
    _thirdPartyLoginConn = [NaverThirdPartyLoginConnection getSharedInstance];
    _thirdPartyLoginConn.delegate = self;
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"로그인";
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
    
    
    self.btnemail.layer.cornerRadius = 10;
    self.btnregister.layer.cornerRadius = 10;
    self.btnregister.layer.borderColor = [[UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1] CGColor];
    self.btnregister.layer.borderWidth = 1;
    self.btnidpw.layer.cornerRadius = 10;
    self.btnidpw.layer.borderColor = [[UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1] CGColor];
    self.btnidpw.layer.borderWidth = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kakaoSessionDidChangeWithNotification)
                                                 name:KOSessionDidChangeNotification
                                               object:nil];
    if (@available(iOS 13.0, *)) {
                [self observeAppleSignInState];
            
            }
    
    
    [super viewDidLoad];
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
                NSDictionary *resultdict = [ApiHandler socialcheck:@"1000" snsid:me.ID email:email];
                if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                    if ([[resultdict objectForKey:@"message"] isEqualToString:@"Ok"]) {
                        NSDictionary *resultdt = [ApiHandler socialLogin:@"1000" snsid:me.ID email:email nickname:nickname imgurl:photoUrl];
                        if ([[[resultdt objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                            if ([[resultdt objectForKey:@"data"] isEqualToString:@"true"]) {
                                NSDictionary *datadict = [resultdt objectForKey:@"data"];
                                User *user = [User sharedInstance];
                                [user userinit:datadict];
                                //user = [user init:datadict];
                               // User *user = [[User alloc] init:datadict];
                                NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
                                [defaults1 setValue:@"Y" forKey:@"autologin"];
                                [defaults1 setValue:user.token forKey:@"token"];
                                [defaults1 synchronize];
                                NSLog(@"%@", user.nickname);
                                [self.navigationController popToRootViewControllerAnimated:YES];
                            } else {
                                if ([[defaults objectForKey:@"sns_birth"] isEqualToString:@""]) {
                                    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                                           bundle:nil];
                                   
                                    AddInfoBirthController *dc = [storyboard instantiateViewControllerWithIdentifier:@"AddInfoBirthController"];
                                   
                                    [self.navigationController pushViewController:dc animated:YES];
                                } else {
                                    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                                           bundle:nil];
                                   
                                    AddInfoGenderController *dc = [storyboard instantiateViewControllerWithIdentifier:@"AddInfoGenderController"];
                                   
                                    [self.navigationController pushViewController:dc animated:YES];
                                }
                            }
                        } else {
                            [FSToast showToast:self messge:[resultdt objectForKey:@"message"]];
                            return;
                        }
                    }
                }else {
                    [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
                }
            }
            
           
        }
    }];
}


- (IBAction)btnkakaoPresa:(id)sender {

   /* KOSession *session = [KOSession sharedSession];
    
    if (session.isOpen) {
        [session close];
    }
    
    [[KOSession sharedSession] openWithCompletionHandler:^(NSError *error) {
           if (error) {
               NSLog(@"login error: %@", error);
           } else {
               NSLog(@"login succeeded.");
               // 사용자 정보 조회
               [self requestMe:YES];
           }
    }];*/
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
         NSDictionary *resultdict = [ApiHandler socialcheck:@"2000" snsid:[jsonObject objectForKey:@"id"] email:[jsonObject objectForKey:@"email"]];
         if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
             if ([[resultdict objectForKey:@"message"] isEqualToString:@"Ok"]) {
                 if ([[[resultdict objectForKey:@"data"] stringValue] isEqualToString:@"1"]) {
                     NSDictionary *resultdt = [ApiHandler socialLogin:@"2000" snsid:[jsonObject objectForKey:@"id"] email:[jsonObject objectForKey:@"email"] nickname:[jsonObject objectForKey:@"nickname"] imgurl:[jsonObject objectForKey:@"profile_image"]];
                     if ([[[resultdt objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                         if ([[[resultdt objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                             NSDictionary *datadict = [resultdt objectForKey:@"data"];
                             User *user = [User sharedInstance];
                             [user userinit:datadict];
                             //user = [user init:datadict];
                            // User *user = [[User alloc] init:datadict];
                             NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
                             [defaults1 setValue:@"Y" forKey:@"autologin"];
                             [defaults1 setValue:user.token forKey:@"token"];
                             [defaults1 synchronize];
                             NSLog(@"%@", user.nickname);
                             [self.navigationController popToRootViewControllerAnimated:YES];
                            
                               
                         } else {
                             [FSToast showToast:self messge:[resultdt objectForKey:@"message"]];
                             return;
                         }
                     }
                     
                 } else {
                     if ([[defaults objectForKey:@"sns_birth"] isEqualToString:@""]) {
                         UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                                bundle:nil];
                        
                         AddInfoBirthController *dc = [storyboard instantiateViewControllerWithIdentifier:@"AddInfoBirthController"];
                        
                         [self.navigationController pushViewController:dc animated:YES];
                     } else {
                         UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                                bundle:nil];
                        
                         AddInfoGenderController *dc = [storyboard instantiateViewControllerWithIdentifier:@"AddInfoGenderController"];
                        
                         [self.navigationController pushViewController:dc animated:YES];
                     }
                 }
                
             }
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
   [self requestThirdpartyLogin];
}

- (IBAction)btngooglePress:(id)sender {
       
}



- (IBAction)btnapplePress:(id)sender {
    if (@available(iOS 13.0, *)) {
           // A mechanism for generating requests to authenticate users based on their Apple ID.
           ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
           
           // Creates a new Apple ID authorization request.
           ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
           // The contact information to be requested from the user during authentication.
           request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
           
           // A controller that manages authorization requests created by a provider.
           ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
           
           // A delegate that the authorization controller informs about the success or failure of an authorization attempt.
           controller.delegate = self;
           
           // A delegate that provides a display context in which the system can present an authorization interface to the user.
           controller.presentationContextProvider = self;
           
           // starts the authorization flows named during controller initialization.
           [controller performRequests];
       }
}


- (void)perfomExistingAccountSetupFlows {
    if (@available(iOS 13.0, *)) {
        // A mechanism for generating requests to authenticate users based on their Apple ID.
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
        
        // An OpenID authorization request that relies on the user’s Apple ID.
        ASAuthorizationAppleIDRequest *authAppleIDRequest = [appleIDProvider createRequest];
        
        // A mechanism for generating requests to perform keychain credential sharing.
        ASAuthorizationPasswordRequest *passwordRequest = [[ASAuthorizationPasswordProvider new] createRequest];
        
        NSMutableArray <ASAuthorizationRequest *>* mArr = [NSMutableArray arrayWithCapacity:2];
        if (authAppleIDRequest) {
            [mArr addObject:authAppleIDRequest];
        }
        if (passwordRequest) {
            [mArr addObject:passwordRequest];
        }
        // ASAuthorizationRequest：A base class for different kinds of authorization requests.
        NSArray <ASAuthorizationRequest *>* requests = [mArr copy];
        
        // A controller that manages authorization requests created by a provider.
        // Creates a controller from a collection of authorization requests.
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requests];

        // A delegate that the authorization controller informs about the success or failure of an authorization attempt.
        authorizationController.delegate = self;
        // A delegate that provides a display context in which the system can present an authorization interface to the user.
        authorizationController.presentationContextProvider = self;
        
        // starts the authorization flows named during controller initialization.
        [authorizationController performRequests];
    }
}


- (void)observeAppleSignInState {
    if (@available(iOS 13.0, *)) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(handleSignInWithAppleStateChanged:) name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    }
}

- (void)handleSignInWithAppleStateChanged:(id)noti {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", noti);
}

#pragma mark - Delegate

 - (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)){
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", controller);
    NSLog(@"%@", authorization);
    
    NSLog(@"authorization.credential：%@", authorization.credential);
    NSMutableString *mStr = [NSMutableString string];
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *user = appleIDCredential.user;
        NSString *name = @"";
        NSString *email =@"";
        if (![[defaults objectForKey:user] isKindOfClass:[NSDictionary class]]) {
            
            NSString *familyName = appleIDCredential.fullName.familyName;
            NSString *givenName = appleIDCredential.fullName.givenName;
            name = [NSString stringWithFormat:@"%@ %@",familyName, givenName];
            email = appleIDCredential.email;
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"apple",@"LoginType",user,@"id", name,@"nickname",email,@"email",@"",@"photourl", nil];
            [defaults setObject:dic forKey:user];
            [defaults setObject:@"Y" forKey:@"autologin"];
            [defaults setObject:@"4000" forKey:@"method"];
            [defaults setObject:user forKey:@"snsid"];
            [defaults setObject:name forKey:@"sns_nickname"];
            [defaults setObject:email forKey:@"snsemail"];
            [defaults setObject:@"" forKey:@"sns_profile_image_url"];
            
            [defaults synchronize];
           //  [self dismissViewControllerAnimated:NO completion:nil];
             NSDictionary *resultdict = [ApiHandler socialcheck:@"4000" snsid:user email:email];
             if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                 if ([[resultdict objectForKey:@"message"] isEqualToString:@"Ok"]) {
                     NSDictionary *resultdt = [ApiHandler socialLogin:@"4000" snsid:user email:email nickname:name imgurl:@""];
                     if ([[[resultdt objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                         NSDictionary *datadict = [resultdt objectForKey:@"data"];
                         User *users = [User sharedInstance];
                         [users userinit:datadict];
                         NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
                         [defaults1 setValue:@"Y" forKey:@"autologin"];
                         [defaults1 setValue:users.token forKey:@"token"];
                         [defaults1 synchronize];
                         //user = [user init:datadict];
                        // User *user = [[User alloc] init:datadict];
                         
                         NSLog(@"%@", users.nickname);
                         [self.navigationController popToRootViewControllerAnimated:YES];
                     } else {
                         [FSToast showToast:self messge:[resultdt objectForKey:@"message"]];
                         return;
                     }
                 }
             }
        } else {
           
            // [_mainView setResultLabelText:decodingString];
             
             [self dismissViewControllerAnimated:NO completion:nil];
        }
     
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        ASPasswordCredential *passwordCredential = authorization.credential;
        NSString *user = passwordCredential.user;
        NSString *password = passwordCredential.password;
        [mStr appendString:user?:@""];
        [mStr appendString:password?:@""];
        [mStr appendString:@"\n"];
        NSLog(@"mStr：%@", mStr);
        
    } else {
         mStr = [@"check" mutableCopy];
       
    }
}
 

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"error ：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"ASAuthorizationErrorCanceled";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"ASAuthorizationErrorFailed";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"ASAuthorizationErrorInvalidResponse";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"ASAuthorizationErrorNotHandled";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"ASAuthorizationErrorUnknown";
            break;
    }
   
    
    if (errorMsg) {
        return;
    }
    
    if (error.localizedDescription) {
      
       
    }
    NSLog(@"controller requests：%@", controller.authorizationRequests);
    /*
     ((ASAuthorizationAppleIDRequest *)(controller.authorizationRequests[0])).requestedScopes
     <__NSArrayI 0x2821e2520>(
     full_name,
     email
     )
     */
}
 
//! Tells the delegate from which window it should present content to the user.
 - (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    
    NSLog(@"window：%s", __FUNCTION__);
    return self.view.window;
}

- (IBAction)btnemailPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    

    self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
    self.pc.view.frame = self.view.frame;
    popupview = self.pc.bgview;
    loginview = self.pc.emailloginview;
    btnsave = self.pc.btncheck;
    [btnsave addTarget:self action:@selector(btnsavePress:) forControlEvents:UIControlEventTouchUpInside];
    self.pc.popuptype = @"emaillogin";
    [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popupview];
    [self.pc startview];
    txtemail = self.pc.txtemail;
    txtpw = self.pc.txtpw;
    txtemail.delegate = self;
    txtpw.delegate = self;
    self.keyboardshow = false;
    [self.pc.btnemaillogin addTarget:self action:@selector(btnemailloginPress:) forControlEvents:UIControlEventTouchUpInside];
    //[self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnsavePress:(id)sender {
    btnsave.selected = !btnsave.selected;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (IBAction)btnregisterPress:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"method"];
    [defaults synchronize];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    RegisterController *dc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterController"];
    
    [self.navigationController pushViewController:dc animated:YES];
    
}

- (IBAction)btnidpwPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    FindIDController *dc = [storyboard instantiateViewControllerWithIdentifier:@"FindIDController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)popupbgclick:(id)sender {
    if (self.keyboardshow) {
        self.keyboardshow = false;
        [txtemail resignFirstResponder];
        [txtpw resignFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        
        [UIView setAnimationDuration:0.3];
        
        CGRect rect = loginview.frame;
        
        rect.origin.y += 250;
        
        rect.size.height -= 250;
        
        loginview.frame = rect;
        
        [UIView commitAnimations];
    } else {
        [self.pc hidenview];
    }
}

- (IBAction)btnemailloginPress:(id)sender {
    if ([txtemail.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"Email주소를 입력하십시요."];
        return;
    } else if ([txtpw.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"비밀번호를 입력하십시요."];
        return;
    }
    
    NSDictionary *resultdt = [ApiHandler login:txtemail.text password:txtpw.text];
    NSLog(@"%@", [resultdt description]);
    NSDictionary *datadict = [resultdt objectForKey:@"data"];
    if ([[[resultdt objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        User *user = [User sharedInstance];
        [user userinit:datadict];
        //user = [user init:datadict];
       // User *user = [[User alloc] init:datadict];
        if (btnsave.selected) {
            NSUserDefaults *defatuls = [NSUserDefaults standardUserDefaults];
            [defatuls setValue:@"Y" forKey:@"autologin"];
            [defatuls setValue:user.token forKey:@"token"];
            [defatuls setValue:@"email" forKey:@"logintype"];
            [defatuls synchronize];
        }
        NSLog(@"%@", user.nickname);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloaddata" object:self];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [FSToast showToast:self messge:[resultdt objectForKey:@"message"]];
        return;
    }
}

- (void)keyboardWillShow:(NSNotification *)notice {
    if (!self.keyboardshow) {
        self.keyboardshow = true;
        [UIView beginAnimations:nil context:NULL];
        
        [UIView setAnimationDuration:0.3];
        
        CGRect rect = loginview.frame;
        
        rect.origin.y  -= 250;
        rect.size.height += 250;
        
        loginview.frame = rect;
        
        [UIView commitAnimations];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == txtemail) {
        [txtemail resignFirstResponder];
        
        [UIView beginAnimations:nil context:NULL];
        
        [UIView setAnimationDuration:0.3];
        
        CGRect rect = loginview.frame;
        
        rect.origin.y += 250;
        
        rect.size.height -= 250;
        
        loginview.frame = rect;
        
        [UIView commitAnimations];
        self.keyboardshow = false;
        return YES;
    } else if (textField == txtpw) {
        [txtpw resignFirstResponder];
        
        [UIView beginAnimations:nil context:NULL];
        
        [UIView setAnimationDuration:0.3];
        
        CGRect rect = loginview.frame;
        
        rect.origin.y += 250;
        
        rect.size.height -= 250;
        
        loginview.frame = rect;
        
        [UIView commitAnimations];
        self.keyboardshow = false;
        return YES;
    
        
    }
   
    return NO;
}

@end
