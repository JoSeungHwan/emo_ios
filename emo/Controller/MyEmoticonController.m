//
//  MyEmoticonController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/10.
//

#import <Foundation/Foundation.h>
#import "MyEmoticonController.h"
#import "MyEmoticonCell.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImagePhotosPlugin/SDWebImagePhotosPlugin.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "EmoticonDetailController.h"
#import "User.h"

@interface MyEmoticonController ()

@end

@implementation MyEmoticonController
@synthesize btnsearch,  listView, listArray, txtsearch, pc;

- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    if ([self.stype isEqualToString:@"order"]){
        lbltitle.text = @"내가 구매한 이모티콘";
    } else {
        lbltitle.text = @"내가 만든 이모티콘";
    }
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
    
 
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([self.stype isEqualToString:@"order"]) {
        NSDictionary *resultdict = [ApiHandler orderEmoticonsList:1 order:@"" search:self.txtsearch.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            NSDictionary *dt = [resultdict objectForKey:@"data"];
            self.listArray = [[NSMutableArray alloc] initWithArray:[dt objectForKey:@"data"]];
            [self.listView reloadData];
        }
    } else {
        NSDictionary *resultdict = [ApiHandler myemoticonlist:1 search:self.txtsearch.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            NSDictionary *dt = [resultdict objectForKey:@"data"];
            self.listArray = [[NSMutableArray alloc] initWithArray:[dt objectForKey:@"data"]];
            [self.listView reloadData];
        }
    }
   
    [super viewWillAppear:animated];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

- (IBAction)btnmorePress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    int idx = btn.tag - 1000;
    NSDictionary *dt = [self.listArray objectAtIndex:idx];
    
}


- (IBAction)btnsearchPress:(id)sender {
    if ([self.stype isEqualToString:@"order"]) {
        NSDictionary *resultdict = [ApiHandler orderEmoticonsList:1 order:@"" search:self.txtsearch.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            NSDictionary *dt = [resultdict objectForKey:@"data"];
            self.listArray = [[NSMutableArray alloc] initWithArray:[dt objectForKey:@"data"]];
            [self.listView reloadData];
        }
    } else {
        NSDictionary *resultdict = [ApiHandler myemoticonlist:1 search:self.txtsearch.text];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            NSDictionary *dt = [resultdict objectForKey:@"data"];
            self.listArray = [[NSMutableArray alloc] initWithArray:[dt objectForKey:@"data"]];
            [self.listView reloadData];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];
    
    MyEmoticonCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"MyEmoticonCell-%ld",(long)[indexPath row]]];
  
  //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"MyEmoticonCell" owner:self options:nil];
        cell = arr[0];
        
    }
    NSLog(@"%@",[dt1 description]);
    cell.lblname.text = [dt1 objectForKey:@"emoticon_name"];
    cell.lblcont.text = [dt1 objectForKey:@"contents"];
    
    cell.lbllikecount.text = [[dt1 objectForKey:@"likes_count"] stringValue];
    if ([[[dt1 objectForKey:@"is_like"] stringValue] isEqualToString:@"1"]) {
        cell.imglike.image = [UIImage imageNamed:@"imglike"];
    } else {
        cell.imglike.image = [UIImage imageNamed:@"imgunlike"];
    }
    if ([self.stype isEqualToString:@"my"]) {
        cell.statusview.hidden = NO;
    }
    cell.btnmore.tag = 1000 + [indexPath row];
    [cell.btnmore addTarget:self action:@selector(btnmorePress:) forControlEvents:UIControlEventTouchUpInside];
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
    dc.idx = [[dt objectForKey:@"content_idx"] intValue];
    [self.navigationController pushViewController:dc animated:YES];

}

@end
