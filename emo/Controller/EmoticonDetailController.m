//
//  EmoticonDetailController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#import <Foundation/Foundation.h>
#import "EmoticonDetailController.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImagePhotosPlugin/SDWebImagePhotosPlugin.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "EmoticonItemCell.h"
#import "User.h"
#import "LoginController.h"

@interface EmoticonDetailController ()

@end

@implementation EmoticonDetailController
@synthesize btnmore, btnorder, btnbookmark, lblname, lblcont, lblnickname, lbltoni, imgcont, itemlist, pc;

- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"이모티콘";
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
    [rightbtn setTitle:@"My" forState:UIControlStateNormal];
    [rightbtn setFont:[UIFont fontWithName:@"SBAggroB" size:16]];
    [rightbtn setTitleColor:[UIColor colorWithRed:(255.0f/255.0f) green:(206.0f/255.0f) blue:(0.0f/255.0f) alpha:1] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(btnmyPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
        
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    self.btnorder.layer.cornerRadius = self.btnorder.frame.size.height/2;
    self.itemlist.delegate = self;
    self.itemlist.dataSource = self;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSDictionary *resultdict = [ApiHandler emoticondetail:self.idx];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSLog(@"%@",[[resultdict objectForKey:@"data"] description]);
        NSDictionary *dt = [resultdict objectForKey:@"data"];
        self.lblname.text = [dt objectForKey:@"emoticon_name"];
        self.lblcont.text = [dt objectForKey:@"contents"];
        self.lbltoni.text = [NSString stringWithFormat:@"%@Tn", [[dt objectForKey:@"price"] stringValue]];
        self.lblnickname.text = [dt objectForKey:@"nickname"];
        self.itemArray = [[NSMutableArray alloc] initWithArray:[dt objectForKey:@"files"]];
        NSDictionary *dic = [self.itemArray objectAtIndex:0];
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        [downloader downloadImageWithURL:[NSURL URLWithString:[dic objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image && finished) {
                self.imgcont.image = image;
                // do something with image
                
            }
        }];
    }
    [super viewWillAppear:animated];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnmyPress:(id)sender{
    
}

- (IBAction)btnbookmarkPress:(id)sender {
    NSDictionary *resultdict = [ApiHandler emoticonbookmark:self.idx];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        if (self.btnbookmark.selected) {
            self.btnbookmark.selected = false;
        } else {
            self.btnbookmark.selected = true;
        }
    }
}

- (IBAction)btnorderPress:(id)sender {
    User *user = [User sharedInstance];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        NSDictionary *resultdict = [ApiHandler emoticonorder:self.idx];
        if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                   bundle:nil];
            self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
            self.pc.view.frame = self.view.frame;
            popupview = self.pc.bgview;
            self.pc.popuptype = @"emoticonordercomplate";
            [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:popupview];
            [self.pc startview];
            [NSTimer timerWithTimeInterval:3 target:self selector:@selector(popupbgclick:) userInfo:nil repeats:NO];
        } else {
            [FSToast showToast:self messge:[resultdict objectForKey:@"message"]];
        }
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
        

        self.pc = (popupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popupViewController"];
        self.pc.view.frame = self.view.frame;
        popupview = self.pc.bgview;
        self.pc.popuptype = @"login";
        [self.pc.btnback addTarget:self action:@selector(popupbgclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:popupview];
        [self.pc startview];
        [self.pc.btnlogin addTarget:self action:@selector(loginPress:) forControlEvents:UIControlEventTouchUpInside];
    }

}

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

- (IBAction)loginPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    
    LoginController *dc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];

    [self.navigationController pushViewController:dc animated:YES];
    [self.pc hidenview];
}

// collection view delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.itemArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    EmoticonItemCell *cell = (EmoticonItemCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"EmoticonItemCell" forIndexPath:indexPath];

    // configuring cell
    // cell.customLabel.text = [yourArray objectAtIndex:indexPath.row]; // comment this line if you do not want add label from storyboard

    // if you need to add label and other ui component programmatically
    NSDictionary *dt = [self.itemArray objectAtIndex:[indexPath row]];
   
    
    
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:[NSURL URLWithString:[dt objectForKey:@"path"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (image && finished) {
            cell.imgContent.image = image;
            // do something with image
            
        }
    }];
    cell.contView.layer.cornerRadius = 10;
    cell.contView.layer.borderColor = [[UIColor colorWithRed:(232.0/255.0f) green:(232.0/255.0f) blue:(232.0/255.0f) alpha:1] CGColor];
    cell.contView.layer.borderWidth = 1;
    cell.contView.layer.shadowColor = [[UIColor colorWithRed:(242.0/255.0f) green:(242.0/255.0f) blue:(242.0/255.0f) alpha:1] CGColor];
    cell.contView.layer.shadowOffset = CGSizeMake(10, 10);
    cell.contView.layer.shadowRadius = 10;
    cell.contView.layer.shadowOpacity = 0.5;
    
    return cell;
}

//Note: Above two "numberOfItemsInSection" & "cellForItemAtIndexPath" methods are required.

// this method overrides the changes you have made to inc or dec the size of cell using storyboard.
- (CGSize)collectionView:(UICollectionView *)collectionView layout:   (UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int width = (self.view.frame.size.width / 3) -30;
    return CGSizeMake(width, width);

}  // class ends


@end
