//
//  notiController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "notiController.h"
#import "notiCell.h"
#import "notidetailController.h"

@interface notiController ()

@end

@implementation notiController
@synthesize btnnoti, btnalram, listView, notilist, alramlist;

- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"알림 및 공지";
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
    
    self.notilist = [[NSMutableArray alloc] init];
    self.alramlist = [[NSMutableArray alloc] init];
    
    NSDictionary *resultdict = [ApiHandler alramlist:1];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dic = [resultdict objectForKey:@"data"];
        NSLog(@"%@",[dic description]);
        [self.alramlist addObjectsFromArray:[dic objectForKey:@"data"]];
    }
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
   
    
    [super viewWillAppear:animated];
    
}

- (IBAction)btnalramPress:(id)sender {
    self.btnalram.selected = true;
    self.btnnoti.selected = false;
    NSDictionary *resultdict = [ApiHandler alramlist:1];
    self.alramlist = [[NSMutableArray alloc] init];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dic = [resultdict objectForKey:@"data"];
        NSLog(@"%@",[dic description]);
        [self.alramlist addObjectsFromArray:[dic objectForKey:@"data"]];
    }
    [self.listView reloadData];
}

- (IBAction)btnnotiPress:(id)sender {
    self.btnalram.selected = false;
    self.btnnoti.selected = true;
    self.notilist = [[NSMutableArray alloc] init];
    NSDictionary *resultdict = [ApiHandler notilist:1];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dic = [resultdict objectForKey:@"data"];
        NSLog(@"%@",[dic description]);
        [self.notilist addObjectsFromArray:[dic objectForKey:@"data"]];
    }
    [self.listView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.btnalram.selected) {
        return [self.alramlist count];
    }
    return [self.notilist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.btnalram.selected) {
        NSDictionary *dt1 = [self.alramlist objectAtIndex:[indexPath row]];

          
        notiCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"notiCell-%ld",(long)[indexPath row]]];
      
      //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"notiCell" owner:self options:nil];
            cell = arr[0];
            
        }
        cell.lbltitle.text = [dt1 objectForKey:@"title"];
        cell.lblcontent.text = [dt1 objectForKey:@"content"];
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateformat setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ko_KR"]];
        
        NSString *sdt = [dt1 objectForKey:@"created_at"];
        NSDate *createdt = [dateformat dateFromString:sdt];
        
        cell.lbldate.text = [ApiHandler calculateDate:createdt];
        
        return cell;
    } else {
        
    
    NSDictionary *dt1 = [self.notilist objectAtIndex:[indexPath row]];

      
        notiCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"notiCell-%ld",(long)[indexPath row]]];
  
      //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"notiCell" owner:self options:nil];
            cell = arr[0];
            
        }
   
        cell.lbltitle.text = [dt1 objectForKey:@"title"];
        cell.lblcontent.text = [dt1 objectForKey:@"content"];
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateformat setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ko_KR"]];
        
        NSString *sdt = [dt1 objectForKey:@"created_at"];
        NSDate *createdt = [dateformat dateFromString:sdt];
        
        cell.lbldate.text = [ApiHandler calculateDate:createdt];
    
        return cell;
    }
      

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.btnalram.selected) {
        
    } else {
        NSDictionary *dt1 = [self.notilist objectAtIndex:[indexPath row]];
       
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
      
        notidetailController *dc = [storyboard instantiateViewControllerWithIdentifier:@"notidetailController"];
        dc.idx = [[dt1 objectForKey:@"idx"] intValue];
        [self.navigationController pushViewController:dc animated:YES];
    
    }

}

@end
