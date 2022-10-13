//
//  splashController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/07.
//

#import <Foundation/Foundation.h>
#import "splashController.h"
#import "ViewController.h"
#import "Common.h"

@interface splashController ()

@end

@implementation splashController
@synthesize img1, img2, img3, img4, img5;

- (void)viewDidLoad {
    NSDictionary *resultdict = [ApiHandler SearchCommonCode];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
       // NSLog(@"%@",[resultdict description]);
        NSArray *dataarr = [resultdict objectForKey:@"data"];
        Common *common = [Common sharedInstance];
        for (int i = 0 ; i < [dataarr count] ; i++) {
            NSDictionary *dt = [dataarr objectAtIndex:i];
            if ([[dt objectForKey:@"group_code"] isEqualToString:@"banner_category"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.bannercategory = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"content_category"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.contentcategory = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"content_class"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.contentclass = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"content_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.contenttype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"faq_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.faqtype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"grade_reject_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.graderejecttype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"keyword_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.keywortype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"level_limit"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.levellimit = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"level_code"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.levelcode = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"linked_sns"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.linkedsns = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"marketting_reject_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.markettingrejecttype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"order_code"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.ordercode = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"os_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.ostype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"point_process"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.pointprocess = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"point_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.pointtype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"point_type2"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.pointtype2 = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"policy_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.policytype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"push_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.pushtype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"reject_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.rejecttype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"report_code"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.reportcode = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"report_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.reporttype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"restriction_limit"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.restrictionlimit = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"route_code"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.routecode = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"story_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.storytype = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"term_code"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.termcode = arr;
            } else if ([[dt objectForKey:@"group_code"] isEqualToString:@"withdraw_type"]) {
                NSArray *arr = [dt objectForKey:@"codes"];
                common.withdrawtype = arr;
            }
        }
    }
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        self.img1.alpha = 1;

                     }
                     completion:^(BOOL finished){
        
    }];
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        self.img2.alpha = 1;

                     }
                     completion:^(BOOL finished){
        
    }];
    [UIView animateWithDuration:0.5f
                          delay:1.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        self.img3.alpha = 1;

                     }
                     completion:^(BOOL finished){
        
    }];
    [UIView animateWithDuration:0.5f
                          delay:1.5f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        self.img4.alpha = 1;

                     }
                     completion:^(BOOL finished){
        
    }];

    [UIView animateWithDuration:0.5f
                          delay:2.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        self.img5.alpha = 1;

                     }
                     completion:^(BOOL finished){
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
       
        ViewController *dc = [storyboard instantiateViewControllerWithIdentifier:@"tabController"];
        
        [self.navigationController setViewControllers:@[dc]];
    }];
    [super viewWillAppear:animated];
}
@end
