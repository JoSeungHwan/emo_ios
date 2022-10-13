//
//  MyProfileController.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/26.
//

#import <Foundation/Foundation.h>
#import "MyProfileController.h"
#import "User.h"
#import "ContentImageCell.h"
#import "storiesCell.h"
#import "DetailStoriesController.h"
#import "DetailController.h"
#import "ProfileController.h"
#import "MyFollowController.h"
#import "notiController.h"
#import "MoreController.h"
#import "MySaveController.h"
#import "RepliesController.h"

@interface MyProfileController ()

@end

@implementation MyProfileController
@synthesize btnedit, btnmore, btnfollow, btncontent, btnfolling, btnstories, lbllevel, lblfollow,lblcomment, lblcontent, lblfolling, lblnickname, viewlevel, listView, contentslist, contentView, storieslist, imgprofile, pc;

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
    [rightbtn setImage:[UIImage imageNamed:@"notiicon1"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(notiPress:) forControlEvents:UIControlEventTouchUpInside];
    
   
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;

    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    
    self.btnedit.layer.cornerRadius = 10;
    self.viewlevel.layer.cornerRadius = 5;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];

    [nc addObserver:self selector:@selector(reloaddata)
               name:@"profilerefresh" object:nil];
    [super viewDidLoad];
}

- (IBAction)btnmorePress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    MoreController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MoreController"];
    
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnmorepopupPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    

    self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
    self.pc.view.frame = self.view.frame;
    popupview = self.pc.bgview;
    User *user = [User sharedInstance];
    if (user.level > 3) {
        self.pc.popuptype = @"myprofile";
        [self.pc.btnmyroom addTarget:self action:@selector(btnmyroomPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.pc.btnmyreply addTarget:self action:@selector(btnmyreplyPress:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.pc.popuptype = @"myprofile1";
        [self.pc.btnmyroom1 addTarget:self action:@selector(btnmyroomPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.pc.btnmyreply1 addTarget:self action:@selector(btnmyreplyPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.pc.btngrade addTarget:self action:@selector(btngradePress:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.parentViewController.navigationController.view addSubview:popupview];
    [self.pc startview];
    
}

- (IBAction)btnmyroomPress:(id)sender {
    [self.pc hidenview];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    MySaveController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MySaveController"];
    
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btngradePress:(id)sender {
    [FSToast showToast:self messge:@"서비스 준비중입니다."];
}

- (IBAction)btnmyreplyPress:(id)sender {
    [self.pc hidenview];
    User *user = [User sharedInstance];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    RepliesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"RepliesController"];
    dc.useridx = user.idx;
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

- (IBAction)notiPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    notiController *dc = [storyboard instantiateViewControllerWithIdentifier:@"notiController"];
    
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (void)reloaddata {
    User *user = [User sharedInstance];
    self.lblnickname.text = user.nickname;
    self.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.profile_image_url]]];
    self.imgprofile.layer.cornerRadius = self.imgprofile.frame.size.height / 2;
    self.imgprofile.clipsToBounds = true;
    self.lblcomment.text = user.introduction;
    self.lblcomment.numberOfLines = 0;
    self.lblcomment.lineBreakMode = NSLineBreakByWordWrapping;
    [self.lblcomment sizeToFit];
    
    if (user.level == 0) {
        self.lbllevel.text = @"Guest";
    } else if (user.level == 1) {
        self.lbllevel.text = @"Lv.1 서포터";
    } else if (user.level == 2) {
        self.lbllevel.text = @"Lv.2 연습생";
    } else if (user.level == 3) {
        self.lbllevel.text = @"Lv.3 데뷔";
    } else if (user.level == 4) {
        self.lbllevel.text = @"Lv.4 신인";
    } else if (user.level == 5) {
        self.lbllevel.text = @"Lv.5 프로";
    } else if (user.level == 6) {
        self.lbllevel.text = @"Lv.6 스타";
    }
    [self.lbllevel sizeToFit];
    self.viewlevel.frame = CGRectMake(self.viewlevel.frame.origin.x, self.viewlevel.frame.origin.y, self.lbllevel.frame.size.width + 10, self.viewlevel.frame.size.height);
    
    NSDictionary *resultdt = [ApiHandler userProfile:user.idx];
    NSDictionary *datadict = [resultdt objectForKey:@"data"];
    if ([[[resultdt objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        self.lblcontent.text = [[datadict objectForKey:@"contents_count"] stringValue];
        self.lblfollow.text = [[datadict objectForKey:@"follows_count"] stringValue];
        self.lblfolling.text = [[datadict objectForKey:@"followings_count"] stringValue];
    } else {
        [FSToast showToast:self messge:[resultdt objectForKey:@"message"]];
        
    }
    self.tagpage = 1;
    NSDictionary *dict = [ApiHandler searchProfileContents:user.idx page:1];
    self.contentslist = [[dict objectForKey:@"data"] objectForKey:@"data"];
    NSLog(@"%@",[self.contentslist description]);
   
    [self.contentView reloadData];
    
    NSDictionary *dict1 = [ApiHandler searchProfileStories:user.idx page:1];
    self.storieslist = [[dict1 objectForKey:@"data"] objectForKey:@"data"];
    NSLog(@"%@",[self.storieslist description]);
    
    if ([[[dict1 objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
        self.tagnext = @"N";
    }
    [self.listView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    User *user = [User sharedInstance];
    self.lblnickname.text = user.nickname;
    self.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.profile_image_url]]];
    self.imgprofile.layer.cornerRadius = self.imgprofile.frame.size.height / 2;
    self.imgprofile.clipsToBounds = true;
    self.lblcomment.text = user.introduction;
    self.lblcomment.numberOfLines = 0;
    self.lblcomment.lineBreakMode = NSLineBreakByWordWrapping;
    [self.lblcomment sizeToFit];
    
    if (user.level == 0) {
        self.lbllevel.text = @"Guest";
    } else if (user.level == 1) {
        self.lbllevel.text = @"Lv.1 서포터";
    } else if (user.level == 2) {
        self.lbllevel.text = @"Lv.2 연습생";
    } else if (user.level == 3) {
        self.lbllevel.text = @"Lv.3 데뷔";
    } else if (user.level == 4) {
        self.lbllevel.text = @"Lv.4 신인";
    } else if (user.level == 5) {
        self.lbllevel.text = @"Lv.5 프로";
    } else if (user.level == 6) {
        self.lbllevel.text = @"Lv.6 스타";
    }
    [self.lbllevel sizeToFit];
    self.viewlevel.frame = CGRectMake(self.viewlevel.frame.origin.x, self.viewlevel.frame.origin.y, self.lbllevel.frame.size.width + 10, self.viewlevel.frame.size.height);
    
    NSDictionary *resultdt = [ApiHandler userProfile:user.idx];
    NSDictionary *datadict = [resultdt objectForKey:@"data"];
    if ([[[resultdt objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        self.lblcontent.text = [[datadict objectForKey:@"contents_count"] stringValue];
        self.lblfollow.text = [[datadict objectForKey:@"follows_count"] stringValue];
        self.lblfolling.text = [[datadict objectForKey:@"followings_count"] stringValue];
    } else {
        [FSToast showToast:self messge:[resultdt objectForKey:@"message"]];
        
    }
    self.tagpage = 1;
    NSDictionary *dict = [ApiHandler searchProfileContents:user.idx page:1];
    self.contentslist = [[dict objectForKey:@"data"] objectForKey:@"data"];
    NSLog(@"%@",[self.contentslist description]);
   
    [self.contentView reloadData];
    
    NSDictionary *dict1 = [ApiHandler searchProfileStories:user.idx page:1];
    self.storieslist = [[dict1 objectForKey:@"data"] objectForKey:@"data"];
    NSLog(@"%@",[self.storieslist description]);
    
    if ([[[dict1 objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
        self.tagnext = @"N";
    }
    [self.listView reloadData];
    [super viewWillAppear:animated];
}

- (IBAction)btncontentPress:(id)sender {
    self.btncontent.selected = true;
    self.btnstories.selected = false;
    self.contentView.hidden = NO;
    self.listView.hidden = YES;
}

- (IBAction)btnstoriesPress:(id)sender {
    self.btncontent.selected = false;
    self.btnstories.selected = true;
    self.contentView.hidden = YES;
    self.listView.hidden = NO;
}

- (IBAction)btnprofileeditPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    ProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileController"];
    dc.stype = @"useredit";
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnfollowingPress:(id)sender {
    User *user = [User sharedInstance];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    MyFollowController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyFollowController"];
    dc.stype = @"following";
    dc.useridx = user.idx;
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnfollowPress:(id)sender {
    User *user = [User sharedInstance];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    MyFollowController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyFollowController"];
    dc.stype = @"follow";
    dc.useridx = user.idx;
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [self.storieslist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dt1 = [self.storieslist objectAtIndex:[indexPath row]];

      
    storiesCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiesCell-%ld",(long)[indexPath row]]];
  
  //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"storiesCell" owner:self options:nil];
        cell = arr[0];
        
    }
    cell.lblcontent.text = [dt1 objectForKey:@"contents"];
    
    return cell;
      

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dt1 = [self.storieslist objectAtIndex:[indexPath row]];
    NSLog(@"%@",[dt1 description]);
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dt1];
    [dic setValue:[dt1 objectForKey:@"content_idx"] forKey:@"idx"];
    DetailStoriesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"DetailStoriesController"];
    dc.datadict = dic;
    [self.navigationController pushViewController:dc animated:YES];
    
}


// collection view delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.contentslist count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ContentImageCell *cell = (ContentImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ContentImageCell" forIndexPath:indexPath];

    // configuring cell
    // cell.customLabel.text = [yourArray objectAtIndex:indexPath.row]; // comment this line if you do not want add label from storyboard

    // if you need to add label and other ui component programmatically
    NSDictionary *dt = [self.contentslist objectAtIndex:[indexPath row]];
    NSArray *filearr = [dt objectForKey:@"files"];
    if ([filearr count] > 0) {
        NSDictionary *filedt = [filearr objectAtIndex:0];
        cell.imgContent.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[filedt objectForKey:@"path"]]]];
        cell.imgContent.contentMode = UIViewContentModeScaleToFill;
        cell.imgmulti.hidden = false;
            
    } else {
        NSDictionary *filedt = [filearr objectAtIndex:0];
        cell.imgContent.image = [UIImage imageNamed:[filedt objectForKey:@"path"]];
        cell.imgContent.contentMode = UIViewContentModeScaleToFill;
        cell.imgmulti.hidden = true;
        
    }
    

    return cell;
}

//Note: Above two "numberOfItemsInSection" & "cellForItemAtIndexPath" methods are required.

// this method overrides the changes you have made to inc or dec the size of cell using storyboard.
- (CGSize)collectionView:(UICollectionView *)collectionView layout:   (UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int width = (self.contentView.frame.size.width / 3) -10;
    return CGSizeMake(width, width);

}  // class ends

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSDictionary *dt = [self.contentslist objectAtIndex:indexPath.row];
    NSLog(@"%@", [dt description]);
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    if ([[dt objectForKey:@"type_code"]  isEqualToString:@"1000"]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dt];
        DetailStoriesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"DetailStoriesController"];
        dc.datadict = dic;
        dc.idx = [dic objectForKey:@"story_idx"];
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dt];
        DetailController *dc = [storyboard instantiateViewControllerWithIdentifier:@"DetailController"];
        dc.datadict = dic;
        [self.navigationController pushViewController:dc animated:YES];
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
    if ([scrollView_ isEqual:self.listView]) {
        if(self.listView.contentOffset.y >= (self.listView.contentSize.height - self.listView.bounds.size.height))
        {
            if ([self.tagnext isEqualToString:@"Y"]) {
                self.tagpage = self.tagpage + 1;
                User *user = [User sharedInstance];
                NSDictionary *dict = [ApiHandler searchProfileStories:user.idx page:self.tagpage];
                NSArray *arr = [[dict objectForKey:@"data"] objectForKey:@"data"];
                NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.storieslist];
                [array addObjectsFromArray:arr];
                self.storieslist = array;
                NSLog(@"%@",[self.storieslist description]);
                if ([[[dict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
                    self.tagnext = @"N";
                }
                [self.listView reloadData];
            }
        }
    }
}


@end
