//
//  RepliesController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "RepliesController.h"
#import "notiController.h"
#import "storiesCell.h"
#import "User.h"
#import "DetailStoriesController.h"
#import "DetailController.h"

@interface RepliesController ()

@end

@implementation RepliesController
@synthesize listView, listArray;

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"작성 댓글";
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
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {

    User *user = [User sharedInstance];
    NSDictionary *dict = [ApiHandler searchcommentlist:self.useridx page:1];
    self.listArray = [[dict objectForKey:@"data"] objectForKey:@"data"];
    NSLog(@"%@",[self.listArray description]);
   
   
    [self.listView reloadData];
    [super viewWillAppear:animated];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];

      
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
    
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];
    NSLog(@"%@",[dt1 objectForKey:@"content_idx"]);
    if ([dt1 objectForKey:@"content_idx"] != nil ) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dt1];
        [dic setValue:[dt1 objectForKey:@"content_idx"] forKey:@"idx"];
        DetailController *dc = [storyboard instantiateViewControllerWithIdentifier:@"DetailController"];
        dc.datadict = dic;
        [self.navigationController pushViewController:dc animated:YES];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dt1];
        [dic setValue:[dt1 objectForKey:@"story_idx"] forKey:@"idx"];
        DetailStoriesController *dc = [storyboard instantiateViewControllerWithIdentifier:@"DetailStoriesController"];
        dc.datadict = dic;
        [self.navigationController pushViewController:dc animated:YES];
    }
   
    
}

@end
