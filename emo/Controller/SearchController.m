//
//  SearchController.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/10.
//

#import <Foundation/Foundation.h>
#import "SearchController.h"
#import "AppDelegate.h"
#import "writerCell.h"
#import "ContentImageCell.h"
#import "TagCell.h"
#import "TagController.h"
#import "DetailController.h"
#import "DetailStoriesController.h"
#import "notiController.h"
#import "MoreController.h"
#import "MyProfileController.h"
#import "UserProfileController.h"
#import "User.h"

@interface SearchController ()

@end

@implementation SearchController
@synthesize btntab1, btntab2, btntab3, btnsearch1, btnsearch2, btnsearch3, txttag, txtwriter, txtcontents, viewtag, viewwriter, contentstagview, viewcontents, viewtagnosearch, viewwriternosearch, viewcontentnosearch, favcontents, listcontents, listtag, listwriter, tagview, favtag;

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
    
    
    self.writepage = 1;
    self.contentpage = 1;
    self.tagpage = 1;
    self.writenext = @"Y";
    self.contentnext = @"Y";
    self.tagnext = @"Y";
    self.favcontentstaglist = [[NSMutableArray alloc] init];
    self.favtaglist = [[NSMutableArray alloc] init];
    
    NSDictionary *dict = [ApiHandler usersearch:@"" page:self.writepage];
    if ([[dict objectForKey:@"message"] isEqualToString:@"Ok"]) {
        NSLog(@"%@",[dict description]);
        self.userlist = [[dict objectForKey:@"data"] objectForKey:@"data"];
        NSLog(@"%@",[self.userlist description]);
        if ([[[dict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
            self.writenext = @"N";
        }
        [self.listwriter reloadData];
        if ([self.userlist count] > 0) {
            self.viewwriternosearch.hidden = true;
            self.listwriter.hidden = false;
        } else {
            self.viewwriternosearch.hidden = false;
            self.listwriter.hidden = true;
        }
    }
    [super viewDidLoad];
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

- (IBAction)btntab1Press:(id)sender {
    btntab1.selected = true;
    btntab2.selected = false;
    btntab3.selected = false;
    viewwriter.hidden = !btntab1.selected;
    viewcontents.hidden = !btntab2.selected;
    viewtag.hidden = !btntab3.selected;
}

- (IBAction)btntab2Press:(id)sender {
    btntab1.selected = false;
    btntab2.selected = true;
    btntab3.selected = false;
    viewwriter.hidden = !btntab1.selected;
    viewcontents.hidden = !btntab2.selected;
    viewtag.hidden = !btntab3.selected;
    if ([self.favcontentstaglist count] == 0) {
        NSDictionary *dict = [ApiHandler keyworseach];
        if ([[dict objectForKey:@"message"] isEqualToString:@"Ok"]) {
            NSLog(@"%@",[dict description]);
            NSDictionary *dt = [dict objectForKey:@"data"];
            [self.favcontentstaglist addObject:[dt objectForKey:@"contents1"]];
            [self.favcontentstaglist addObject:[dt objectForKey:@"contents2"]];
            [self.favcontentstaglist addObject:[dt objectForKey:@"contents3"]];
            [self.favcontentstaglist addObject:[dt objectForKey:@"contents4"]];
            [self.favcontentstaglist addObject:[dt objectForKey:@"contents5"]];
            [self.favcontentstaglist addObject:[dt objectForKey:@"contents6"]];
            self.tagCView = [[TagViewController alloc] init];
            self.tagCView.tagsArray = self.favcontentstaglist;
            self.tagCView.maxSize = CGSizeMake(self.view.frame.size.width-20
                                               , 300);
            [self.tagCView setViewBackgroundColor:[UIColor clearColor]];
            [self.tagCView setTagsWordsColor:[UIColor colorWithRed:(74.0/255.0f) green:(71.0f/255.0f) blue:(177.0f/255.0f) alpha:1]];
            [self.tagCView setTagsBackgroundColorArray:@[ [UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor] ].mutableCopy];
            [self.tagCView setTagsBackgroundColor:[UIColor whiteColor]];
            [self.tagCView setTagsBorderColor:[UIColor colorWithRed:(74.0/255.0f) green:(71.0f/255.0f) blue:(177.0f/255.0f) alpha:1]];
            [self.tagCView setTagsBorderCornerRadius:20];
            [self.tagCView setTagsHeight:40];
            [self.tagCView setFontSize:16];
            
            [self.tagCView setTagsMarginLeftAndRightForSubView:10];
            [self.tagCView setTagsMarginTopAndBottomForSubView:20];
            [self.tagCView setTagsAlignment:TagsAlignmentCenter];
            [self.contentstagview addSubview:self.tagCView.view];
            [self.tagCView setClickRowBlock:^(NSInteger clickTagsTag) {
                NSString *skey = [_favcontentstaglist objectAtIndex:clickTagsTag];
                NSLog(@"%@",skey);
                self.txtcontents.text = skey;
                NSDictionary *dict = [ApiHandler contentSearch:skey];
                self.contentlist = [[dict objectForKey:@"data"] objectForKey:@"data"];
                if ([self.contentlist count] > 0) {
                    self.viewcontentnosearch.hidden = true;
                    self.favcontents.hidden = true;
                    self.listcontents.hidden = false;
                } else {
                    self.viewcontentnosearch.hidden = false;
                    self.favcontents.hidden = true;
                    self.listcontents.hidden = true;
                }
                [self.listcontents reloadData];
                
            }];
        }
    }
}

- (IBAction)btntab3Press:(id)sener {
    btntab1.selected = false;
    btntab2.selected = false;
    btntab3.selected = true;
    viewwriter.hidden = !btntab1.selected;
    viewcontents.hidden = !btntab2.selected;
    viewtag.hidden = !btntab3.selected;
    if ([self.favtaglist count] == 0) {
        NSDictionary *dict = [ApiHandler tagslist];
        if ([[dict objectForKey:@"message"] isEqualToString:@"Ok"]) {
            NSLog(@"%@",[dict description]);
            NSArray *arr = [dict objectForKey:@"data"] ;
            for (int i = 0 ; i < [arr count] ; i++) {
                NSDictionary *dt = [arr objectAtIndex:i];
                if (![[dt objectForKey:@"contents1"] isEqual:[NSNull null]]){
                    [self.favtaglist addObject:[NSString stringWithFormat:@"#%@",[dt objectForKey:@"contents1"]]];
                }
                if (![[dt objectForKey:@"contents2"] isEqual:[NSNull null]]){
                    [self.favtaglist addObject:[NSString stringWithFormat:@"#%@",[dt objectForKey:@"contents2"]]];
                }
                if (![[dt objectForKey:@"contents3"] isEqual:[NSNull null]]){
                    [self.favtaglist addObject:[NSString stringWithFormat:@"#%@",[dt objectForKey:@"contents3"]]];
                }
                if (![[dt objectForKey:@"contents4"] isEqual:[NSNull null]]){
                    [self.favtaglist addObject:[NSString stringWithFormat:@"#%@",[dt objectForKey:@"contents4"]]];
                }
                if (![[dt objectForKey:@"contents5"] isEqual:[NSNull null]]){
                    [self.favtaglist addObject:[NSString stringWithFormat:@"#%@",[dt objectForKey:@"contents5"]]];
                }
                if (![[dt objectForKey:@"contents6"] isEqual:[NSNull null]]){
                    [self.favtaglist addObject:[NSString stringWithFormat:@"#%@",[dt objectForKey:@"contents6"]]];
                }
                
            }
           
            self.tagCView1 = [[TagViewController alloc] init];
            self.tagCView1.tagsArray = self.favtaglist;
            self.tagCView1.maxSize = CGSizeMake(self.view.frame.size.width-20, 300);
            [self.tagCView1 setViewBackgroundColor:[UIColor clearColor]];
            [self.tagCView1 setTagsWordsColor:[UIColor colorWithRed:(74.0/255.0f) green:(71.0f/255.0f) blue:(177.0f/255.0f) alpha:1]];
            [self.tagCView1 setTagsBackgroundColorArray:@[ [UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor] ].mutableCopy];
            [self.tagCView1 setTagsBackgroundColor:[UIColor whiteColor]];
            [self.tagCView1 setTagsBorderColor:[UIColor colorWithRed:(74.0/255.0f) green:(71.0f/255.0f) blue:(177.0f/255.0f) alpha:1]];
            [self.tagCView1 setTagsBorderCornerRadius:20];
            [self.tagCView1 setTagsHeight:40];
            [self.tagCView1 setFontSize:16];
            
            [self.tagCView1 setTagsMarginLeftAndRightForSubView:10];
            [self.tagCView1 setTagsMarginTopAndBottomForSubView:20];
            [self.tagCView1 setTagsAlignment:TagsAlignmentCenter];
            [self.tagview addSubview:self.tagCView1.view];
            [self.tagCView1 setClickRowBlock:^(NSInteger clickTagsTag) {
                NSString *skey = [_favtaglist objectAtIndex:clickTagsTag];
                skey = [skey stringByReplacingOccurrencesOfString:@"#" withString:@""];
                NSLog(@"%@",skey);
                self.txttag.text = skey;
                NSDictionary *dict = [ApiHandler tagSearch:skey page:1];
                self.taglist = [[dict objectForKey:@"data"] objectForKey:@"data"];
                [self.listtag reloadData];
                if ([self.taglist count] > 0) {
                    self.viewtagnosearch.hidden = true;
                    self.favtag.hidden = true;
                    self.listtag.hidden = false;
                } else {
                    self.viewtagnosearch.hidden = false;
                    self.favtag.hidden = true;
                    self.listtag.hidden = true;
                }
            }];
        }
    }
}

- (void)loadtag {
    
}

- (IBAction)btnsearch1Press:(id)sender {
    if ([self.txtwriter.text isEqualToString:@""]) {
        [FSToast showToast:self messge:@"검색어를 입력하십시요."];
        return;
    } else {
        NSDictionary *dict = [ApiHandler usersearch:self.txtwriter.text page:1];
        [self.txtwriter resignFirstResponder];
        self.userlist = [[dict objectForKey:@"data"] objectForKey:@"data"];
        self.writepage = 1;
        if ([[[dict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
            self.writenext = @"N";
        }
        [self.listwriter reloadData];
        if ([self.userlist count] > 0) {
            self.viewwriternosearch.hidden = true;
            self.listwriter.hidden = false;
        } else {
            self.viewwriternosearch.hidden = false;
            self.listwriter.hidden = true;
        }
    }
}

- (IBAction)btnsearch2Press:(id)sender {
    if ([self.txtcontents.text isEqualToString:@""]) {
        self.viewcontentnosearch.hidden = true;
        self.favcontents.hidden = false;
        self.listcontents.hidden = true;
        [self.txtcontents resignFirstResponder];
        return;
    } else {
        NSDictionary *dict = [ApiHandler contentSearch:self.txtcontents.text];
        [self.txtcontents resignFirstResponder];
        self.contentlist = [[dict objectForKey:@"data"] objectForKey:@"data"];
        self.contentpage = 1;
        if ([[[dict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
            self.contentnext = @"N";
        }
        if ([self.contentlist count] > 0) {
            self.viewcontentnosearch.hidden = true;
            self.favcontents.hidden = true;
            self.listcontents.hidden = false;
        } else {
            self.viewcontentnosearch.hidden = false;
            self.favcontents.hidden = true;
            self.listcontents.hidden = true;
        }
        [self.listcontents reloadData];
      /*  [self.listwriter reloadData];
        if ([self.userlist count] > 0) {
            self.viewwriternosearch.hidden = true;
            self.listwriter.hidden = false;
        } else {
            self.viewwriternosearch.hidden = false;
            self.listwriter.hidden = true;
        }*/
    }
}

- (IBAction)btnsearch3Press:(id)sender {
    if ([self.txttag.text isEqualToString:@""]) {
        self.viewtagnosearch.hidden = true;
        self.favtag.hidden = false;
        self.listtag.hidden = true;
        [self.txttag resignFirstResponder];
    } else {
        NSDictionary *dict = [ApiHandler tagSearch:self.txttag.text page:1];
        [self.txttag resignFirstResponder];
        self.taglist = [[dict objectForKey:@"data"] objectForKey:@"data"];
        NSLog(@"%@",[self.taglist description]);
        self.tagpage = 1;
        if ([[[dict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
            self.tagnext = @"N";
        }
        [self.listtag reloadData];
        if ([self.taglist count] > 0) {
            self.viewtagnosearch.hidden = true;
            self.favtag.hidden = true;
            self.listtag.hidden = false;
        } else {
            self.viewtagnosearch.hidden = false;
            self.favtag.hidden = true;
            self.listtag.hidden = true;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
  //This line dismisses the keyboard.
  [theTextField resignFirstResponder];
    if([theTextField isEqual:self.txtwriter]) {
        [self btnsearch1Press:self];
    } else if ([theTextField isEqual:self.txtcontents]) {
        [self btnsearch2Press:self];
    } else if ([theTextField isEqual:self.txttag]) {
        [self btnsearch3Press:self];
    }
  //Your view manipulation here if you moved the view up due to the keyboard etc.
  return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.listwriter]) {
        return [self.userlist count];
    } else if ([tableView isEqual:self.listtag]) {
        return [self.taglist count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate  *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([tableView isEqual:self.listwriter]) {
        NSDictionary *dt1 = [self.userlist objectAtIndex:[indexPath row]];
    
        NSString *simpleTableIdentifier = @"writerCell";
        
        writerCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"writerCell-%ld",(long)[indexPath row]]];
      
      //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"writerCell" owner:self options:nil];
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
        cell.lblfollow.text = [NSString stringWithFormat:@"팔로우 %@명",[dt1 objectForKey:@"follows_count"]];
        [cell.lblfollow sizeToFit];
        if (![[dt1 objectForKey:@"profile_image_url"] isEqual:[NSNull null]]) {
            cell.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dt1 objectForKey:@"profile_image_url"]]]];
            cell.imgprofile.layer.cornerRadius = cell.imgprofile.frame.size.height / 2;
            cell.imgprofile.clipsToBounds = true;
        }
        
        if ([[[dt1 objectForKey:@"is_follow"] stringValue] isEqualToString:@"0"]) {
            cell.btnfollow.hidden = false;
            cell.btnfollowing.hidden = true;
        } else {
            cell.btnfollow.hidden = true;
            cell.btnfollowing.hidden = false;
        }
        cell.btnfollow.tag = 1000 + [indexPath row];
        cell.btnfollowing.tag = 2000 + [indexPath row];
        [cell.btnfollow addTarget:self action:@selector(btnfollowPress:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnfollowing addTarget:self action:@selector(btnfollowingPress:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else if ([tableView isEqual:self.listtag]) {
        NSDictionary *dt1 = [self.taglist objectAtIndex:[indexPath row]];
    
        NSString *simpleTableIdentifier = @"TagCell";
        
        TagCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"TagCell-%ld",(long)[indexPath row]]];
      
      //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"TagCell" owner:self options:nil];
            cell = arr[0];
            
        }
       
        NSString *str = [NSString stringWithFormat:@"#%@",[dt1 objectForKey:@"tag"]];
        //테스트용 문자열
   
        NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:str];
   
        NSRange range = [str rangeOfString:self.txttag.text];
   
        [att addAttribute:NSForegroundColorAttributeName value:[[UIColor colorWithRed:(74.0/255.0f) green:(71.0f/255.0f) blue:(177.0f/255.0f) alpha:1] colorWithAlphaComponent:1.0f] range:range];
         
         [cell.lbltag setAttributedText:att];

   
   
        
        return cell;
    }
    return nil;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.listwriter]) {
    
        return 130;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.listwriter]) {
        NSDictionary *dt = [self.userlist objectAtIndex:[indexPath row]];
        User *user = [User sharedInstance];
        if ([[dt objectForKey:@"user_idx"] intValue] == user.idx) {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                   bundle:nil];
           
            MyProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"MyProfileController"];
            
            [self.parentViewController.navigationController pushViewController:dc animated:YES];
        
        } else {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                      bundle:nil];
              
            UserProfileController *dc = [storyboard instantiateViewControllerWithIdentifier:@"UserProfileController"];
            dc.useridx = [[dt objectForKey:@"user_idx"] intValue];
           [self.parentViewController.navigationController pushViewController:dc animated:YES];
       }
    } else if ([tableView isEqual:self.listtag]) {
        NSDictionary *dt = [self.taglist objectAtIndex:[indexPath row]];
        NSString *stag = [dt objectForKey:@"tag"];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        TagController *tc = [storyboard instantiateViewControllerWithIdentifier:@"TagController"];
        tc.stag = stag;
        [self.navigationController pushViewController:tc animated:YES];
    }

}


// collection view delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.contentlist count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ContentImageCell *cell = (ContentImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ContentImageCell" forIndexPath:indexPath];

    // configuring cell
    // cell.customLabel.text = [yourArray objectAtIndex:indexPath.row]; // comment this line if you do not want add label from storyboard

    // if you need to add label and other ui component programmatically
    NSDictionary *dt = [self.contentlist objectAtIndex:[indexPath row]];
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
    int width = (self.listcontents.frame.size.width / 3) -10;
    return CGSizeMake(width, width);

}  // class ends

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSDictionary *dt = [self.contentlist objectAtIndex:indexPath.row];
    NSLog(@"%@", [dt description]);
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    if ([[dt objectForKey:@"type_code"]  isEqualToString:@"1000"]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dt];
        DetailStoriesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"DetailStoriesController"];
        dc.datadict = dic;
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dt];
        DetailController *dc = [storyboard instantiateViewControllerWithIdentifier:@"DetailController"];
        dc.datadict = dic;
        [self.navigationController pushViewController:dc animated:YES];
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
    if ([scrollView_ isEqual:self.listwriter]) {
        if(self.listwriter.contentOffset.y >= (self.listwriter.contentSize.height - self.listwriter.bounds.size.height))
        {
            if ([self.writenext isEqualToString:@"Y"]) {
                self.writepage = self.writepage + 1;
                NSDictionary *dict = [ApiHandler usersearch:self.txtwriter.text page:self.writepage];
                NSArray *arr = [[dict objectForKey:@"data"] objectForKey:@"data"];
                NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.userlist];
                [array addObjectsFromArray:arr];
                self.userlist = array;
                NSLog(@"%@",[self.userlist description]);
                if ([[[dict objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
                    self.writenext = @"N";
                }
                [self.listwriter reloadData];
            }
        }
    }
}

- (IBAction)btnfollowPress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    int idx = btn.tag - 1000;
    NSDictionary *dt1 = [self.userlist objectAtIndex:idx];
    NSDictionary *resultDict = [ApiHandler follow:[dt1 objectForKey:@"idx"] type:@"follow"];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        writerCell *cell = (writerCell *)btn.superview.superview;
        UIButton *btn1 = [cell viewWithTag:idx + 2000];
        btn.hidden = YES;
        btn1.hidden = NO;
    } else {
        [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
    }
}

- (IBAction)btnfollowingPress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    int idx = btn.tag - 2000;
    NSDictionary *dt1 = [self.userlist objectAtIndex:idx];
    NSDictionary *resultDict = [ApiHandler follow:[dt1 objectForKey:@"idx"] type:@"following"];
    if ([[[resultDict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        writerCell *cell = (writerCell *)btn.superview.superview;
        UIButton *btn1 = [cell viewWithTag:idx + 1000];
        btn.hidden = YES;
        btn1.hidden = NO;
    } else {
        [FSToast showToast:self messge:[resultDict objectForKey:@"message"]];
    }
}

@end
