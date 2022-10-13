//
//  ViewController.m
//  emo
//
//  Created by choi hyoung jun on 2022/08/24.
//

#import "homeController.h"
#import "AppDelegate.h"
#import "ApiHandler.h"
#import "ContentCell.h"
#import "StoriesContentCell.h"
#import "RepliesContent.h"
#import "LandingController.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImagePhotosPlugin/SDWebImagePhotosPlugin.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailController.h"
#import "DetailStoriesController.h"
#import "User.h"
#import "notiController.h"
#import "LoginController.h"
#import "MoreController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "UserProfileController.h"
#import "MyProfileController.h"
#import "ReplyDrawController.h"

@interface homeController () <UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray<NSURL *> *objects;
@end

@implementation homeController
@synthesize listView, listArray, pc, selectcontent, settingdict, btnorder, btnfilter;


- (void)viewDidLoad {
    
    
    UIImageView *titleimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 106, 44)];
    titleimg.image = [UIImage imageNamed:@"logo1"];
    titleimg.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleimg;
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setFrame:CGRectMake(0, 0, 44, 44)];
    [leftbtn setImage:[UIImage imageNamed:@"btnmenu"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(btnmorePress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarbtn = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem =leftbarbtn;
    
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setFrame:CGRectMake(0, 0, 44, 44)];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"notiicon1"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(notiPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    self.objects = [NSMutableArray array];
    
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    
    SDWebImageManager.defaultImageLoader = [SDImagePhotosLoader sharedLoader];
   PHImageRequestOptions *options = [PHImageRequestOptions new];
   options.sd_targetSize = CGSizeMake(500, 500); // The original image size may be 4K, we only query the max view size :)
   SDImagePhotosLoader.sharedLoader.imageRequestOptions = options;
   // Request Video Asset Poster as well
   SDImagePhotosLoader.sharedLoader.requestImageAssetOnly = NO;
    
   

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"autologin"] isEqualToString:@"Y"]) {
        User *user = [User sharedInstance];
        user.token = [defaults objectForKey:@"token"];
        NSDictionary *resultdict = [ApiHandler refreshtoken];
        NSDictionary *datadict = [resultdict objectForKey:@"data"];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            [user userinit:datadict];
            [defaults setValue:user.token forKey:@"token"];
            [defaults synchronize];
        }else {
            user.token = nil;
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loaddata)
                                                 name:@"reloaddata"
                                               object:nil];
  /*  if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
            //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibg.png"] forBarMetrics: UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar insertSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navibg.png"]] atIndex:0];
    }*/
    
  /*  UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:@"LandingNavi"];
   
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:NO completion:nil];*/
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)btnmorePress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    MoreController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MoreController"];
    
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (IBAction)notiPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    notiController *dc = [storyboard instantiateViewControllerWithIdentifier:@"notiController"];
    
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnsortPress:(id)sender {
    
}

- (IBAction)btnfilterPress:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        NSDictionary *resultdict = [ApiHandler homesetting];
        self.settingdict = [[NSMutableDictionary alloc] init];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]){
            
            [self.settingdict addEntriesFromDictionary:[resultdict objectForKey:@"data"]];
            NSLog(@"%@",[self.settingdict description]);
            NSDictionary *datadict = [resultdict objectForKey:@"data"];
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                   bundle:nil];
            self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
            self.pc.view.frame = self.view.frame;
            popupview = self.pc.bgview;
            self.pc.popuptype = @"setting";
            [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnsave addTarget:self action:@selector(btnsavePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.parentViewController.navigationController.view addSubview:popupview];
            
            [self.pc startview];
            
            NSString *scat = [datadict objectForKey:@"categorys"];
            NSArray *categoryarr = [scat componentsSeparatedByString:@","];
            
            for (int i =0 ; i < [self.pc.categoryList count] ; i++) {
                NSDictionary *dt = [self.pc.categoryList objectAtIndex:i];
                UIButton *btn = [dt objectForKey:@"button"];
                [btn addTarget:self action:@selector(btncategorySelect:) forControlEvents:UIControlEventTouchUpInside];
                NSDictionary *dt1 = [dt objectForKey:@"data"];
                NSString *scode = [dt1 objectForKey:@"code"];
                for (int j = 0 ; j < [categoryarr count] ; j++) {
                    if ([scode isEqualToString:[categoryarr objectAtIndex:j]]) {
                        btn.selected = true;
                    }
                }
            }
            
            [self.pc.btntooncheck addTarget:self action:@selector(btncategorytypePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnreplytooncheck addTarget:self action:@selector(btncategorytypePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnemoticoncheck addTarget:self action:@selector(btncategorytypePress:) forControlEvents:UIControlEventTouchUpInside];
            if ([[[datadict objectForKey:@"follow"] stringValue] isEqualToString:@"1"]) {
                self.pc.btnfollowingcheck.selected = true;
            }
            if (![[datadict objectForKey:@"content_types"] isEqualToString:@""]) {
                NSString *str = [datadict objectForKey:@"content_types"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                for (int j = 0 ; j < [arr count] ; j ++) {
                    NSString *scode = [arr objectAtIndex:j];
                    if ([scode isEqualToString:@"1000"]) {
                        self.pc.btnreplytooncheck.selected = true;
                    } else if ([scode isEqualToString:@"2000"]) {
                        self.pc.btntooncheck.selected = true;
                    } else if ([scode isEqualToString:@"4000"]) {
                        self.pc.btnemoticoncheck.selected = true;
                    }
                }
            }
            [self.pc.btnfollowingcheck addTarget:self action:@selector(btnfollowsettingPress:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    } else {
        [self btnloginPress:nil];
    }
}

- (IBAction)btnsavePress:(id)sender {
    NSDictionary *resultdict = [ApiHandler homesettingsave:self.settingdict];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]){
        [self.pc hidenview];
        [self loaddata];
    }
}

- (IBAction)btnfollowsettingPress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.settingdict setValue:@"1" forKey:@"follow"];
    } else {
        [self.settingdict setValue:@"0" forKey:@"follow"];
    }
    NSLog(@"%@",[self.settingdict description]);
}

- (IBAction)btncategorytypePress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    int itag = btn.tag;
    if (btn.selected) {
        NSString *str = [self.settingdict objectForKey:@"content_types"];
        NSArray *arr = [str componentsSeparatedByString:@","];
        if ([arr count] ==0) {
            [self.settingdict setValue:[NSString stringWithFormat:@"%d", itag] forKey:@"content_types"];
        } else {
            str = [NSString stringWithFormat:@"%@,%@",str, [NSString stringWithFormat:@"%d", itag]];
        }
        [self.settingdict setValue:str forKey:@"content_types"];
    } else {
        NSString *str = [self.settingdict objectForKey:@"content_types"];
        NSArray *arr = [str componentsSeparatedByString:@","];
        NSString *newstr = @"";
        for (int i = 0 ; i < [arr count] ; i++) {
            if (![[arr objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%d",itag]]) {
                if ([newstr isEqualToString:@""]) {
                    newstr = [arr objectAtIndex:i];
                } else {
                    newstr = [NSString stringWithFormat:@"%@,%@",newstr, [arr objectAtIndex:i]];
                }
            }
        }
        [self.settingdict setValue:newstr forKey:@"content_types"];
    }
    NSLog(@"%@",[self.settingdict description]);
}

- (IBAction)btncategorySelect:(id)sender {
    UIButton *btn1 = (UIButton *)sender;
    NSDictionary *selectdt = nil;
    for (int i =0 ; i < [self.pc.categoryList count] ; i++) {
        NSDictionary *dt = [self.pc.categoryList objectAtIndex:i];
        UIButton *btn = [dt objectForKey:@"button"];
        if ([btn isEqual:btn1]) {
            selectdt = [dt objectForKey:@"data"];
        }
        
        
    }
    btn1.selected = !btn1.selected;
    if (btn1.selected) {
        NSString *str = [self.settingdict objectForKey:@"categorys"];
        NSArray *arr = [str componentsSeparatedByString:@","];
        if ([arr count] ==0) {
            [self.settingdict setValue:[selectdt objectForKey:@"code"] forKey:@"categorys"];
        } else {
            str = [NSString stringWithFormat:@"%@,%@",str, [selectdt objectForKey:@"code"]];
        }
        [self.settingdict setValue:str forKey:@"categorys"];
    } else {
        NSString *str = [self.settingdict objectForKey:@"categorys"];
        NSArray *arr = [str componentsSeparatedByString:@","];
        NSString *newstr = @"";
        for (int i = 0 ; i < [arr count] ; i++) {
            if (![[arr objectAtIndex:i] isEqualToString:[selectdt objectForKey:@"code"]]) {
                if ([newstr isEqualToString:@""]) {
                    newstr = [arr objectAtIndex:i];
                } else {
                    newstr = [NSString stringWithFormat:@"%@,%@",newstr, [arr objectAtIndex:i]];
                }
            }
        }
        [self.settingdict setValue:newstr forKey:@"categorys"];
    }
    NSLog(@"%@",[self.settingdict description]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loaddata];
}

- (void)loaddata {
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *CurrentDate = [[NSDate alloc] init];
    NSString *CurrentDateString = [dateformat stringFromDate:CurrentDate];
    
    NSDictionary *dict = [ApiHandler contentList:@"new" date:CurrentDateString page:1];
    if ([[dict objectForKey:@"message"] isEqualToString:@"Ok"]) {
      
        self.listArray = [[[dict objectForKey:@"data"] objectForKey:@"content_lists"] objectForKey:@"data"];
       
        [self.listView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];
    
    if ([[dt1 objectForKey:@"contents"] isKindOfClass:[NSDictionary class]]) {
       
        ContentCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentCell-%ld",(long)[indexPath row]]];
        
        //cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"contentcell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"ContentCell" owner:self options:nil];
            cell = arr[0];
            
            
       
            NSDictionary *dt = [dt1 objectForKey:@"contents"] ;
            
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
           
            cell.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dt objectForKey:@"profile_image_url"]]]];
            cell.imgprofile.layer.cornerRadius = cell.imgprofile.frame.size.height / 2;
            cell.imgprofile.clipsToBounds = true;
            cell.lbllikecount.text  = [[dt objectForKey:@"likes_count"] stringValue];
            cell.lblreplycount.text = [[dt objectForKey:@"replies_count"] stringValue];
            cell.btnlike.tag = 1000 + indexPath.row;
            [cell.btnlike addTarget:self action:@selector(btnlikePress:) forControlEvents:UIControlEventTouchUpInside];
            if ([[[dt objectForKey:@"is_like"] stringValue] isEqualToString:@"1"]) {
                cell.imglike.image = [UIImage imageNamed:@"imglike"];
            } else {
                cell.imglike.image = [UIImage imageNamed:@"imgunlike"];
            }
            cell.btnmore.tag = 2000 + indexPath.row;
            [cell.btnmore addTarget:self action:@selector(btnmorepopupPress:) forControlEvents:UIControlEventTouchUpInside];
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
        NSString *simpleTableIdentifier = @"storiescell";
        
        StoriesContentCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
        NSDictionary *dt = [dt1 objectForKey:@"stories"];
      //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"StoriesContentCell" owner:self options:nil];
            cell = arr[0];
            
           
      
        
        
            cell.lblcontent.text =[[dt objectForKey:@"contents"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            cell.lbltype.text = @"#댓툰";
            cell.imgtype.image = [UIImage imageNamed:@"type1000bg"];
            cell.scrollView.showsHorizontalScrollIndicator = YES;
            cell.scrollView.showsVerticalScrollIndicator=NO;
            CGRect frame = cell.scrollView.frame;
            frame.size.width = [[UIScreen mainScreen] bounds].size.width;
            cell.scrollView.frame = frame;
            cell.scrollView.pagingEnabled = YES;
            cell.scrollView.bounces = false;
            cell.btnmore.tag = 2000 + indexPath.row;
            [cell.btnmore addTarget:self action:@selector(btnmorepopup1Press:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnreplydraw.tag = 3000 + indexPath.row;
            [cell.btnreplydraw addTarget:self action:@selector(btnreplydrawPress:) forControlEvents:UIControlEventTouchUpInside];
            cell.scrollView.showsHorizontalScrollIndicator = false;
            if ([[dt objectForKey:@"replies"] count] == 1) {
                NSDictionary *subdic = [[dt objectForKey:@"replies"] objectAtIndex:0];
                int width = cell.scrollView.frame.size.width - 40;
                int height = width * 0.815;
              
                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"RepliesContent" owner:self options:nil];
                RepliesContent *contentV = (RepliesContent *)[views lastObject];
                contentV.frame = CGRectMake(20, 0, width, height +120);
                frame.size.height = contentV.frame.size.height;
                contentV.lblcontent.text = [NSString stringWithFormat:@"%@ %@",[subdic objectForKey:@"nickname"],[[subdic objectForKey:@"contents"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"]];
                contentV.lbllikecount.text = [[subdic objectForKey:@"likes_count"] stringValue];
                contentV.lblrepliescount.text =[[subdic objectForKey:@"comments_count"] stringValue];
                if ([[[subdic objectForKey:@"is_like"] stringValue] isEqualToString:@"0"]) {
                    contentV.imglike.image = [UIImage imageNamed:@"imgunlike"];
                } else {
                    contentV.imglike.image = [UIImage imageNamed:@"imglike"];
                }
                contentV.btnlike.tag = 100000 + (100 * ([indexPath row]+1)) + 1;
                [contentV.btnlike addTarget:self action:@selector(btnlike1Press:) forControlEvents:UIControlEventTouchUpInside];
                /*SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                NSArray *filesarr = [subdic objectForKey:@"files"];
                NSDictionary *dt1 = [filesarr objectAtIndex:0];
                [downloader downloadImageWithURL:[NSURL URLWithString:[dt1 objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                    if (image && finished) {
                        contentV.imgcont.image = image;
                        // do something with image
                        NSLog(@"  loading        %@    %@  ",[NSURL URLWithString:[subdic objectForKey:@"path"]],[image description]);
                    }
                }];*/
                
               /* [contentV.imgcont sd_setImageWithURL:[NSURL URLWithString:[subdic objectForKey:@"path"]]
                        placeholderImage:nil
                                 options:SDWebImageFromLoaderOnly
                                 context:@{SDWebImageContextStoreCacheType : @(SDImageCacheTypeNone)}]; //*/
             
                contentV.imgcont.contentMode = UIViewContentModeScaleToFill;
                contentV.imgcont.layer.cornerRadius=10;
                contentV.imgcont.clipsToBounds = true;
                if ([[subdic objectForKey:@"profile_image_url"] isKindOfClass:[NSString class]]) {
                    contentV.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[subdic objectForKey:@"profile_image_url"]]]];
                    contentV.imgprofile.layer.cornerRadius = contentV.imgprofile.frame.size.height / 2;
                    contentV.imgprofile.clipsToBounds = true;
                }
                [cell.scrollView addSubview:contentV];
            } else {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    // retrive image on global queue
                    //UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:kImgLink]]];

                    dispatch_async(dispatch_get_main_queue(), ^{

                        for (int i = 0 ; i < [[dt objectForKey:@"replies"] count]; i++) {
                           
                            NSDictionary *subdic = [[dt objectForKey:@"replies"] objectAtIndex:i];
                            NSArray *filesarr = [subdic objectForKey:@"files"];
                            NSDictionary *dt1 = [filesarr objectAtIndex:0];
                            NSURL *url = [NSURL URLWithString:[dt1 objectForKey:@"path"]];

                            StoriesContentCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                            if (updateCell){
                               // updateCell.poster.image = image;
                                int width = cell.scrollView.frame.size.width - 40;
                                int height = width * 0.815;
                              
                                int offset = 10;
                                if (i == 0){
                                    offset = 20;
                                }
                                CGRect frame = cell.scrollView.frame;
                                frame.size.width = [[UIScreen mainScreen] bounds].size.width;
                                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"RepliesContent" owner:self options:nil];
                                RepliesContent *contentV = (RepliesContent *)[views lastObject];
                                contentV.frame = CGRectMake((i * (cell.scrollView.frame.size.width- 50)) + offset + (i * 20), 0, width, height+120);
                                
                                contentV.lblcontent.text = [NSString stringWithFormat:@"%@ %@",[subdic objectForKey:@"nickname"], [[subdic objectForKey:@"contents"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"]];
                                contentV.lbllikecount.text = [[subdic objectForKey:@"likes_count"] stringValue];
                                contentV.lblrepliescount.text =[[subdic objectForKey:@"comments_count"] stringValue];
                                if ([[[subdic objectForKey:@"is_like"] stringValue] isEqualToString:@"0"]) {
                                    contentV.imglike.image = [UIImage imageNamed:@"imgunlike"];
                                } else {
                                    contentV.imglike.image = [UIImage imageNamed:@"imglike"];
                                }
                                contentV.btnlike.tag = 100000 + (100 * ([indexPath row]+1)) + (i+1);
                                [contentV.btnlike addTarget:self action:@selector(btnlike1Press:) forControlEvents:UIControlEventTouchUpInside];
                                contentV.btnmore.tag =  100000 + (100 * ([indexPath row]+1)) + (i+1);
                                [contentV.btnmore addTarget:self action:@selector(btnreplymorePress:) forControlEvents:UIControlEventTouchUpInside];
                                contentV.btnimg.tag = [[subdic objectForKey:@"user_idx"] intValue];
                                [contentV.btnimg addTarget:self action:@selector(btnprofilePress:) forControlEvents:UIControlEventTouchUpInside];
                                SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                                NSArray *filesarr = [subdic objectForKey:@"files"];
                                NSDictionary *dt1 = [filesarr objectAtIndex:0];
                                [downloader downloadImageWithURL:[NSURL URLWithString:[dt1 objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                                    if (image && finished) {
                                        contentV.imgcont.image = image;
                                        // do something with image
                                        NSLog(@"  loading        %@    %@  ",[NSURL URLWithString:[subdic objectForKey:@"path"]],[image description]);
                                    }
                                }];
                                
                             
                                contentV.imgcont.contentMode = UIViewContentModeScaleToFill;
                                contentV.imgcont.layer.cornerRadius=10;
                                contentV.imgcont.clipsToBounds = true;
                                
                                if ([[subdic objectForKey:@"profile_image_url"] isKindOfClass:[NSString class]]) {
                                    contentV.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[subdic objectForKey:@"profile_image_url"]]]];
                                    contentV.imgprofile.layer.cornerRadius = contentV.imgprofile.frame.size.height / 2;
                                    contentV.imgprofile.clipsToBounds = true;
                                }
                                frame.size.height = contentV.frame.size.height;
                                
                                [cell.scrollView addSubview:contentV];
                            }
                           //[task resume];
                           
                        }
                    });
                });

                
                [cell.scrollView setContentSize:CGSizeMake((cell.scrollView.frame.size.width-20) * [[dt objectForKey:@"replies"] count], cell.scrollView.frame.size.height-40)];
            }
            //
            cell.scrollView.frame = frame;
        }
        return cell;
    }
    return nil;
    

}

- (IBAction)btnreplydrawPress:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIButton *btn = (UIButton *)sender;
        int idx = btn.tag - 3000;
        NSDictionary *dt = [[self.listArray objectAtIndex:idx] objectForKey:@"stories"];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        ReplyDrawController *dc = [storyboard instantiateViewControllerWithIdentifier:@"ReplyDrawController"];
        dc.idx = [dt objectForKey:@"idx"];
        [self.parentViewController.navigationController pushViewController:dc animated:YES];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.parentViewController.navigationController.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)btnprofilePress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    int useridx = btn.tag;
    User *user = [User sharedInstance];
    if (useridx == user.idx) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        MyProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyProfileController"];
        
        [self.parentViewController.navigationController pushViewController:dc animated:YES];
    
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                  bundle:nil];
          
        UserProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"UserProfileController"];
        dc.useridx = useridx;
       [self.parentViewController.navigationController pushViewController:dc animated:YES];
   }
    
}

- (IBAction)btnmorepopupPress:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIButton *btn = (UIButton *)sender;
        int idx = btn.tag - 2000;
        NSDictionary *dt = [[self.listArray objectAtIndex:idx] objectForKey:@"contents"];
        NSLog(@"%@", [dt description]);
        self.selectcontent = [[NSMutableDictionary alloc] initWithDictionary:dt];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        if ([[dt objectForKey:@"nickname"] isEqualToString:user.nickname]) {
            self.pc.popuptype = @"mycontentmore";
            
            [self.pc.btndelete addTarget:self action:@selector(btndeletePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnedit addTarget:self action:@selector(btneditPress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnshare addTarget:self action:@selector(btnsharePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnlink addTarget:self action:@selector(btnlinkPress:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            self.pc.popuptype = @"contentmore";
            if ([[[dt objectForKey:@"is_bookmark"] stringValue] isEqualToString:@"1"]) {
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
        [self.parentViewController.navigationController.view addSubview:popupview];
        
        [self.pc startview];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.parentViewController.navigationController.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)btnmorepopup1Press:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIButton *btn = (UIButton *)sender;
        int idx = btn.tag - 2000;
        NSDictionary *dt = [[self.listArray objectAtIndex:idx] objectForKey:@"stories"];
        NSLog(@"%@", [dt description]);
        self.selectcontent = [[NSMutableDictionary alloc] initWithDictionary:dt];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        if ([[dt objectForKey:@"nickname"] isEqualToString:user.nickname]) {
            self.pc.popuptype = @"mycontentmore";
            
            [self.pc.btndelete addTarget:self action:@selector(btndeletePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnedit addTarget:self action:@selector(btneditPress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnshare addTarget:self action:@selector(btnsharePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnlink addTarget:self action:@selector(btnlinkPress:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            self.pc.popuptype = @"contentmore";
            if ([[[dt objectForKey:@"is_bookmark"] stringValue] isEqualToString:@"1"]) {
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
        [self.parentViewController.navigationController.view addSubview:popupview];
        
        [self.pc startview];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.parentViewController.navigationController.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (IBAction)btnreplymorePress:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIButton *btn = (UIButton *)sender;
        int idx = btn.tag - 100000;
        int idx1 = (int)(idx / 100)-1;
        int idx2 = ((idx % 100)-1);
        NSDictionary *dt = [[self.listArray objectAtIndex:idx1] objectForKey:@"stories"];
        NSArray *arr = [dt objectForKey:@"replies"];
        NSDictionary *dt1 = [arr objectAtIndex:idx2];
        self.selectcontent = [[NSMutableDictionary alloc] initWithDictionary:dt1];
        NSLog(@"%@", [dt1 description]);
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        if ([[dt1 objectForKey:@"nickname"] isEqualToString:user.nickname]) {
            self.pc.popuptype = @"myrepliemore";
            
            [self.pc.btnreplydelete addTarget:self action:@selector(btnreplydeletePress:) forControlEvents:UIControlEventTouchUpInside];
            [self.pc.btnreplyedit addTarget:self action:@selector(btnreplyeditPress:) forControlEvents:UIControlEventTouchUpInside];
           
        } else {
            self.pc.popuptype = @"repliemore";
     
            [self.pc.btnreport1 addTarget:self action:@selector(btnreportPress:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.parentViewController.navigationController.view addSubview:popupview];
        
        [self.pc startview];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.parentViewController.navigationController.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)btndeletePress:(id)sender {
    if ([self.selectcontent objectForKey:@"content_idx"] != nil) {
        NSDictionary *resultDict = [ApiHandler contentsdelete:[[self.selectcontent objectForKey:@"content_idx"] intValue]];
        if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            [self loaddata];
            [self.pc hidenview];
        } else {
            [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
        }
    } else {
        NSDictionary *resultDict = [ApiHandler storiesdelete:[[self.selectcontent objectForKey:@"story_idx"] intValue]];
        if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            [self loaddata];
            [self.pc hidenview];
        } else {
            [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
        }
    }
}

- (IBAction)btneditPress:(id)sender {
    
}

- (IBAction)btnsharePress:(id)sender {
    [self.pc hidenview];
    NSLog(@"%@",[self.selectcontent description]);
    NSString *link = @"";
    if ([self.selectcontent objectForKey:@"content_type"] != nil) {
        link = [NSString stringWithFormat:@"https://m.emomanse.com/api/sharelink?type=contents&idx=%@",[self.selectcontent objectForKey:@"idx"]];
        
    } else {
        link = [NSString stringWithFormat:@"https://m.emomanse.com/api/sharelink?type=stories&idx=%@",[self.selectcontent objectForKey:@"idx"]];
        
    }
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
    if ([self.selectcontent objectForKey:@"content_type"] != nil) {
        NSString *link = [NSString stringWithFormat:@"https://m.emomanse.com/api/sharelink?type=contents&idx=%@",[self.selectcontent objectForKey:@"idx"]];
        [[UIPasteboard generalPasteboard] setString:link];
    } else {
        NSString *link = [NSString stringWithFormat:@"https://m.emomanse.com/api/sharelink?type=stories&idx=%@",[self.selectcontent objectForKey:@"idx"]];
        [[UIPasteboard generalPasteboard] setString:link];
    }
    [FSToast showToast:self messge:@"링크주소가 복사되었습니다."];
}

- (IBAction)btnbookmarkPress:(id)sender {
    NSLog(@"%@",[self.selectcontent description]);
    if ([self.selectcontent objectForKey:@"content_type"] != nil) {
        NSDictionary *resultDict = [ApiHandler contentbookmark:[[self.selectcontent objectForKey:@"idx"] intValue]];
        if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            [self loaddata];
            [self.pc hidenview];
        } else {
            [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
        }
    } else {
        NSDictionary *resultDict = [ApiHandler storiesbookmark:[[self.selectcontent objectForKey:@"idx"] intValue]];
        if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            [self loaddata];
            [self.pc hidenview];
        } else {
            [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
        }
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
    [self.parentViewController.navigationController.view addSubview:popupview];
    [self.pc startview];
    
}

- (IBAction)btnreplydeletePress:(id)sender {
    
}

- (IBAction)btnreplyeditPress:(id)sender {
    
}

- (IBAction)btnlike1Press:(id)sender {
    User *user = [User sharedInstance];
    NSLog(@"%@",user.token);
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIButton *btn = (UIButton *)sender;
        int idx = btn.tag - 100000;
        int idx1 = (int)(idx / 100)-1;
        int idx2 = ((idx % 100)-1);
        NSDictionary *dt = [[self.listArray objectAtIndex:idx1] objectForKey:@"stories"];
        NSArray *arr = [dt objectForKey:@"replies"];
        NSDictionary *dt1 = [arr objectAtIndex:idx2];
                            
        NSLog(@"%@", [dt1 description]);
        NSDictionary *resultdict = [ApiHandler contentslike:[[dt1 objectForKey:@"idx"] intValue]];
        NSLog(@"%@",[resultdict description]);
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            RepliesContent *contentV = (RepliesContent *)btn.superview;
            if ([contentV.imglike.image isEqual:[UIImage imageNamed:@"imgunlike"]]) {
                contentV.imglike.image = [UIImage imageNamed:@"imglike"];
            } else {
                contentV.imglike.image = [UIImage imageNamed:@"imgunlike"];
            }
            NSDictionary *dt = [resultdict objectForKey:@"data"];
            contentV.lbllikecount.text = [[dt objectForKey:@"likes_count"] stringValue];
        }
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.parentViewController.navigationController.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)btnlikePress:(id)sender {
    User *user = [User sharedInstance];
    NSLog(@"%@",user.token);
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIButton *btn = (UIButton *)sender;
        int idx = btn.tag - 1000;
        NSDictionary *dt = [[self.listArray objectAtIndex:idx] objectForKey:@"contents"];
        NSLog(@"%@", [dt description]);
        NSDictionary *resultdict = [ApiHandler contentslike:[[dt objectForKey:@"idx"] intValue]];
        NSLog(@"%@",[resultdict description]);
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            ContentCell *contentV = (ContentCell *)btn.superview.superview.superview;
            if ([contentV.imglike.image isEqual:[UIImage imageNamed:@"imgunlike"]]) {
                contentV.imglike.image = [UIImage imageNamed:@"imglike"];
            } else {
                contentV.imglike.image = [UIImage imageNamed:@"imgunlike"];
            }
            NSDictionary *dt = [resultdict objectForKey:@"data"];
            contentV.lbllikecount.text = [[dt objectForKey:@"likes_count"] stringValue];
        }
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.parentViewController.navigationController.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
    //[self.navigationController pushViewController:dc animated:YES];
        
    }
    
}

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

- (IBAction)btnloginPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    
    LoginController *dc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];

    [self.parentViewController.navigationController pushViewController:dc animated:YES];
    [self.pc hidenview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];
    int height = 350;
    if ([[dt1 objectForKey:@"contents"] isKindOfClass:[NSDictionary class]]) {
        height = (self.listView.frame.size.width-40) * 0.815;
    } else {
        height = ((self.listView.frame.size.width-40) * 0.815) + 80;
    }
    
    return 220 + height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];
   
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    if ([[dt1 objectForKey:@"contents"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dt = [dt1 objectForKey:@"contents"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dt];
        DetailController *dc = [storyboard instantiateViewControllerWithIdentifier:@"DetailController"];
        dc.datadict = dic;
        [self.parentViewController.navigationController pushViewController:dc animated:YES];
    } else {
        NSDictionary *dt = [dt1 objectForKey:@"stories"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dt];
        DetailStoriesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"DetailStoriesController"];
        dc.datadict = dic;
        dc.idx = [dic objectForKey:@"idx"];
        [self.parentViewController.navigationController pushViewController:dc animated:YES];
    }

}

@end
