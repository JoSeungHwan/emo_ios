//
//  ViewController.m
//  emo
//
//  Created by choi hyoung jun on 2022/08/24.
//

#import "LandingController.h"
#import "AppDelegate.h"
#import "ApiHandler.h"
#import "ContentCell.h"
#import "StoriesContentCell.h"
#import "RepliesContent.h"

@interface LandingController ()

@end

@implementation LandingController
@synthesize listView, listArray;

- (void)viewDidLoad {
    
    
    UIImageView *titleimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 106, 27)];
    titleimg.image = [UIImage imageNamed:@"logo"];
                             
    self.navigationItem.titleView = titleimg;
    
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setFrame:CGRectMake(0, 0, 44, 44)];
    [rightbtn setTitle:@"홈으로" forState:UIControlStateNormal];
    [rightbtn setTintColor:[UIColor blackColor]];
    [rightbtn addTarget:self action:@selector(gohome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)gohome {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    NSDictionary *dict = [ApiHandler stories];
    if ([[dict objectForKey:@"message"] isEqualToString:@"Ok"]) {
        self.listArray = [[dict objectForKey:@"data"] objectForKey:@"data"];
       
        [self.listView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate  *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];
    
        NSString *simpleTableIdentifier = @"storiescell";
        
        StoriesContentCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
        NSDictionary *dt = [dt1 objectForKey:@"stories"];
      //  cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"storiescell-%ld",(long)[indexPath row]]];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"LandingContentView" owner:self options:nil];
            cell = arr[0];
            
        }
      
        
        NSLog(@"%@",[dt1 description]);
        cell.lblcontent.text = [dt1 objectForKey:@"contents"];
        cell.lbltype.text = [dt1 objectForKey:@"story_type"];
        cell.imgtype.image = [UIImage imageNamed:@"storytypebg"];
        cell.scrollView.showsHorizontalScrollIndicator = YES;
        cell.scrollView.showsVerticalScrollIndicator=NO;
        CGRect frame = cell.scrollView.frame;
        frame.size.width = [[UIScreen mainScreen] bounds].size.width;
        cell.scrollView.frame = frame;
        cell.scrollView.pagingEnabled = YES;
        cell.scrollView.bounces = false;
        cell.scrollView.showsHorizontalScrollIndicator = false;
        if ([[dt1 objectForKey:@"replies"] count] == 1) {
            NSDictionary *subdic = [[dt objectForKey:@"replies"] objectAtIndex:0];
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[subdic objectForKey:@"files"] objectAtIndex:0] objectForKey:@"path"]]]];
            int width = img.size.width;
            int height = img.size.height;
            float scale = ((cell.scrollView.frame.size.width - 50) * 1.0f)/width;
           
            NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"RepliesContent" owner:self options:nil];
            RepliesContent *contentV = (RepliesContent *)[views lastObject];
            contentV.frame = CGRectMake(20, 0, cell.scrollView.frame.size.width - 40, (height * scale-5)+120);
            frame.size.height = contentV.frame.size.height;
            contentV.lblcontent.text = [NSString stringWithFormat:@"%@ %@",[subdic objectForKey:@"nickname"],[subdic objectForKey:@"contents"]];
            contentV.lbllikecount.text = [[subdic objectForKey:@"likes_count"] stringValue];
            contentV.lblrepliescount.text =[[subdic objectForKey:@"comments_count"] stringValue];
            contentV.imgcont.image = img;
            contentV.imgcont.contentMode = UIViewContentModeScaleToFill;
            contentV.imgcont.layer.cornerRadius=10;
            contentV.imgcont.clipsToBounds = true;
            if ([[subdic objectForKey:@"profile_image_url"] isKindOfClass:[NSString class]]) {
                contentV.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[subdic objectForKey:@"profile_image_url"]]]];
                contentV.imgprofile.layer.cornerRadius = contentV.imgprofile.frame.size.height / 2;
                contentV.imgprofile.clipsToBounds = true;
            }
            [cell.scrollView addSubview:contentV];
        } else {
            for (int i = 0 ; i < [[dt1 objectForKey:@"replies"] count]; i++) {
                NSDictionary *subdic = [[dt1 objectForKey:@"replies"] objectAtIndex:i];
                NSLog(@"%@",[subdic description]);
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[subdic objectForKey:@"files"] objectAtIndex:0] objectForKey:@"path"]]]];
                int width = img.size.width;
                int height = img.size.height;
                float scale = ((cell.scrollView.frame.size.width - 50) * 1.0f)/width;
                int offset = 10;
                if (i == 0){
                    offset = 20;
                }
                
                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"RepliesContent" owner:self options:nil];
                RepliesContent *contentV = (RepliesContent *)[views lastObject];
                contentV.frame = CGRectMake((i * (cell.scrollView.frame.size.width- 50)) + offset + (i * 20), 0, cell.scrollView.frame.size.width - 50, (height * scale-5)+120);
                contentV.lblcontent.text = [NSString stringWithFormat:@"%@ %@",[subdic objectForKey:@"nickname"],[subdic objectForKey:@"contents"]];
                contentV.lbllikecount.text = [[subdic objectForKey:@"likes_count"] stringValue];
                contentV.lblrepliescount.text =[[subdic objectForKey:@"comments_count"] stringValue];
                contentV.imgcont.image = img;
                contentV.imgcont.contentMode = UIViewContentModeScaleToFill;
                contentV.imgcont.layer.cornerRadius=10;
                contentV.imgcont.clipsToBounds = true;
                if ([[subdic objectForKey:@"profile_image_url"] isKindOfClass:[NSString class]]) {
                    contentV.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[subdic objectForKey:@"profile_image_url"]]]];
                    contentV.imgprofile.layer.cornerRadius = contentV.imgprofile.frame.size.height / 2;
                    contentV.imgprofile.clipsToBounds = true;
                }
                frame.size.height = contentV.frame.size.height;
                
                [cell.scrollView addSubview:contentV];
            }
            [cell.scrollView setContentSize:CGSizeMake((cell.scrollView.frame.size.width-20) * [[dt objectForKey:@"replies"] count], cell.scrollView.frame.size.height-40)];
        }
        //
        cell.scrollView.frame = frame;
        return cell;
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dt1 = [self.listArray objectAtIndex:[indexPath row]];
    int height = 350;
    if ([[dt1 objectForKey:@"contents"] isKindOfClass:[NSDictionary class]]) {
        height = (self.listView.frame.size.width-40) * 0.815;
    }
    
    return 220 + height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   

}
@end
