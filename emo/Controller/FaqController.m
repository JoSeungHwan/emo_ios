//
//  FaqController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "FaqController.h"
#import "faqCell.h"

@interface FaqController () <HVTableViewDataSource, HVTableViewDelegate, faqCellDelegate> {
   
}

@end

@implementation FaqController
@synthesize listView, listArray;

-(void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"FAQ";
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

- (void)faqCelllDidTapPurchaseButton:(faqCell *)cell {
    
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSDictionary *resultdict = [ApiHandler faqlist:1];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dict = [resultdict objectForKey:@"data"];
        NSArray *arr = [dict objectForKey:@"data"];
        self.listArray = [[NSMutableArray alloc] initWithArray:arr];
        [self.listView reloadData];
    }
    [super viewWillAppear:animated];
}

#pragma mark HVTableViewDatasource
-(void)tableView:(UITableView *)tableView expandCell:(faqCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    cell.lblcontent.hidden = NO;
    [UIView animateWithDuration:.5 animations:^{
        
        cell.imgallow.image = [UIImage imageNamed:@"closeicon"];
    }];
    
}

-(void)tableView:(UITableView *)tableView collapseCell:(faqCell *)cell withIndexPath:(NSIndexPath *)indexPath{
 
    cell.lblcontent.hidden = YES;
    [UIView animateWithDuration:.5 animations:^{
        cell.imgallow.image = [UIImage imageNamed:@"openicon"];
        
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.listArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded {
   
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];

  
    faqCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"faqCell-%ld",(long)[indexPath row]]];

  //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"faqCell" owner:self options:nil];
        cell = arr[0];
        
    }

    cell.lbltitle.text = [dt1 objectForKey:@"question"];
    cell.lblcontent.text = [dt1 objectForKey:@"answer"];
    cell.lblcontent.frame = CGRectMake(cell.lblcontent.frame.origin.x, cell.lblcontent.frame.origin.y, cell.lblcontent.frame.size.width, 20);
    cell.lblcontent.numberOfLines = 0;
    cell.lblcontent.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.lblcontent sizeToFit];
    cell.contview.layer.cornerRadius = 10;
    cell.contview.layer.borderColor = [[UIColor colorWithRed:(220.0/255.0f) green:(220.0/255.0f) blue:(220.0/255.0f) alpha:1] CGColor];
    cell.contview.layer.borderWidth = 1;
    if (!isExpanded) {
        cell.imgallow.image = [UIImage imageNamed:@"openicon"];
  
        cell.lblcontent.hidden = YES;
    } else {
        cell.imgallow.image = [UIImage imageNamed:@"closeicon"];
      
        cell.lblcontent.hidden = NO;
    }
    
    return cell;
          

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded {
    if (isexpanded) {
        NSDictionary *dt = [self.listArray objectAtIndex:[indexPath row]];
        NSString *str = [dt objectForKey:@"answer"];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
        lbl.font = [UIFont systemFontOfSize:11];
        lbl.numberOfLines = 0;
        lbl.text = str;
        [lbl sizeToFit];
        
        return lbl.frame.size.height + 120;
    }
    return 80;
}

- (IBAction)btnselectPress:(id)sender {
    
}

@end
