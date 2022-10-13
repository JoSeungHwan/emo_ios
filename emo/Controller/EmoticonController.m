//
//  EmoticonController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "EmoticonController.h"
#import "EmoticonCell.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImagePhotosPlugin/SDWebImagePhotosPlugin.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "EmoticonDetailController.h"
#import "User.h"
#import "MyEmoticonController.h"
#import "LoginController.h"

@interface EmoticonController ()

@end

@implementation EmoticonController
@synthesize btnsort, btnsearch, btnsorttype1, btnsorttype2, listView, listArray, txtsearch, sortview, lblsort, sortV, pc;
NSString *sort;
- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"이모티콘";
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
    [rightbtn setTitle:@"My" forState:UIControlStateNormal];
    [rightbtn setFont:[UIFont fontWithName:@"SBAggroB" size:16]];
    [rightbtn setTitleColor:[UIColor colorWithRed:(255.0f/255.0f) green:(206.0f/255.0f) blue:(0.0f/255.0f) alpha:1] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(btnmyPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
        
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
    self.sortV.layer.cornerRadius = self.sortV.frame.size.height/2;
    self.sortview.layer.cornerRadius = self.sortV.frame.size.height/2;
    sort = @"popular";
    [super viewDidLoad];
}

- (void)loadData {
    NSDictionary *resultdict = [ApiHandler emoticonlist:1 order:sort search:@""];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dt = [resultdict objectForKey:@"data"];
        self.listArray = [[NSMutableArray alloc] initWithArray:[dt objectForKey:@"data"]];
        [self.listView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self loadData];
    [super viewWillAppear:animated];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnmyPress:(id)sender{
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        [self.pc.btnorderemoticon addTarget:self action:@selector(btnorderemotionPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.pc.btnmyemoticon addTarget:self action:@selector(btnmyemotionPress:) forControlEvents:UIControlEventTouchUpInside];
        
        self.pc.popuptype = @"myemoticon";
            
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

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

-(IBAction)btnloginPress:(id)sender {
   UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                          bundle:nil];
   
   LoginController *dc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];

   [self.navigationController pushViewController:dc animated:YES];
   [self.pc hidenview];
}


- (IBAction)btnorderemotionPress:(id)sender {
    [self.pc hidenview];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    MyEmoticonController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyEmoticonController"];
    dc.stype = @"order";
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnmyemotionPress:(id)sender {
    [self.pc hidenview];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    MyEmoticonController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyEmoticonController"];
    dc.stype = @"my";
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnsortPress:(id)sender {
    self.sortview.hidden = NO;
}

- (IBAction)btnsort1Press:(id)sender {
    self.lblsort.text = @"인기순";
    self.sortview.hidden = YES;
    sort = @"popular";
    NSDictionary *resultdict = [ApiHandler emoticonlist:1 order:sort search:self.txtsearch.text];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dt = [resultdict objectForKey:@"data"];
        self.listArray = [[NSMutableArray alloc] initWithArray:[dt objectForKey:@"data"]];
        [self.listView reloadData];
    }
}

- (IBAction)btnsort2Press:(id)sender {
    self.lblsort.text = @"최신순";
    self.sortview.hidden = YES;
    sort = @"new";
    NSDictionary *resultdict = [ApiHandler emoticonlist:1 order:sort search:self.txtsearch.text];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dt = [resultdict objectForKey:@"data"];
        self.listArray = [[NSMutableArray alloc] initWithArray:[dt objectForKey:@"data"]];
        [self.listView reloadData];
    }
}

- (IBAction)btnsearchPress:(id)sender {
    NSDictionary *resultdict = [ApiHandler emoticonlist:1 order:sort search:self.txtsearch.text];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dt = [resultdict objectForKey:@"data"];
        self.listArray = [[NSMutableArray alloc] initWithArray:[dt objectForKey:@"data"]];
        [self.listView reloadData];
    }
}

- (IBAction)btnmorePress:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        UIButton *btn = (UIButton *)sender;
        int idx = btn.tag - 1000;
        NSDictionary *dt = [self.listArray objectAtIndex:idx] ;
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

- (IBAction)btndeletePress:(id)sender {
    
    NSDictionary *resultDict = [ApiHandler contentsdelete:[[self.selectcontent objectForKey:@"content_idx"] intValue]];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        [self loadData];
        [self.pc hidenview];
    } else {
        [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
    }

}

- (IBAction)btneditPress:(id)sender {
    
}

- (IBAction)btnsharePress:(id)sender {
    [self.pc hidenview];
    NSLog(@"%@",[self.selectcontent description]);
    NSString *link = @"";
    
    link = [NSString stringWithFormat:@"https://m.emomanse.com/api/sharelink?type=contents&idx=%@",[self.selectcontent objectForKey:@"idx"]];
        
    
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
   
    NSString *link = [NSString stringWithFormat:@"https://m.emomanse.com/api/sharelink?type=contents&idx=%@",[self.selectcontent objectForKey:@"idx"]];
    [[UIPasteboard generalPasteboard] setString:link];
    
    [FSToast showToast:self messge:@"링크주소가 복사되었습니다."];
}

- (IBAction)btnbookmarkPress:(id)sender {
    NSLog(@"%@",[self.selectcontent description]);
    
    NSDictionary *resultDict = [ApiHandler contentbookmark:[[self.selectcontent objectForKey:@"idx"] intValue]];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        [self loadData];
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
    [self.parentViewController.navigationController.view addSubview:popupview];
    [self.pc startview];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];

      
    EmoticonCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"EmoticonCell-%ld",(long)[indexPath row]]];
  
      //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"EmoticonCell" owner:self options:nil];
            cell = arr[0];
            
        }
    NSLog(@"%@",[dt1 description]);
    cell.lblname.text = [dt1 objectForKey:@"emoticon_name"];
    cell.lblcont.text = [dt1 objectForKey:@"contents"];
    cell.lblnickname.text = [dt1 objectForKey:@"nickname"];
    [cell.lblnickname sizeToFit];
    cell.nickview.frame = CGRectMake(cell.nickview.frame.origin.x, cell.nickview.frame.origin.y, cell.lblnickname.frame.size.width + 10, cell.nickview.frame.size.height);
    cell.nickview.layer.cornerRadius = 5;
    cell.btnmore.tag = 1000 +[indexPath row];
    [cell.btnmore addTarget:self action:@selector(btnmorePress:) forControlEvents:UIControlEventTouchUpInside];
    cell.lbllikecount.text = [[dt1 objectForKey:@"likes_count"] stringValue];
    if ([[[dt1 objectForKey:@"is_like"] stringValue] isEqualToString:@"1"]) {
        cell.imglike.image = [UIImage imageNamed:@"imglike"];
    } else {
        cell.imglike.image = [UIImage imageNamed:@"imgunlike"];
    }
    NSArray *sfile = [dt1 objectForKey:@"files"];
    if ([sfile count] > 0) {
        NSDictionary *dt = [sfile objectAtIndex:0];
        if (![[dt objectForKey:@"path"] isEqual:[NSNull null]]) {
            //cell.imgcont.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dt objectForKey:@"path"]]]];
            SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
            [downloader downloadImageWithURL:[NSURL URLWithString:[dt objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (image && finished) {
                    cell.imgcont.image = image;
                    // do something with image
                    
                }
            }];
            cell.imgcont.layer.cornerRadius = 10;
            cell.imgcont.layer.borderColor = [[UIColor colorWithRed:(232.0/255.0f) green:(232.0/255.0f) blue:(232.0/255.0f) alpha:1] CGColor];
            cell.imgcont.layer.borderWidth = 1;
            cell.imgcont.layer.shadowColor = [[UIColor colorWithRed:(242.0/255.0f) green:(242.0/255.0f) blue:(242.0/255.0f) alpha:1] CGColor];
            cell.imgcont.layer.shadowOffset = CGSizeMake(10, 10);
            cell.imgcont.layer.shadowRadius = 10;
            cell.imgcont.layer.shadowOpacity = 0.5;
        }
    }
   

    
        return cell;
 
      

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dt = [self.listArray objectAtIndex:[indexPath row]];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    EmoticonDetailController *dc = [storyboard instantiateViewControllerWithIdentifier:@"EmoticonDetailController"];
    dc.idx = [[dt objectForKey:@"idx"] intValue];
    [self.navigationController pushViewController:dc animated:YES];

}

@end
