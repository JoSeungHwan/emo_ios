//
//  TagController.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/11.
//

#import <Foundation/Foundation.h>
#import "TagController.h"
#import "TagCell.h"
#import "ContentImageCell.h"
#import "notiController.h"
#import "DetailController.h"
#import "DetailStoriesController.h"

@interface TagController ()

@end

@implementation TagController
@synthesize listView, contentView, stag, btntab1, btntab2, contentslist, storieslist;

- (void)viewDidLoad {
 
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = [NSString stringWithFormat:@"#%@", self.stag];
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
    
    
    NSDictionary *dict = [ApiHandler tagcontentssearch:self.stag];
    self.contentslist = [[dict objectForKey:@"data"] objectForKey:@"data"];
    NSLog(@"%@",[self.contentslist description]);
   
    [self.contentView reloadData];
    
    NSDictionary *dict1 = [ApiHandler tagstoriessearch:self.stag page:1];
    self.storieslist = [[dict1 objectForKey:@"data"] objectForKey:@"data"];
    NSLog(@"%@",[self.storieslist description]);
    self.tagpage = 1;
    if ([[[dict1 objectForKey:@"data"] objectForKey:@"next_page_url"] isEqual:[NSNull null]]) {
        self.tagnext = @"N";
    }
    [self.listView reloadData];
    
    [super viewDidLoad];
}


- (IBAction)notiPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
   
    notiController *dc = [storyboard instantiateViewControllerWithIdentifier:@"notiController"];
    
    [self.parentViewController.navigationController pushViewController:dc animated:YES];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
}

- (IBAction)btntab1Press:(id)sender {
    self.btntab1.selected = true;
    self.btntab2.selected = false;
    
    self.contentView.hidden = !self.btntab1.selected;
    self.listView.hidden = !self.btntab2.selected;
}

- (IBAction)btntab2Press:(id)sender {
    self.btntab1.selected = false;
    self.btntab2.selected = true;
    
    self.contentView.hidden = !self.btntab1.selected;
    self.listView.hidden = !self.btntab2.selected;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [self.storieslist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dt1 = [self.storieslist objectAtIndex:[indexPath row]];

      
    TagCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"TagCell-%ld",(long)[indexPath row]]];
  
  //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"TagCell" owner:self options:nil];
        cell = arr[0];
        
    }
   
    NSString *str = [dt1 objectForKey:@"contents"];
    //테스트용 문자열

    NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:str];

    NSRange range = [str rangeOfString:self.stag];

    [att addAttribute:NSForegroundColorAttributeName value:[[UIColor colorWithRed:(74.0/255.0f) green:(71.0f/255.0f) blue:(177.0f/255.0f) alpha:1] colorWithAlphaComponent:1.0f] range:range];
     
     [cell.lbltag setAttributedText:att];
    cell.lbltag.numberOfLines = 2;

    [cell.lbltag sizeToFit];
    
    return cell;
      

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

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
                NSDictionary *dict = [ApiHandler tagstoriessearch:self.stag page:self.tagpage];
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
