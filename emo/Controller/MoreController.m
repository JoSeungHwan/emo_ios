//
//  MoreController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "MoreController.h"
#import "User.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImagePhotosPlugin/SDWebImagePhotosPlugin.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "EventController.h"
#import "FaqController.h"
#import "ServiceCenterControlelr.h"
#import "SettingController.h"
#import "LoginController.h"
#import "EmoticonController.h"
#import "EmoticonDetailController.h"
#import "ServiceController.h"

@interface MoreController ()

@end

@implementation MoreController
@synthesize btnfaq, btnuse, btnevent, btnorder, btncontact, btnemoticon, btnemotion1, btnorderlist, scrollView, lbltuni, newemoticon, myemotionview, myemotionscroll, emoticonscroll, pc, btntoni, userview, nouserview;

- (void)viewDidLoad {

    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"";
    lbltitle.font = [UIFont fontWithName:@"SBAggroB" size:18];
    lbltitle.textColor = [UIColor colorWithRed:(34.0f/255.0f) green:(34.0f/255.0f) blue:(34.0f/255.0f) alpha:1];
    self.navigationItem.titleView = lbltitle;
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setFrame:CGRectMake(0, 0, 44, 44)];
    [leftbtn setImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(btnbackPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarbtn = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem =leftbarbtn;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    rightView.backgroundColor = [UIColor clearColor];
    btnlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnlogin setTitle:@"Login" forState:UIControlStateNormal];
    [btnlogin setFont:[UIFont fontWithName:@"SBAggroB" size:16]];
    [btnlogin setTitleColor:[UIColor colorWithRed:(255.0f/255.0f) green:(206.0f/255.0f) blue:(0.0f/255.0f) alpha:1] forState:UIControlStateNormal];
    [btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    btnlogin.frame = CGRectMake(0, 0, 60, 44);
    [rightView addSubview:btnlogin];
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setFrame:CGRectMake(56, 0, 44, 44)];
    [rightbtn setImage:[UIImage imageNamed:@"filtericon"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(settingPress:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightbtn];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    self.btnuse.layer.borderColor = [[UIColor blackColor] CGColor];
    self.btnuse.layer.borderWidth = 1;
    self.btnuse.layer.cornerRadius = 10;
    
    self.btnorderlist.layer.borderColor = [[UIColor blackColor] CGColor];
    self.btnorderlist.layer.borderWidth = 1;
    self.btnorderlist.layer.cornerRadius = 10;
    
    self.btnemotion1.layer.cornerRadius = 10;
    self.btnemoticon.layer.cornerRadius = 10;
    self.btnorder.layer.cornerRadius = self.btnorder.frame.size.height/ 2;
    
    self.btntoni.layer.cornerRadius = 10;
    
    [super viewDidLoad];
}

- (IBAction)btnloginPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    

    self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
    self.pc.view.frame = self.view.frame;
    popupview = self.pc.bgview;
    self.pc.popuptype = @"login";
    [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popupview];
    [self.pc startview];
    [self.pc.btnlogin addTarget:self action:@selector(loginPress:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

- (IBAction)loginPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    
    LoginController *dc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];

    [self.navigationController pushViewController:dc animated:YES];
    [self.pc hidenview];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)settingPress:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        SettingController *dc = [storyboard instantiateViewControllerWithIdentifier:@"SettingController"];
        
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        [self btnloginPress:self];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    User *user = [User sharedInstance];
    NSLog(@"%@",user.token);
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        NSDictionary *resultdict = [ApiHandler morepointsearch];
        btnlogin.hidden = YES;
        userview.hidden = NO;
        nouserview.hidden = YES;
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            NSDictionary *dt = [resultdict objectForKey:@"data"];
            NSString *str = [NSString stringWithFormat:@"지금 사용할 수 있는 투니는\n%@T 예요.",[dt objectForKey:@"remain_point"]] ;
            NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:str];
            NSRange range = [str rangeOfString:[NSString stringWithFormat:@"%@T", [dt objectForKey:@"remain_point"]]];
            [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(255.0f/255.0f) green:(206.0f/255.0f) blue:(0.0f/255.0f) alpha:1] range:range];
            [self.lbltuni setAttributedText:att];
        }
        NSDictionary *resultdict1 = [ApiHandler orderEmoticonsList:1 order:@"" search:@""];
        
        if ([[[resultdict1 objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            NSDictionary *dict = [resultdict1 objectForKey:@"data"];
            NSArray *arr = [dict objectForKey:@"data"];
            if ([arr count] > 0) {
                self.myemotionview.hidden = NO;
                self.newemoticon.hidden = YES;
                for (int i = 0 ; i < [arr count]; i++) {
                    NSDictionary *dt = [arr objectAtIndex:i];
                    NSArray *far = [dt objectForKey:@"files"];
                    NSDictionary *dict1 = [far objectAtIndex:0];
                    UIView *v = [[UIView alloc] initWithFrame:CGRectMake((i * 120) + 5, 15, 120, 120)];
                    v.backgroundColor = [UIColor clearColor];
                    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
                    imgv.image = [UIImage imageNamed:@"emoticonbg1"];
                    [v addSubview:imgv];
                    UIImageView *imgcont = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 90)];
                    imgcont.layer.cornerRadius = 10;
                    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                    [downloader downloadImageWithURL:[NSURL URLWithString:[dict1 objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                        if (image && finished) {
                            imgcont.image = image;
                            // do something with image
                            
                        }
                    }];
                    [v addSubview:imgcont];
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.backgroundColor = [UIColor clearColor];
                    btn.frame = imgv.frame;
                    btn.tag = [[dt objectForKey:@"idx"] intValue];
                    [btn addTarget:self action:@selector(btnemotiondetailPress:) forControlEvents:UIControlEventTouchUpInside];
                    [v addSubview:btn];
                    [self.myemotionscroll addSubview:v];
                }
            } else {
                self.myemotionview.hidden = YES;
                self.newemoticon.hidden = NO;
                NSDictionary *resultdict2 = [ApiHandler emoticonList:1 order:@"new" search:@""];
                NSLog(@"%@",[resultdict2 description]);
                if ([[[resultdict2 objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                    NSDictionary *dict1 = [resultdict2 objectForKey:@"data"];
                    NSArray *arr1 = [dict1 objectForKey:@"data"];
                    for (int i = 0 ; i < [arr1 count]; i++) {
                        NSDictionary *dt = [arr1 objectAtIndex:i];
                        NSArray *far = [dt objectForKey:@"files"];
                        NSDictionary *dict1 = [far objectAtIndex:0];
                        UIView *v = [[UIView alloc] initWithFrame:CGRectMake((i * 120) + 5, 15, 120, 120)];
                        v.backgroundColor = [UIColor clearColor];
                        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
                        imgv.image = [UIImage imageNamed:@"emoticonbg1"];
                        [v addSubview:imgv];
                        UIImageView *imgcont = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 90)];
                        imgcont.layer.cornerRadius = 10;
                        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                        [downloader downloadImageWithURL:[NSURL URLWithString:[dict1 objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                            if (image && finished) {
                                imgcont.image = image;
                                // do something with image
                                
                            }
                        }];
                        [v addSubview:imgcont];
                        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        btn.backgroundColor = [UIColor clearColor];
                        btn.frame = imgv.frame;
                        btn.tag = [[dt objectForKey:@"idx"] intValue];
                        [btn addTarget:self action:@selector(btnemotiondetailPress:) forControlEvents:UIControlEventTouchUpInside];
                        [v addSubview:btn];
                        [self.emoticonscroll addSubview:v];
                    }
                }
            }
        }
    } else {
        btnlogin.hidden = NO;
        userview.hidden = YES;
        nouserview.hidden = NO;
        self.myemotionview.hidden = YES;
        self.newemoticon.hidden = NO;
        NSString *str = @"지금 사용할 수 있는 투니는\n0T 예요.";
        NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:str];
        NSRange range = [str rangeOfString:@"0T"];
        [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(255.0f/255.0f) green:(206.0f/255.0f) blue:(0.0f/255.0f) alpha:1] range:range];
        [self.lbltuni setAttributedText:att];
        NSDictionary *resultdict2 = [ApiHandler emoticonList:1 order:@"new" search:@""];
        NSLog(@"%@",[resultdict2 description]);
        if ([[[resultdict2 objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            NSDictionary *dict1 = [resultdict2 objectForKey:@"data"];
            NSArray *arr1 = [dict1 objectForKey:@"data"];
            for (int i = 0 ; i < [arr1 count]; i++) {
                NSDictionary *dt = [arr1 objectAtIndex:i];
                NSArray *far = [dt objectForKey:@"files"];
                NSDictionary *dict1 = [far objectAtIndex:0];
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake((i * 120) + 5, 15, 120, 120)];
                v.backgroundColor = [UIColor clearColor];
                UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
                imgv.image = [UIImage imageNamed:@"emoticonbg1"];
                [v addSubview:imgv];
                UIImageView *imgcont = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 90)];
                imgcont.layer.cornerRadius = 10;
                SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                [downloader downloadImageWithURL:[NSURL URLWithString:[dict1 objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                    if (image && finished) {
                        imgcont.image = image;
                        // do something with image
                        
                    }
                }];
                [v addSubview:imgcont];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = [UIColor clearColor];
                btn.frame = imgv.frame;
                btn.tag = [[dt objectForKey:@"idx"] intValue];
                [btn addTarget:self action:@selector(btnemotiondetailPress:) forControlEvents:UIControlEventTouchUpInside];
                [v addSubview:btn];
                [self.emoticonscroll addSubview:v];
            }
        }
    }
    [super viewWillAppear:animated];
}

- (IBAction)btnemotiondetailPress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    EmoticonDetailController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EmoticonDetailController"];
    dc.idx = btn.tag;
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btntoniPress:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    ServiceController *dc = [storyboard instantiateViewControllerWithIdentifier:@"ServiceController"];
    dc.stype = @"type2";
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btneventPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    EventController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EventController"];
    
    [self.navigationController pushViewController:dc animated:YES];

}

- (IBAction)btnfaqPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    FaqController *dc = [storyboard instantiateViewControllerWithIdentifier:@"FaqController"];
    
    [self.navigationController pushViewController:dc animated:YES];

}

- (IBAction)btncontactPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    ServiceCenterControlelr *dc = [storyboard instantiateViewControllerWithIdentifier:@"ServiceCenterControlelr"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnemoticonPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    EmoticonController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EmoticonController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnemoticon1Press:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    EmoticonController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EmoticonController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

@end
