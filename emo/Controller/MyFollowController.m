//
//  MyFollowController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "MyFollowController.h"
#import "notiController.h"
#import "FollowCell.h"
#import "MyProfileController.h"
#import "UserProfileController.h"
#import "User.h"

@interface MyFollowController ()

@end

@implementation MyFollowController
@synthesize btnfollow, btnfollowing, listView, stype, followlist, followinglist, useridx,txtsearch, btnsearch;

- (void)viewDidLoad {
    self.writenext = @"N";
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"팔로우,팔로윙";
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
    
    if ([self.stype isEqualToString:@"follow"]) {
        self.btnfollow.selected = true;
        self.btnfollowing.selected = false;
    } else {
        self.btnfollow.selected = false;
        self.btnfollowing.selected = true;
    }
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    NSDictionary *resultDict = [ApiHandler searchfollow:1 useridx:self.useridx type:@"follower" search:@""];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        self.followlist = [[NSMutableArray alloc] initWithArray:[[resultDict objectForKey:@"data"] objectForKey:@"data"]];
        if ([[[resultDict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
            self.writenext = @"N";
        } else {
            self.writenext = @"Y";
        }
    }
    NSDictionary *resultDict1 = [ApiHandler searchfollow:1 useridx:self.useridx type:@"following" search:@""];
    if ([[[resultDict1 objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        self.followinglist = [[NSMutableArray alloc] initWithArray:[[resultDict1 objectForKey:@"data"] objectForKey:@"data"]];
    }
    [super viewWillAppear:animated];
}

- (IBAction)btnsearchPress:(id)sender {
    [self.txtsearch resignFirstResponder];
    if (self.btnfollow.isSelected) {
        self.page = 1;
        NSDictionary *resultDict = [ApiHandler searchfollow:1 useridx:self.useridx type:@"follower" search:self.txtsearch.text];
        if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            self.followlist = [[NSMutableArray alloc] initWithArray:[[resultDict objectForKey:@"data"] objectForKey:@"data"]];
            if ([[[resultDict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
                self.writenext = @"N";
            } else {
                self.writenext = @"Y";
            }
        }
        [self.listView reloadData];
    } else {
        NSDictionary *resultDict1 = [ApiHandler searchfollow:1 useridx:self.useridx type:@"following" search:self.txtsearch.text];
        if ([[[resultDict1 objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            self.followinglist = [[NSMutableArray alloc] initWithArray:[[resultDict1 objectForKey:@"data"] objectForKey:@"data"]];
            if ([[[resultDict1 objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
                self.writenext = @"N";
            } else {
                self.writenext = @"Y";
            }
        }
        [self.listView reloadData];
    }
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

- (IBAction)btnfollowPress:(id)sender {
    self.btnfollow.selected = true;
    self.btnfollowing.selected = false;
    self.page = 1;
    NSDictionary *resultDict = [ApiHandler searchfollow:1 useridx:self.useridx type:@"follower" search:self.txtsearch.text];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        self.followlist = [[NSMutableArray alloc] initWithArray:[[resultDict objectForKey:@"data"] objectForKey:@"data"]];
        if ([[[resultDict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
            self.writenext = @"N";
        } else {
            self.writenext = @"Y";
        }
    }
    [self.listView reloadData];
}

- (IBAction)btnfollwingPress:(id)sender {
    self.btnfollow.selected = false;
    self.btnfollowing.selected = true;
    self.page = 1;
    NSDictionary *resultDict1 = [ApiHandler searchfollow:1 useridx:self.useridx type:@"following" search:self.txtsearch.text];
    if ([[[resultDict1 objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        self.followinglist = [[NSMutableArray alloc] initWithArray:[[resultDict1 objectForKey:@"data"] objectForKey:@"data"]];
        if ([[[resultDict1 objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
            self.writenext = @"N";
        } else {
            self.writenext = @"Y";
        }
    }
    [self.listView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ( self.btnfollow.selected) {
        return [self.followlist count];
    } else {
        return [self.followinglist count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dt1 = nil;
    if ( self.btnfollow.selected) {
        dt1 = [self.followlist objectAtIndex:[indexPath row]];
    } else {
        dt1 = [self.followinglist objectAtIndex:[indexPath row]];
    }
    NSString *simpleTableIdentifier = @"FollowCell";
    
    FollowCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"FollowCell-%ld",(long)[indexPath row]]];
  
  //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"FollowCell" owner:self options:nil];
        cell = arr[0];
        
    }
   
    if ([[[dt1 objectForKey:@"level"] stringValue] isEqualToString:@"1"]) {
        cell.lbllevel.text = @"Lv.1 서포터";
    } else if ([[[dt1 objectForKey:@"level"] stringValue] isEqualToString:@"2"]) {
        cell.lbllevel.text = @"Lv.2 연습생";
    } else if ([[[dt1 objectForKey:@"level"] stringValue] isEqualToString:@"3"]) {
        cell.lbllevel.text = @"Lv.3 데뷔";
    } else if ([[[dt1 objectForKey:@"level"] stringValue] isEqualToString:@"4"]) {
        cell.lbllevel.text = @"Lv.4 신인";
    } else if ([[[dt1 objectForKey:@"level"] stringValue] isEqualToString:@"5"]) {
        cell.lbllevel.text = @"Lv.5 프로";
    } else if ([[[dt1 objectForKey:@"level"] stringValue] isEqualToString:@"6"]) {
        cell.lbllevel.text = @"Lv.6 스타";
    } else {
        cell.lbllevel.text = @"Lv.0 Guest";
    }
    [cell.lbllevel sizeToFit];
    CGRect frame = cell.viewlevel.frame;
    frame.size.width = cell.lbllevel.frame.size.width + 10;
    cell.viewlevel.frame = frame;
    
    cell.viewlevel.layer.cornerRadius = 5;
    cell.lblnickname.text = [dt1 objectForKey:@"nickname"];
    [cell.lblnickname sizeToFit];
   
    if (![[dt1 objectForKey:@"profile_image_url"] isEqual:[NSNull null]]) {
        cell.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dt1 objectForKey:@"profile_image_url"]]]];
        cell.imgprofile.layer.cornerRadius = cell.imgprofile.frame.size.height / 2;
        cell.imgprofile.clipsToBounds = true;
    }
    
    if ([[[dt1 objectForKey:@"is_following"] stringValue] isEqualToString:@"0"]) {
        cell.btnfollow.hidden = false;
        cell.btnfollowing.hidden = true;
    } else {
        cell.btnfollow.hidden = true;
        cell.btnfollowing.hidden = false;
    }
    cell.btnfollow.tag = 1000 + [indexPath row];
    cell.btnfollowing.tag = 2000 + [indexPath row];
    [cell.btnfollow addTarget:self action:@selector(btnfollowrequestPress:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnfollowing addTarget:self action:@selector(btnfollowingrequestPress:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 130;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.btnfollow.isSelected) {
        NSDictionary *dt = [self.followlist objectAtIndex:[indexPath row]];
        User *user = [User sharedInstance];
        if ([[dt objectForKey:@"idx"] intValue] == user.idx) {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                   bundle:nil];
           
            MyProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyProfileController"];
            
            [self.navigationController pushViewController:dc animated:YES];
        
        } else {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                      bundle:nil];
              
            UserProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"UserProfileController"];
            dc.useridx = [[dt objectForKey:@"idx"] intValue];
           [self.navigationController pushViewController:dc animated:YES];
       }
    
    } else {
        NSDictionary *dt = [self.followinglist objectAtIndex:[indexPath row]];
        User *user = [User sharedInstance];
        if ([[dt objectForKey:@"idx"] intValue] == user.idx) {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                   bundle:nil];
           
            MyProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyProfileController"];
            
            [self.navigationController pushViewController:dc animated:YES];
        
        } else {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                      bundle:nil];
              
            UserProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"UserProfileController"];
            dc.useridx = [[dt objectForKey:@"idx"] intValue];
           [self.navigationController pushViewController:dc animated:YES];
       }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
    
    if(self.listView.contentOffset.y >= (self.listView.contentSize.height - self.listView.bounds.size.height) && [self.writenext isEqualToString:@"Y"])
    {
        self.page = self.page + 1;
        if (self.btnfollow.selected) {
            
            NSDictionary *resultDict = [ApiHandler searchfollow:self.page useridx:self.useridx type:@"follower" search:self.txtsearch.text];
            if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
             
                [self.followlist addObjectsFromArray:[[resultDict objectForKey:@"data"] objectForKey:@"data"]];
                if ([[[resultDict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
                    self.writenext = @"N";
                } else {
                    self.writenext = @"Y";
                }
            }
          
            [self.listView reloadData];
        } else {
            NSDictionary *resultDict1 = [ApiHandler searchfollow:self.page useridx:self.useridx type:@"following" search:self.txtsearch.text];
            if ([[[resultDict1 objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
                [self.followinglist addObjectsFromArray:[[resultDict1 objectForKey:@"data"] objectForKey:@"data"]];
                if ([[[resultDict1 objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
                    self.writenext = @"N";
                } else {
                    self.writenext = @"Y";
                }
                
            }
            [self.listView reloadData];
        }
    }
    
}

- (IBAction)btnfollowrequestPress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    int idx = btn.tag - 1000;
    NSDictionary *dt1 = [self.followlist objectAtIndex:idx];
    NSDictionary *resultDict = [ApiHandler follow:[dt1 objectForKey:@"idx"] type:@"follow"];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        FollowCell *cell = (FollowCell *)btn.superview.superview;
        UIButton *btn1 = [cell viewWithTag:idx + 2000];
        btn.hidden = YES;
        btn1.hidden = NO;
    } else {
        [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
    }
}

- (IBAction)btnfollowingrequestPress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    int idx = btn.tag - 2000;
    NSDictionary *dt1 = [self.followinglist objectAtIndex:idx];
    NSDictionary *resultDict = [ApiHandler follow:[dt1 objectForKey:@"idx"] type:@"following"];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        FollowCell *cell = (FollowCell *)btn.superview.superview;
        UIButton *btn1 = [cell viewWithTag:idx + 1000];
        btn.hidden = YES;
        btn1.hidden = NO;
    } else {
        [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
    }
}

@end
