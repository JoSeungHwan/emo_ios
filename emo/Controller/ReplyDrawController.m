//
//  ReplyDrawController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/11.
//

#import <Foundation/Foundation.h>
#import "ReplyDrawController.h"
#import "ACEDrawingView.h"
#import <AVFoundation/AVUtilities.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "UIImage+FloodFill.h"
#import "FloodFill.h"


#define kActionSheetColor       100
#define kActionSheetTool        101

@interface ReplyDrawController () <ACEDrawingViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ReplyDrawController
@synthesize btnredo, btnsave, btntext, btnundo, btncolor, btnfinger, btnpencil, btndrawopen, btnimageadd, lblnickname, lblcont, lbldate, lbltype, imgprofile, drawview, idx, drawingView;

- (void)viewDidLoad {
    self.stooltype = @"pen";
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    
    lbltitle.text = @"그리기";
    
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
    [rightbtn setTitle:@"다음" forState:UIControlStateNormal];
    [rightbtn setFont:[UIFont fontWithName:@"SBAggroB" size:16]];
    [rightbtn setTitleColor:[UIColor colorWithRed:(255.0f/255.0f) green:(206.0f/255.0f) blue:(0.0f/255.0f) alpha:1] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(btnsavePress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightbarbtn;
    
        
    UINavigationBarAppearance *appear = [[UINavigationBarAppearance alloc] init];
    [appear configureWithDefaultBackground];
    [appear setBackgroundImage:[UIImage imageNamed:@"navib"]];
    [[[self navigationController] navigationBar] setStandardAppearance:appear];
    [[[self navigationController] navigationBar] setScrollEdgeAppearance:appear];
    
    self.drawingView.delegate = self;
    
    self.drawingView.draggableTextFontName = @"MarkerFelt-Thin";
    
    NSDictionary *dict1 = [ApiHandler contentstoriesDetail:self.idx];
    //NSLog(@"%@",[dict1 description]);
    if ([[[dict1 objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *dt1 = [dict1 objectForKey:@"data"];
        NSLog(@"%@",[dt1 description]);
        self.lbltype.text = @"#댓툰";
        self.lblnickname.text = [dt1 objectForKey:@"nickname"];
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateformat setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ko_KR"]];
        
        NSString *sdt = [dt1 objectForKey:@"created_at"];
        NSDate *createdt = [dateformat dateFromString:sdt];
        
        self.lbldate.text = [ApiHandler calculateDate:createdt];
        self.lblcont.text = [dt1 objectForKey:@"contents"];
        self.lblcont.numberOfLines = 0;
        self.lblcont.lineBreakMode = NSLineBreakByWordWrapping;
        [self.lblcont sizeToFit];
        self.imgprofile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dt1 objectForKey:@"profile_image_url"]]]];
        self.imgprofile.layer.cornerRadius = self.imgprofile.frame.size.height / 2;
        self.imgprofile.clipsToBounds = true;
    } else {
        [FSToast showToast:self messge:[dict1 objectForKey:@"message"]];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"tempimgList"] isKindOfClass:[NSArray class]]) {
        NSArray *array = [defaults objectForKey:@"tempimgList"];
        [self.btndrawopen setTitle:[NSString stringWithFormat:@"이어그리기 %lu건",[array count]] forState:UIControlStateNormal];
    }
    [super viewDidLoad];
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnnextPress:(id)sender {
    
}

- (IBAction)btnredoPress:(id)sender {
    if ([self.drawingView canRedo]) {
        [self.drawingView redoLatestStep];
    }
}

- (IBAction)btnundoPress:(id)sender {
    if ([self.drawingView canUndo]) {
        [self.drawingView undoLatestStep];
    }
}

- (IBAction)btndrawopenPress:(id)sender {
    
}

- (IBAction)btnsavePress:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([self.stooltype isEqualToString:@"color"]) {
        UIImage *snapShotImage = [self takeSnapshotOfDrawing:self.saveimgview];
        NSData *data=UIImagePNGRepresentation(snapShotImage);
        
        [self.drawingView loadImage:snapShotImage];
        if ([[defaults objectForKey:@"tempimgList"] isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"tempimgList"]];
            if ([arr count] == 20) {
                [arr removeObjectAtIndex:0];
                
            }
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSArray *arr1 = [[NSArray alloc] initWithObjects:data, nil];
            [dict setValue:arr1 forKey:@"img"];
            [arr addObject:dict];
            [defaults setValue:arr forKey:@"tempimgList"];
            [defaults synchronize];
        } else {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSArray *arr1 = [[NSArray alloc] initWithObjects:data, nil];
            [dict setValue:arr1 forKey:@"img"];
            [arr addObject:dict];
            [defaults setObject:arr forKey:@"tempimgList"];
            [defaults synchronize];
        }
    } else {
        UIImage *img = self.drawingView.image;
        NSData *data=UIImagePNGRepresentation(img);
        if ([[defaults objectForKey:@"tempimgList"] isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"tempimgList"]];
            if ([arr count] == 20) {
                [arr removeObjectAtIndex:0];
                
            }
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSArray *arr1 = [[NSArray alloc] initWithObjects:data, nil];
            [dict setValue:arr1 forKey:@"img"];
            [arr addObject:dict];
            [defaults setValue:arr forKey:@"tempimgList"];
            [defaults synchronize];
        } else {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSArray *arr1 = [[NSArray alloc] initWithObjects:data, nil];
            [dict setValue:arr1 forKey:@"img"];
            [arr addObject:dict];
            
            [defaults setObject:arr forKey:@"tempimgList"];
            [defaults synchronize];
        }
    }
}

- (IBAction)btnimageaddPress:(id)sender {
    self.stooltype = @"pen";
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    if (self.priviewimg.isHidden == NO) {
        self.priviewimg.hidden = YES;
        
    }
    self.drawingView.backgroundColor = [UIColor clearColor];
    [self.drawingView clear];
   
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.baseImageView setImage:image];
   // [self.drawingView setFrame:AVMakeRectWithAspectRatioInsideRect(image.size, self.baseImageView.frame)];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)btnpencilPress:(id)sender {
    if ([self.stooltype isEqualToString:@"color"]) {
        self.stooltype = @"pen";
        UIImage *snapShotImage = [self takeSnapshotOfDrawing:self.saveimgview];
       
        
        [self.drawingView loadImage:snapShotImage];
        
        
        self.saveimgview.hidden = YES;
        self.drawview.hidden = NO;
    }
}

- (IBAction)btntextPress:(id)sender {
    self.stooltype = @"pen";
    self.drawingView.drawTool = ACEDrawingToolTypeDraggableText;
}

- (IBAction)btncolorPress:(id)sender {
    self.stooltype = @"color";
    
    UIImage *baseImage = [self.baseImageView image];
    
    self.saveimgview.image =  baseImage ? [self.drawingView applyDrawToImage:baseImage] : self.drawingView.image;
    self.saveimgview.hidden = NO;
    
    // close it after 3 seconds
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.saveimgview.hidden = YES;
    })l*/
  //  self.drawingView.hidden = YES;
    self.saveimgview.newcolor = [UIColor redColor];
    self.saveimgview.userInteractionEnabled = true;
    self.saveimgview.tolorance = 100;
}

- (IBAction)btnfindgerPress:(id)sender {
    self.stooltype = @"finger";
}

- (void)saveDrawingSnapshot
{
    //UIImageView *previewImageView = [[UIImageView alloc] initWithFrame:self.drawview.frame];
    UIImage *snapShotImage = [self takeSnapshotOfDrawing:self.saveimgview];
    //NSData *data=UIImagePNGRepresentation(snapShotImage);
    
   /* NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString * timestamp = [NSString stringWithFormat:@"%@.png",[NSDate date]];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:timestamp];
    [data writeToFile:filePath atomically:YES];*/
}

- (UIImage *)takeSnapshotOfDrawing:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(CGSizeMake(self.drawingView.frame.size.width, self.drawingView.frame.size.height));
    [imageView drawViewHierarchyInRect:CGRectMake(0, 0, self.drawingView.frame.size.width, self.drawingView.frame.size.height) afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - ACEDrawing View Delegate

- (void)drawingView:(ACEDrawingView *)view didEndDrawUsingTool:(id<ACEDrawingTool>)tool;
{
    NSLog(@"check2");
}

- (void)drawingView:(ACEDrawingView *)view willBeginDrawUsingTool:(id<ACEDrawingTool>)tool {
    NSLog(@"check1");
    if (self.priviewimg.isHidden == NO) {
        self.priviewimg.hidden = YES;
        self.drawingView.backgroundColor = [UIColor whiteColor];
    }
    if ([self.stooltype isEqualToString:@"color"]) {
        self.drawingView.userInteractionEnabled =false;
        [self saveDrawingSnapshot];
        self.saveimgview.hidden = NO;
        self.drawingView.hidden = YES;
    }
}

- (void)drawingView:(ACEDrawingView *)view configureTextToolLabelView:(ACEDrawingLabelView *)label;
{
    // If you don't like the default text control styles, you can tweak them
    // in this delegate method.
   /* label.shadowOffset = CGSizeMake(0, 1);
    label.shadowOpacity = 0.5;
    label.shadowRadius = 1;
    label.closeButtonOffset = CGPointMake(-6, -6);
    label.rotateButtonOffset = CGPointMake(6, 6);*/
}



#pragma mark - Settings

- (IBAction)colorChange:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Selet a color"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Black", @"Red", @"Green", @"Blue", nil];
    
    [actionSheet setTag:kActionSheetColor];
    [actionSheet showInView:self.view];
}

- (IBAction)toolChange:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Selet a tool"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Pen", @"Line", @"Arrow",
                                  @"Rect (Stroke)", @"Rect (Fill)",
                                  @"Ellipse (Stroke)", @"Ellipse (Fill)",
                                  @"Eraser", @"Draggable Text",
                                  @"Tringle (Stroke)",
                                  @"Tringle (Fill)",
                                  @"Pentagon (Stroke)",
                                  @"Pentagon (Fill)",
                                  @"Hexagone (Stroke)",
                                  @"Hexagone (Fill)",
                                  nil];
    
    [actionSheet setTag:kActionSheetTool];
    [actionSheet showInView:self.view];
}
@end
