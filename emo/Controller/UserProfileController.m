//
//  UserProfileController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "UserProfileController.h"
#import "notiController.h"
#import "RepliesController.h"
#import "MyFollowController.h"
#import "storiesCell.h"
#import "DetailStoriesController.h"
#import "DetailController.h"
#import "ContentImageCell.h"

@interface UserProfileController ()

@end

@implementation UserProfileController
@synthesize btnmore, btnedit, btnfollow, btnchat, btncontent, btnfolling, btnstories, btnfollowrequest, btnfollwingrequest, lbllevel, lblfollow, lblcomment,lblcontent, lblfolling, lblnickname, contentView, contentslist, listView, storieslist, imgprofile, viewlevel, pc;

- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"프로필";
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
    [rightbtn setImage:[UIImage imageNamed:@"notiicon1"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(notiPress:) forControlEvents:UIControlEventTouchUpInside];
    
   
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;

    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    self.viewlevel.layer.cornerRadius = 5;
    
    self.btnfollowrequest.layer.cornerRadius = 10;
    self.btnfollowrequest.layer.borderColor = [[UIColor blackColor] CGColor];
    self.btnfollowrequest.layer.borderWidth = 1;
    self.btnchat.layer.cornerRadius = 10;
    self.btnfollwingrequest.layer.cornerRadius = 10;
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)notiPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    notiController *dc = [storyboard instantiateViewControllerWithIdentifier:@"notiController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnmorepopupPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    

    self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
    self.pc.view.frame = self.view.frame;
    popupview = self.pc.bgview;
    [self.pc.btnuserreply addTarget:self action:@selector(btnmyreplyPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.pc.btndona addTarget:self action:@selector(btnnoservice:) forControlEvents:UIControlEventTouchUpInside];
    [self.pc.btnlock addTarget:self action:@selector(btnnoservice:) forControlEvents:UIControlEventTouchUpInside];
    self.pc.popuptype = @"userprofile";
        
    [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:popupview];
    [self.pc startview];
    
}
- (IBAction)btnnoservice:(id)sender {
    [self.pc hidenview];
    [FSToast showToast:self messge:@"서비스 준비중입니다."];
    
}

- (IBAction)btnchatPress:(id)sender {
    
}

- (IBAction)btnfollowrequestPress:(id)sender {
    NSDictionary *resultDict = [ApiHandler follow:[NSString stringWithFormat:@"%d",self.useridx] type:@"follow"];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        [self viewWillAppear:YES];
    }
    
}

- (IBAction)btnfollowingrequestPress:(id)sender {
    NSDictionary *resultDict = [ApiHandler follow:[NSString stringWithFormat:@"%d",self.useridx] type:@"following"];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        [self viewWillAppear:YES];
    }
}

- (IBAction)btnmyreplyPress:(id)sender {
    [self.pc hidenview];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    RepliesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"RepliesController"];
    dc.useridx = self.useridx;
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}



- (void)reloaddata {
    NSDictionary *resultDict = [ApiHandler searchuserProfile:self.useridx];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *datadict = [resultDict objectForKey:@"data"];
        self.lblnickname.text = [datadict objectForKey:@"nickname"];
        self.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[datadict objectForKey:@"profile_image_url"]]]];
        self.imgprofile.layer.cornerRadius = self.imgprofile.frame.size.height / 2;
        self.imgprofile.clipsToBounds = true;
        if ([[datadict objectForKey:@"introduction"] isKindOfClass:[NSString class]]) {
            self.lblcomment.text = [datadict objectForKey:@"introduction"];
        } else {
            self.lblcomment.text = @"등록된 내용이 없습니다.";
        }
        self.lblcomment.numberOfLines = 0;
        self.lblcomment.lineBreakMode = NSLineBreakByWordWrapping;
        [self.lblcomment sizeToFit];
        
        if ([[datadict objectForKey:@"level"] intValue] == 0) {
            self.lbllevel.text = @"Guest";
        } else if ([[datadict objectForKey:@"level"] intValue] == 1) {
            self.lbllevel.text = @"Lv.1 서포터";
        } else if ([[datadict objectForKey:@"level"] intValue] == 2) {
            self.lbllevel.text = @"Lv.2 연습생";
        } else if ([[datadict objectForKey:@"level"] intValue] == 3) {
            self.lbllevel.text = @"Lv.3 데뷔";
        } else if ([[datadict objectForKey:@"level"] intValue] == 4) {
            self.lbllevel.text = @"Lv.4 신인";
        } else if ([[datadict objectForKey:@"level"] intValue] == 5) {
            self.lbllevel.text = @"Lv.5 프로";
        } else if ([[datadict objectForKey:@"level"] intValue] == 6) {
            self.lbllevel.text = @"Lv.6 스타";
        }
        [self.lbllevel sizeToFit];
        self.viewlevel.frame = CGRectMake(self.viewlevel.frame.origin.x, self.viewlevel.frame.origin.y, self.lbllevel.frame.size.width + 10, self.viewlevel.frame.size.height);
        
        self.lblcontent.text = [[datadict objectForKey:@"contents_count"] stringValue];
        self.lblfollow.text = [[datadict objectForKey:@"follows_count"] stringValue];
        self.lblfolling.text = [[datadict objectForKey:@"followings_count"] stringValue];
        self.tagpage = 1;
        NSDictionary *dict = [ApiHandler searchProfileContents:self.useridx page:1];
        self.contentslist = [[dict objectForKey:@"data"] objectForKey:@"data"];
        NSLog(@"%@",[self.contentslist description]);
       
        [self.contentView reloadData];
        
        NSDictionary *dict1 = [ApiHandler searchProfileStories:self.useridx page:1];
        self.storieslist = [[dict1 objectForKey:@"data"] objectForKey:@"data"];
        NSLog(@"%@",[self.storieslist description]);
        
        if ([[[dict1 objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
            self.tagnext = @"N";
        }
        [self.listView reloadData];
    } else {
        [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSDictionary *resultDict = [ApiHandler searchuserProfile:self.useridx];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *datadict = [resultDict objectForKey:@"data"];
        self.lblnickname.text = [datadict objectForKey:@"nickname"];
        self.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[datadict objectForKey:@"profile_image_url"]]]];
        self.imgprofile.layer.cornerRadius = self.imgprofile.frame.size.height / 2;
        self.imgprofile.clipsToBounds = true;
        if ([[datadict objectForKey:@"introduction"] isKindOfClass:[NSString class]]) {
            self.lblcomment.text = [datadict objectForKey:@"introduction"];
        } else {
            self.lblcomment.text = @"등록된 내용이 없습니다.";
        }
        self.lblcomment.numberOfLines = 0;
        self.lblcomment.lineBreakMode = NSLineBreakByWordWrapping;
        [self.lblcomment sizeToFit];
        
        if ([[datadict objectForKey:@"level"] intValue] == 0) {
            self.lbllevel.text = @"Guest";
        } else if ([[datadict objectForKey:@"level"] intValue] == 1) {
            self.lbllevel.text = @"Lv.1 서포터";
        } else if ([[datadict objectForKey:@"level"] intValue] == 2) {
            self.lbllevel.text = @"Lv.2 연습생";
        } else if ([[datadict objectForKey:@"level"] intValue] == 3) {
            self.lbllevel.text = @"Lv.3 데뷔";
        } else if ([[datadict objectForKey:@"level"] intValue] == 4) {
            self.lbllevel.text = @"Lv.4 신인";
        } else if ([[datadict objectForKey:@"level"] intValue] == 5) {
            self.lbllevel.text = @"Lv.5 프로";
        } else if ([[datadict objectForKey:@"level"] intValue] == 6) {
            self.lbllevel.text = @"Lv.6 스타";
        }
        [self.lbllevel sizeToFit];
        self.viewlevel.frame = CGRectMake(self.viewlevel.frame.origin.x, self.viewlevel.frame.origin.y, self.lbllevel.frame.size.width + 10, self.viewlevel.frame.size.height);
        
        self.lblcontent.text = [[datadict objectForKey:@"contents_count"] stringValue];
        self.lblfollow.text = [[datadict objectForKey:@"follows_count"] stringValue];
        self.lblfolling.text = [[datadict objectForKey:@"followings_count"] stringValue];
        
        if ([[[datadict objectForKey:@"is_following"] stringValue] isEqualToString:@"1"]) {
            self.btnfollowrequest.hidden = YES;
            self.btnfollwingrequest.hidden = NO;
        } else {
            self.btnfollowrequest.hidden = NO;
            self.btnfollwingrequest.hidden = YES;
        }
        self.tagpage = 1;
        NSDictionary *dict = [ApiHandler searchProfileContents:self.useridx page:1];
        self.contentslist = [[dict objectForKey:@"data"] objectForKey:@"data"];
        NSLog(@"%@",[self.contentslist description]);
       
        [self.contentView reloadData];
        
        NSDictionary *dict1 = [ApiHandler searchProfileStories:self.useridx page:1];
        self.storieslist = [[dict1 objectForKey:@"data"] objectForKey:@"data"];
        NSLog(@"%@",[self.storieslist description]);
        
        if ([[[dict1 objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
            self.tagnext = @"N";
        }
        [self.listView reloadData];
    } else {
        [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
    }
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

- (IBAction)btnfollowingPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    MyFollowController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyFollowController"];
    dc.stype = @"following";
    dc.useridx = self.useridx;
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnfollowPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    MyFollowController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyFollowController"];
    dc.stype = @"follow";
    dc.useridx = self.useridx;
    [self.navigationController pushViewController:dc animated:YES];
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
        cell.imgContent.layer.cornerRadius = 10;
            
    } else {
        NSDictionary *filedt = [filearr objectAtIndex:0];
        cell.imgContent.image = [UIImage imageNamed:[filedt objectForKey:@"path"]];
        cell.imgContent.contentMode = UIViewContentModeScaleToFill;
        cell.imgmulti.hidden = true;
        cell.imgContent.layer.cornerRadius = 10;
        
    }
    

    return cell;
}

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
//Note: Above two "numberOfItemsInSection" & "cellForItemAtIndexPath" methods are required.

// this method overrides the changes you have made to inc or dec the size of cell using storyboard.
- (CGSize)collectionView:(UICollectionView *)collectionView layout:   (UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int width = (self.contentView.frame.size.width / 3) -10;
    return CGSizeMake(width, width);

}  // class ends



@end
