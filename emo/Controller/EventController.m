//
//  EventController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "EventController.h"
#import "EventCell.h"

@interface EventController ()

@end

@implementation EventController
@synthesize listView, listArray, lblno;

- (void)viewDidLoad {

    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"이벤트";
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

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSDictionary *resultdict = [ApiHandler eventlist:@""];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dt = [resultdict objectForKey:@"data"];
        NSArray *arr = [dt objectForKey:@"data"];
        if ([arr count] == 0) {
            self.listView.hidden = YES;
            self.lblno.hidden = NO;
        } else {
            self.lblno.hidden = YES;
            self.listView.hidden = NO;
            self.listArray = [[NSMutableArray alloc] initWithArray:arr];
            [self.listView reloadData];
        }
    }
    [super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];

      
    EventCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"EventCell-%ld",(long)[indexPath row]]];

  //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"EventCell" owner:self options:nil];
        cell = arr[0];
        
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.typeview.bounds
                                                   byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path  = maskPath.CGPath;
    cell.typeview.layer.mask = maskLayer;
    cell.lbltype.text = [dt1 objectForKey:@"status"];
    if ([[dt1 objectForKey:@"status"] isEqualToString:@"진행예정"]) {
        cell.typeview.backgroundColor = [UIColor colorWithRed:(59.0f/255.0f) green:(60.0f/255.0f) blue:(76.0f/255.0f) alpha:1];
    } else if ([[dt1 objectForKey:@"status"] isEqualToString:@"진행중"]) {
        cell.typeview.backgroundColor = [UIColor colorWithRed:(235.0f/255.0f) green:(195.0f/255.0f) blue:(49.0f/255.0f) alpha:1];
    } else if ([[dt1 objectForKey:@"status"] isEqualToString:@"종료"]) {
        cell.typeview.backgroundColor = [UIColor colorWithRed:(144.0f/255.0f) green:(145.0f/255.0f) blue:(162.0f/255.0f) alpha:1];
    } else if ([[dt1 objectForKey:@"status"] isEqualToString:@"당첨자발표"]) {
        cell.typeview.backgroundColor = [UIColor colorWithRed:(144.0f/255.0f) green:(145.0f/255.0f) blue:(162.0f/255.0f) alpha:1];
    }
    cell.lbltitle.text = [dt1 objectForKey:@"title"];
    cell.lblcontent.text = [dt1 objectForKey:@"content"];
    cell.lblcontent.numberOfLines = 2;
    NSString *startat = [dt1 objectForKey:@"start_at"];
    startat = [startat substringToIndex:10];
    NSString *enddt = [dt1 objectForKey:@"end_at"];
    enddt = [enddt substringToIndex:10];
    cell.lbldate.text = [NSString stringWithFormat:@"%@~%@",startat, enddt ];
    cell.imgcont.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dt1 objectForKey:@"image_path"]]]];
    return cell;

      

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 450;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
}

@end
