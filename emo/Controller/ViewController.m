
#import "ViewController.h"
#import "Custom.h"
#import "UIImage+Color.h"
#import "popupViewController.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize pc;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.childViewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
        if (idx<2) {
            obj.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabhost_%lu",(unsigned long)idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            obj.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabhost_%lu_checked",(unsigned long)idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else if(idx>2){
            obj.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabhost_%lu",(unsigned long)idx-1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            obj.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabhost_%lu_checked",(unsigned long)idx-1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else{
            obj.tabBarItem.enabled=NO;
            obj.tabBarItem.title=@"";
        }
        
    }];
    self.delegate = self;
    self.tabBar.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, 80);
    [[[self tabBar] standardAppearance] setBackgroundColor:[UIColor clearColor]];
    [self.tabBar setBackgroundColor:[UIColor clearColor]];
        [self.tabBar setTranslucent:true];
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
        UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.tabBar setBackgroundImage:transparentImage];
        [self.tabBar setShadowImage:transparentImage];
    [self.tabBar setTintColor:[UIColor clearColor]];
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom"]];
        imgv.backgroundColor = [UIColor clearColor];
    imgv.frame = self.tabBar.bounds;
    [self.tabBar addSubview:imgv];
    [self.tabBar sendSubviewToBack:imgv];
    
   // UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabBar.bounds.size.width, 1)];
  //  [self.tabBar addSubview:line];
  //  line.backgroundColor = [UIColor clearColor];
//
    CGFloat width = 80;
    CGFloat height = 142;
    UIButton *button = [[Custom alloc]initWithFrame:CGRectMake((self.tabBar.bounds.size.width-width)/2+2, self.tabBar.bounds.size.height - height, 80, height)];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:@"draw_off"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"draw_on"] forState:UIControlStateSelected];
    [self.tabBar addSubview:button];
    [self.tabBar bringSubviewToFront:button];
    [button addTarget:self action:@selector(selectImagePicker) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)selectImagePicker {

}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSLog(@"%@", item);

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController.tabBarItem.tag == 2) {
        return false;
    } else if (viewController.tabBarItem.tag == 4) {
        User *user = [User sharedInstance];
        NSLog(@"%@",user.token);
        if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
            
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
            [self.pc.btnlogin addTarget:self action:@selector(btnloginPress:) forControlEvents:UIControlEventTouchUpInside];
        //[self.navigationController pushViewController:dc animated:YES];
            return false;
        }
        
    }
  
    return true;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)popupbgclick:(id)sender {
    [self.pc hidenview];
}

- (IBAction)btnloginPress:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil];
    
    LoginController *dc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];

    [self.navigationController pushViewController:dc animated:YES];
    [self.pc hidenview];
}

@end
