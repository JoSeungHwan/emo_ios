//
//  MySaveController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "MySaveController.h"
#import "notiController.h"
#import "DetailController.h"
#import "DetailStoriesController.h"
#import "User.h"
#import "ContentImageCell.h"
#import "storiesCell.h"

@interface MySaveController ()

@end

@implementation MySaveController
@synthesize btntab1, btntab2, contentView, contentslist, listView, storieslist;

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"내 보관함";
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

- (IBAction)notiPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    notiController *dc = [storyboard instantiateViewControllerWithIdentifier:@"notiController"];
    
    [self.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btntab1Press:(id)sender {
    self.btntab1.selected = true;
    self.btntab2.selected = false;
    self.contentView.hidden = NO;
    self.listView.hidden = YES;
}

- (IBAction)btntab2Press:(id)sender {
    self.btntab2.selected = true;
    self.btntab1.selected = false;
    self.listView.hidden = NO;
    self.contentView.hidden = YES;
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {

    NSDictionary *dict = [ApiHandler profilebookmark:@"contents"];
    self.contentslist = [[dict objectForKey:@"data"] objectForKey:@"data"];
    NSLog(@"%@",[self.contentslist description]);
   
    [self.contentView reloadData];
    
    NSDictionary *dict1 = [ApiHandler profilebookmark:@"stories"];
    self.storieslist = [[dict1 objectForKey:@"data"] objectForKey:@"data"];
    NSLog(@"%@",[self.storieslist description]);
    
   
    [self.listView reloadData];
    [super viewWillAppear:animated];
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




@end
