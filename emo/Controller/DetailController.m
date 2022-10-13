//
//  DetailController.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/12.
//

#import <Foundation/Foundation.h>
#import "DetailController.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImagePhotosPlugin/SDWebImagePhotosPlugin.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "commentNoCell.h"
#import "ContentCell.h"
#import "notiController.h"
#import "User.h"
#import "LoginController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface DetailController ()

@end

@implementation DetailController
@synthesize listView, datadict, replyview, btnsend, txtreply, imgprofile, pc;
static CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static CGFloat PORTRAIT_KEYBOARD_HEIGHT = 270;
static CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (void)viewDidLoad {
    self.replyeditYN = @"N";
    self.replytype = @"";
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"상세보기";
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
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"notiicon1"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(notiPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        self.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.profile_image_url]]];
        self.imgprofile.layer.cornerRadius = self.imgprofile.frame.size.width / 2;
        
    }
    [super viewDidLoad];
}


- (IBAction)notiPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    notiController *dc = [storyboard instantiateViewControllerWithIdentifier:@"notiController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loaddata];
    [super viewWillAppear:animated];
}

- (void)loaddata {
    self.subviewsCenterArray = [[NSMutableArray alloc] init];
    
    NSDictionary *dict1 = [ApiHandler contentDetail:[self.datadict objectForKey:@"idx"]];
    NSDictionary *dt = [dict1 objectForKey:@"data"];
    [self.subviewsCenterArray addObject:dt];
    NSArray *repliearr = [[dict1 objectForKey:@"data"] objectForKey:@"comments"];
    for (int i = 0 ; i < [repliearr count] ; i++) {
        NSDictionary *dt = [repliearr objectAtIndex:i];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:dt];
        [dict setObject:@"N" forKey:@"reply"];
        [self.subviewsCenterArray addObject:dict];
        NSArray *commentarr = [self commentlist:[dt objectForKey:@"comments"]];
        
        for (int j = 0; j < [commentarr count] ; j ++) {
            NSDictionary *dt1 = [commentarr objectAtIndex:j];
            [self.subviewsCenterArray addObject:dt1];
        }
    }
   
    [self.listView reloadData];

}

- (NSArray *)commentlist:(NSArray *)comment {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < [comment count] ; i ++)  {
        NSDictionary *dt = [comment objectAtIndex:i];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:dt];
        [dict setObject:@"Y" forKey:@"reply"];
        [arr addObject:dict];
        NSArray *subarr = [dt objectForKey:@"coments"];
        if ([subarr count] > 0) {
            NSArray *arr1 = [self commentlist:subarr];
            for (int j = 0 ; j < [arr1 count]; j ++) {
                NSDictionary *dt1 = [arr1 objectAtIndex:j];
                [arr addObject:dt1];
            }
        }
    }
    return arr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.subviewsCenterArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0) {
        ContentCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentCell-%ld",(long)[indexPath row]]];
        
        //cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"contentcell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"ContentCell" owner:self options:nil];
            cell = arr[0];
            
            
       
            NSDictionary *dt = [self.subviewsCenterArray objectAtIndex:[indexPath row]];
            
            if ([[dt objectForKey:@"type_code"] isEqualToString:@"1000"]) {
                cell.lbltype.text = @"#댓툰";
                cell.imgtype.image = [UIImage imageNamed:@"type1000bg"];
            } else if ([[dt objectForKey:@"type_code"] isEqualToString:@"2000"]) {
                cell.lbltype.text = @"#일상툰";
                cell.imgtype.image = [UIImage imageNamed:@"type2000bg"];
            } else if ([[dt objectForKey:@"type_code"] isEqualToString:@"3000"]) {
                cell.lbltype.text = @"#평가툰";
                cell.imgtype.image = [UIImage imageNamed:@"type3000bg"];
            } else if ([[dt objectForKey:@"type_code"] isEqualToString:@"4000"]) {
                cell.lbltype.text = @"#이모티콘";
                cell.imgtype.image = [UIImage imageNamed:@"type4000bg"];
            }
            
            cell.lblnickname.text = [dt objectForKey:@"nickname"];
            NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
            [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [dateformat setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ko_KR"]];
            
            NSString *sdt = [dt objectForKey:@"created_at"];
            NSDate *createdt = [dateformat dateFromString:sdt];
            
            cell.lbldate.text = [ApiHandler calculateDate:createdt];
            cell.lblcontent.text = [[dt objectForKey:@"contents"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            cell.lblcontent.numberOfLines = 0;
            cell.lblcontent.lineBreakMode = NSLineBreakByWordWrapping;
           
            cell.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dt objectForKey:@"profile_image_url"]]]];
            cell.imgprofile.layer.cornerRadius = cell.imgprofile.frame.size.height / 2;
            cell.imgprofile.clipsToBounds = true;
            cell.lbllikecount.text  = [[dt objectForKey:@"likes_count"] stringValue];
            self.lbllikecount1 = cell.lbllikecount;
            self.imglike1 = cell.imglike;
            cell.lblreplycount.text = [NSString stringWithFormat:@"%d", [self.subviewsCenterArray count] -1];
            if ([[[dt objectForKey:@"is_like"] stringValue] isEqualToString:@"1"]) {
                cell.imglike.image = [UIImage imageNamed:@"imglike"];
            } else {
                cell.imglike.image = [UIImage imageNamed:@"imgunlike"];
            }
            [cell.btnlike addTarget:self action:@selector(btnlikePress:) forControlEvents:UIControlEventTouchUpInside];
     
            [cell.btnmore addTarget:self action:@selector(btnmorePress:) forControlEvents:UIControlEventTouchUpInside];
            cell.scrollView.showsHorizontalScrollIndicator = YES;
            cell.scrollView.showsVerticalScrollIndicator=NO;
            CGRect frame = cell.scrollView.frame;
            frame.size.width = [[UIScreen mainScreen] bounds].size.width;
            cell.scrollView.frame = frame;
            cell.scrollView.pagingEnabled = YES;
            cell.scrollView.bounces = false;
            cell.scrollView.showsHorizontalScrollIndicator = false;
            cell.subviewsCenterArray = [dt objectForKey:@"files"];
            if ([[dt objectForKey:@"files"] count] == 1) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    // retrive image on global queue
                    
                    dispatch_async(dispatch_get_main_queue(), ^{

                        NSDictionary *subdic = [[dt objectForKey:@"files"] objectAtIndex:0];
                      
                        int width = cell.scrollView.frame.size.width - 40;
                        int height = width * 0.815;
                        
                        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, width, height)];
                        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                        [downloader downloadImageWithURL:[NSURL URLWithString:[subdic objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                            if (image && finished) {
                                imgV.image = image;
                                // do something with image
                                NSLog(@"  loading123         %@    %@  ",[subdic objectForKey:@"path"],[image description]);
                            }
                        }];
                        
                       
                      
                      //  [imgV sd_setImageWithURL:[NSURL URLWithString:[subdic objectForKey:@"path"]] placeholderImage:nil];
                        /*[imgV sd_setImageWithURL:[NSURL URLWithString:[subdic objectForKey:@"path"]]
                                placeholderImage:nil
                                         options:SDWebImageFromLoaderOnly
                                         context:@{SDWebImageContextStoreCacheType : @(SDImageCacheTypeNone)}]; //
                         */
                        
                        imgV.contentMode = UIViewContentModeScaleToFill;
                        imgV.layer.cornerRadius=10;
                        imgV.clipsToBounds = true;
                         [cell.scrollView addSubview:imgV];
                    });
                });

                
                
            } else if ([[dt objectForKey:@"files"] count] > 1) {
                for (int i = 0 ; i < [[dt objectForKey:@"files"] count]; i++) {
                    NSDictionary *subdic = [[dt objectForKey:@"files"] objectAtIndex:i];
                 
                    int offset = 10;
                    int paddingleft= 10;
                    if (i == 0){
                        offset = 10;
                        paddingleft = 10;
                    }
                 
                    int width = cell.scrollView.frame.size.width - 40;
                    int height = width * 0.815;
                    
                    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((i * (cell.scrollView.frame.size.width- 60)) + offset + paddingleft + (i * 20), 0, width, height)];
                    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                    [downloader downloadImageWithURL:[NSURL URLWithString:[subdic objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                        if (image && finished) {
                            imgV.image = image;
                            // do something with image
                            NSLog(@"  loading123         %@    %@  ",[subdic objectForKey:@"path"],[image description]);
                        }
                    }];
                    /*[imgV sd_setImageWithURL:[NSURL URLWithString:[subdic objectForKey:@"path"]]
                            placeholderImage:nil
                                     options:SDWebImageFromLoaderOnly
                                     context:@{SDWebImageContextStoreCacheType : @(SDImageCacheTypeNone)}]; //*/
                    imgV.contentMode = UIViewContentModeScaleToFill;
                    imgV.layer.cornerRadius=10;
                    imgV.clipsToBounds = true;
                    
                    [cell.scrollView addSubview:imgV];
                    
      
                }
                
                [cell.scrollView setContentSize:CGSizeMake((cell.scrollView.frame.size.width-20) * [[dt objectForKey:@"files"] count], cell.scrollView.frame.size.height-40)];
            }
        
        }
        return cell;
    } else {
        commentNoCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"commentcell-%ld",(long)[indexPath row]]];
        
        //cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"contentcell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"commentNoCell" owner:self options:nil];
            cell = arr[0];
            
            
        }
        
        NSDictionary *dt = [self.subviewsCenterArray objectAtIndex:[indexPath row]];
        NSLog(@"%@",[dt description]);
        NSString *str = [NSString stringWithFormat:@"%@  %@", [dt objectForKey:@"nickname"] ,[[dt objectForKey:@"contents"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"]];
        //테스트용 문자열

        if ([[dt objectForKey:@"reply"] isEqualToString:@"Y"]) {
            cell.cont.constant = 60;
        } else {
            cell.cont.constant = 20;
        }
        NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:str];

        NSRange range = [str rangeOfString:[dt objectForKey:@"nickname"]];
        
        [att addAttribute:NSForegroundColorAttributeName value:[[UIColor blackColor] colorWithAlphaComponent:1.0f] range:range];
        [att addAttribute:NSFontAttributeName
                                  value:[UIFont fontWithName:@"NotoSansKR-Bold" size:17.0]
                                  range:range];
        [cell.lblcomment setAttributedText:att];
        
        cell.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dt objectForKey:@"profile_image_url"]]]];
        cell.imgprofile.layer.cornerRadius = cell.imgprofile.frame.size.height / 2;
        cell.imgprofile.clipsToBounds = true;
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateformat setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ko_KR"]];
        
        NSString *sdt = [dt objectForKey:@"created_at"];
        NSDate *createdt = [dateformat dateFromString:sdt];
        
        cell.lbldate.text = [ApiHandler calculateDate:createdt];
        
        if ([[[dt objectForKey:@"likes_count"] stringValue] isEqualToString:@"0"]) {
            cell.lbllike.hidden = true;
            cell.replycont.constant = -120;
        } else {
            cell.lbllike.hidden = false;
            cell.lbllike.text = [NSString stringWithFormat:@"좋아요 %@개", [[dt objectForKey:@"likes_count"] stringValue]];
        }
        
        if ([[[dt objectForKey:@"is_like"] stringValue] isEqualToString:@"0"]) {
            cell.imglike.image = [UIImage imageNamed:@"imgunlike"];
        } else {
            cell.imglike.image = [UIImage imageNamed:@"imglike"];
        }
        cell.btnlike.tag = indexPath.row;
        [cell.btnlike addTarget:self action:@selector(btnreplylikePress:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnreply.tag = indexPath.row;
        [cell.btnreply addTarget:self action:@selector(btnreplyPress:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnmore addTarget:self action:@selector(btnreplymorePress:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    
    return nil;

}

- (IBAction)btnmorePress:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        if ([[self.datadict objectForKey:@"nickname"] isEqualToString:user.nickname]) {
            self.pc.popuptype = @"mycontentmore";
            
            [self.pc.btndelete addTarget:self action:@selector(btndeletePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnedit addTarget:self action:@selector(btneditPress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnshare addTarget:self action:@selector(btnsharePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnlink addTarget:self action:@selector(btnlinkPress:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            self.pc.popuptype = @"contentmore";
            if ([[[self.datadict objectForKey:@"is_bookmark"] stringValue] isEqualToString:@"1"]) {
                self.pc.imgbookmark.image = [UIImage imageNamed:@"favicon"];
                self.pc.lblbookmark.text = @"찜해제";
            } else {
                self.pc.imgbookmark.image = [UIImage imageNamed:@"unfavicon"];
                self.pc.lblbookmark.text = @"찜하기";
            }
            [self.pc.btnshare1 addTarget:self action:@selector(btnsharePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnlink1 addTarget:self action:@selector(btnlinkPress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnbookmark addTarget:self action:@selector(btnbookmarkPress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnreport addTarget:self action:@selector(btnreportPress:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.view addSubview:popupview];
        
        [self.pc startview];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)btnreplymorePress:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIButton *btn = (UIButton *)sender;
        self.selectitem = [self.subviewsCenterArray objectAtIndex:btn.tag];
        NSLog(@"%@",[self.selectitem description]);
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        if ([[self.selectitem objectForKey:@"nickname"] isEqualToString:user.nickname]) {
            self.pc.popuptype = @"myrepliemore";
            
            [self.pc.btnreplydelete addTarget:self action:@selector(btnreplydeletePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnreplyedit addTarget:self action:@selector(btnreplyeditPress:) forControlEvents:UIControlEventTouchUpInside];
           
        } else {
            self.pc.popuptype = @"repliemore";
     
            [self.pc.btnreport1 addTarget:self action:@selector(btnreportPress:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.view addSubview:popupview];
        
        [self.pc startview];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)btnsharePress:(id)sender {
    [self.pc hidenview];
    NSLog(@"%@",[self.selectcontent description]);
    NSString *link = @"";
   
    link = [NSString stringWithFormat:@"https://m.emomanse.com/api/sharelink?type=contents&idx=%@",[self.datadict objectForKey:@"idx"]];
        
    
    NSURL *url = [NSURL URLWithString:link];


    NSArray *activityItems = @[url];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                                 applicationActivities:nil];
        
        
        activityVC.excludedActivityTypes = @[//UIActivityTypePostToFacebook,
                                             //UIActivityTypePostToTwitter,
                                             UIActivityTypePostToWeibo,
                                             //                                                UIActivityTypeMessage,
                                             //UIActivityTypeMail,
                                             UIActivityTypePrint,
                                             UIActivityTypeCopyToPasteboard,
                                             UIActivityTypeAssignToContact,
                                             //UIActivityTypeSaveToCameraRoll,
                                             UIActivityTypeAddToReadingList,
                                             UIActivityTypePostToFlickr,
                                             UIActivityTypePostToVimeo,
                                             UIActivityTypePostToTencentWeibo,
                                             UIActivityTypeAirDrop,
                                             UIActivityTypeOpenInIBooks,
                                             
                                             ];
        
        activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
            
            
            if(completed)
            {
             
            }
          
        };
    [self presentViewController:activityVC animated:YES completion:^{
          

      }];
}

- (IBAction)btnlinkPress:(id)sender {
    NSLog(@"%@",[self.selectcontent description]);
    
    NSString *link = [NSString stringWithFormat:@"https://m.emomanse.com/api/sharelink?type=contents&idx=%@",[self.datadict objectForKey:@"idx"]];
    [[UIPasteboard generalPasteboard] setString:link];
    
    [FSToast showToast:self messge:@"링크주소가 복사되었습니다."];
}

- (IBAction)btnbookmarkPress:(id)sender {
    NSLog(@"%@",[self.selectcontent description]);
    
    NSDictionary *resultDict = [ApiHandler contentbookmark:[[self.datadict objectForKey:@"idx"] intValue]];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        if ([[[self.datadict objectForKey:@"is_bookmark"] stringValue] isEqualToString:@"1"]) {
            [self.datadict setValue:[NSNumber numberWithInt:0] forKey:@"is_bookmark"];
        } else {
            [self.datadict setValue:[NSNumber numberWithInt:1] forKey:@"is_bookmark"];
        }
        [self loaddata];
        [self.pc hidenview];
    } else {
        [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
    }
}

- (IBAction)btnreportPress:(id)sender {
    [self.pc hidenview];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    

    self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
    self.pc.view.frame = self.view.frame;
    popupview = self.pc.bgview;
    self.pc.popuptype = @"report";
    [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:popupview];
    [self.pc startview];
}

- (IBAction)btneditPress:(id)sender {
    
}

- (IBAction)btndeletePress:(id)sender {
    NSDictionary *resultDict = [ApiHandler contentsdelete:[[self.datadict objectForKey:@"idx"] intValue]];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
    }
}

- (IBAction)btnreplydeletePress:(id)sender {
    
}

- (IBAction)btnreplyeditPress:(id)sender {
    
}

- (IBAction)btnlikePress:(id)sender {
    User *user = [User sharedInstance];
    NSLog(@"%@",user.token);
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        NSDictionary *resultdict = [ApiHandler contentslike:[[self.datadict objectForKey:@"idx"] intValue]];
        NSLog(@"%@",[resultdict description]);
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
           
            if ([self.imglike1.image isEqual:[UIImage imageNamed:@"imgunlike"]]) {
                self.imglike1.image = [UIImage imageNamed:@"imglike"];
            } else {
                self.imglike1.image = [UIImage imageNamed:@"imgunlike"];
            }
            NSDictionary *dt = [resultdict objectForKey:@"data"];
            self.lbllikecount1.text = [[dt objectForKey:@"likes_count"] stringValue];
        }
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)btnreplylikePress:(id)sender {
    User *user = [User sharedInstance];
    NSLog(@"%@",user.token);
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIButton *btn = (UIButton *)sender;
        self.selectitem = [self.subviewsCenterArray objectAtIndex:btn.tag];
        NSLog(@"%@",[self.selectitem description]);
        NSDictionary *resultdict = [ApiHandler contentscommentlike:[[self.selectitem objectForKey:@"idx"] intValue]];
        NSLog(@"%@",[resultdict description]);
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            commentNoCell *cell = (commentNoCell *)btn.superview.superview.superview;
            if ([cell.imglike.image isEqual:[UIImage imageNamed:@"imgunlike"]]) {
                cell.imglike.image = [UIImage imageNamed:@"imglike"];
            } else {
                cell.imglike.image = [UIImage imageNamed:@"imgunlike"];
            }
            NSDictionary *dt = [resultdict objectForKey:@"data"];
            if ([[[dt objectForKey:@"likes_count"] stringValue] isEqualToString:@"0"]) {
                cell.lbllike.hidden = true;
                cell.replycont.constant = -120;
            } else {
                cell.lbllike.hidden = false;
                cell.replycont.constant = 30;
                cell.lbllike.text = [NSString stringWithFormat:@"좋아요 %@개", [[dt objectForKey:@"likes_count"] stringValue]];
            }
            [cell reloadInputViews];
        }
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)btnreplyPress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.replytype = @"reply";
    self.selectitem = [self.subviewsCenterArray objectAtIndex:btn.tag];
    NSLog(@"%@",[self.selectitem description]);
    self.txtreply.text =[NSString stringWithFormat:@"@%@ ", [self.selectitem objectForKey:@"nickname"]];
    [self.txtreply becomeFirstResponder];
}

- (IBAction)btnreply1Press:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.replytype = @"reply";
    self.selectitem = [self.subviewsCenterArray objectAtIndex:btn.tag];
    NSLog(@"%@",[self.selectitem description]);
    self.txtreply.text =[NSString stringWithFormat:@"@%@ ", [self.selectitem objectForKey:@"nickname"]];
    [self.txtreply becomeFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        int  height = (self.listView.frame.size.width-40) * 0.815;
        NSDictionary *dt = [self.subviewsCenterArray objectAtIndex:0];
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = [[dt objectForKey:@"contents"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        lbl.numberOfLines = 0;
        lbl.lineBreakMode = NSLineBreakByWordWrapping;
        lbl.font = [UIFont fontWithName:@"SBAggroB" size:15];
        [lbl sizeToFit];
        if (lbl.frame.size.height > 20) {
            height = height + (lbl.frame.size.height - 20);
        }
        
    
        return 220 + height;
    }  else {
        int height = 70;
        NSDictionary *dt = [self.subviewsCenterArray objectAtIndex:[indexPath row]];
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = [[dt objectForKey:@"contents"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        lbl.numberOfLines = 0;
        lbl.lineBreakMode = NSLineBreakByWordWrapping;
        lbl.font = [UIFont fontWithName:@"SBAggroB" size:15];
        [lbl sizeToFit];
        if (lbl.frame.size.height > 20) {
            height = height + (lbl.frame.size.height - 20);
        }
        return height;
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


- (IBAction)btnsendPress:(id)sender {
    User *user = [User sharedInstance];
    NSLog(@"%@",user.token);
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        if ([self.txtreply.text isEqualToString:@""]) {
            [FSToast showToast:self messge:@"댓글을 입력하세요"];
            return;
        }
        
        if ([self.replyeditYN isEqualToString:@"Y"]) {
            
        } else {
            if ([self.replytype isEqualToString:@"reply"]) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:[self.datadict objectForKey:@"idx"] forKey:@"content_idx"];
                [dic setValue:[self.selectitem objectForKey:@"idx"] forKey:@"content_comment_idx"];
                [dic setValue:self.txtreply.text forKey:@"contents"];
                NSDictionary *resultdict = [ApiHandler contentsCommentswrite:dic];
                if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                    [self loaddata];
                    self.txtreply.text = @"";
                    [self.txtreply resignFirstResponder];
                } else {
                    [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
                }
            } else {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:[self.datadict objectForKey:@"idx"] forKey:@"content_idx"];
                [dic setValue:self.txtreply.text forKey:@"contents"];
                NSDictionary *resultdict = [ApiHandler contentsCommentswrite:dic];
                if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                    [self loaddata];
                    self.txtreply.text = @"";
                    [self.txtreply resignFirstResponder];
                } else {
                    [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
                }
            }
        }
      
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    //[self.navigationController pushViewController:dc animated:YES];
       
    }
}

- (IBAction)btnloginPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    
    LoginController *dc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];

    [self.navigationController pushViewController:dc animated:YES];
    [self.pc hidenview];
}

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

@end
