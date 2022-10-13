//
//  AlramController.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/08.
//

#import <Foundation/Foundation.h>
#import "AlramController.h"

@interface AlramController ()

@end

@implementation AlramController
@synthesize btnlike, btnwin, btninfo, btnevent, btngrand, btnbenfit, btncontent, btnemoticon, viewalram1, viewalram2;
int replie, like, grand, emoticon, event, win;

- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 44)];
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.text = @"알림설정";
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
    
    self.viewalram1.layer.cornerRadius= 10;
    self.viewalram1.layer.borderColor = [[UIColor colorWithRed:(232.0/255.0f) green:(232.0/255.0f) blue:(232.0/255.0f) alpha:1] CGColor];
    self.viewalram1.layer.borderWidth = 1;
    self.viewalram1.layer.shadowColor = [[UIColor colorWithRed:(242.0/255.0f) green:(242.0/255.0f) blue:(242.0/255.0f) alpha:1] CGColor];
    self.viewalram1.layer.shadowOffset = CGSizeMake(10, 10);
    self.viewalram1.layer.shadowRadius = 10;
    self.viewalram1.layer.shadowOpacity = 0.5;
    
    self.viewalram2.layer.cornerRadius= 10;
    self.viewalram2.layer.borderColor = [[UIColor colorWithRed:(232.0/255.0f) green:(232.0/255.0f) blue:(232.0/255.0f) alpha:1] CGColor];
    self.viewalram2.layer.borderWidth = 1;
    self.viewalram2.layer.shadowColor = [[UIColor colorWithRed:(242.0/255.0f) green:(242.0/255.0f) blue:(242.0/255.0f) alpha:1] CGColor];
    self.viewalram2.layer.shadowOffset = CGSizeMake(10, 10);
    self.viewalram2.layer.shadowRadius = 10;
    self.viewalram2.layer.shadowOpacity = 0.5;
    
    replie = 0;
    like = 0;
    grand = 0;
    emoticon = 0;
    event = 0;
    win = 0;
    
    NSDictionary *resultdict = [ApiHandler alramsearch];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *datadic = [resultdict objectForKey:@"data"];
        replie = [[datadic objectForKey:@"replies"] intValue];
        like = [[datadic objectForKey:@"likefollows"] intValue];
        grand = [[datadic objectForKey:@"upgrade"] intValue];
        emoticon = [[datadic objectForKey:@"sales"] intValue];
        event = [[datadic objectForKey:@"events"] intValue];
        win = [[datadic objectForKey:@"wins"] intValue];
        
        if (replie == 1) {
            self.btncontent.selected = true;
        } else {
            self.btncontent.selected = false;
        }
        
        if (like == 1) {
            self.btnlike.selected = true;
        } else {
            self.btnlike.selected = false;
        }
        
        if (grand == 1) {
            self.btngrand.selected = true;
        } else {
            self.btngrand.selected = false;
        }
        
        if (emoticon == 1) {
            self.btnemoticon.selected = true;
        } else {
            self.btnemoticon.selected = false;
        }
        
        if (event == 1) {
            self.btnevent.selected = true;
        } else {
            self.btnevent.selected = false;
        }
        
        if (win == 1) {
            self.btnwin.selected = true;
        } else {
            self.btnwin.selected = false;
        }
        
        if (replie ==1 && like == 1 && grand == 1 && emoticon == 1) {
            self.btninfo.selected = true;
        } else {
            self.btninfo.selected = false;
        }
        
        if (event == 1 && win == 1) {
            self.btnbenfit.selected = true;
        } else {
            self.btnbenfit.selected = false;
        }
    }
    [super viewDidLoad];
}

- (void)updatealram {
    NSDictionary *resultdict = [ApiHandler alramupdate:replie like:like upgrade:grand sales:emoticon event:event win:win];
    if ([[[resultdict objectForKey:@"code"] stringValue] isEqualToString:@"0"]) {
        NSDictionary *datadic = [resultdict objectForKey:@"data"];
        replie = [[datadic objectForKey:@"replies"] intValue];
        like = [[datadic objectForKey:@"likefollows"] intValue];
        grand = [[datadic objectForKey:@"upgrade"] intValue];
        emoticon = [[datadic objectForKey:@"sales"] intValue];
        event = [[datadic objectForKey:@"events"] intValue];
        win = [[datadic objectForKey:@"wins"] intValue];
        
        if (replie == 1) {
            self.btncontent.selected = true;
        } else {
            self.btncontent.selected = false;
        }
        
        if (like == 1) {
            self.btnlike.selected = true;
        } else {
            self.btnlike.selected = false;
        }
        
        if (grand == 1) {
            self.btngrand.selected = true;
        } else {
            self.btngrand.selected = false;
        }
        
        if (emoticon == 1) {
            self.btnemoticon.selected = true;
        } else {
            self.btnemoticon.selected = false;
        }
        
        if (event == 1) {
            self.btnevent.selected = true;
        } else {
            self.btnevent.selected = false;
        }
        
        if (win == 1) {
            self.btnwin.selected = true;
        } else {
            self.btnwin.selected = false;
        }
        
        if (replie ==1 && like == 1 && grand == 1 && emoticon == 1) {
            self.btninfo.selected = true;
        } else {
            self.btninfo.selected = false;
        }
        
        if (event == 1 && win == 1) {
            self.btnbenfit.selected = true;
        } else {
            self.btnbenfit.selected = false;
        }
    }
}

- (IBAction)btnbackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btninfoPress:(id)sender {
    self.btninfo.selected = !self.btninfo.selected;
    self.btncontent.selected = self.btnwin.selected;
    self.btnlike.selected = self.btnwin.selected;
    self.btngrand.selected = self.btnwin.selected;
    self.btnemoticon.selected = self.btnwin.selected;
    if (self.btninfo.isSelected) {
        replie = 1;
        like = 1;
        grand = 1;
        emoticon = 1;
        
    } else {
        replie = 0;
        like = 0;
        grand = 0;
        emoticon = 0;
    }
    [self updatealram];
}

- (IBAction)btncontentPress:(id)sender {
    self.btncontent.selected = !self.btncontent.selected;
    if (self.btncontent.isSelected) {
        replie = 1;
    } else {
        replie = 0;
    }
    if (replie ==1 && like == 1 && grand == 1 && emoticon == 1) {
        self.btninfo.selected = true;
    } else {
        self.btninfo.selected = false;
    }
    [self updatealram];
}

- (IBAction)btnlikePress:(id)sender {
    self.btnlike.selected = !self.btnlike.selected;
    if (self.btnlike.isSelected) {
        like = 1;
    } else {
        like = 0;
    }
    if (replie ==1 && like == 1 && grand == 1 && emoticon == 1) {
        self.btninfo.selected = true;
    } else {
        self.btninfo.selected = false;
    }
    [self updatealram];
}

- (IBAction)btngrandPress:(id)sender {
    self.btngrand.selected = !self.btngrand.selected;
    if (self.btngrand.isSelected) {
        grand = 1;
    } else {
        grand = 0;
    }
    if (replie ==1 && like == 1 && grand == 1 && emoticon == 1) {
        self.btninfo.selected = true;
    } else {
        self.btninfo.selected = false;
    }
    [self updatealram];
}

- (IBAction)btnemoticonPress:(id)sender {
    self.btnemoticon.selected = !self.btnemoticon.selected;
    if (self.btnemoticon.isSelected) {
        emoticon = 1;
    } else {
        emoticon = 0;
    }
    if (replie ==1 && like == 1 && grand == 1 && emoticon == 1) {
        self.btninfo.selected = true;
    } else {
        self.btninfo.selected = false;
    }
    [self updatealram];
}

- (IBAction)btnbenfitPress:(id)sender {
    self.btnbenfit.selected = !self.btnbenfit.selected;
    self.btnevent.selected = self.btnbenfit.selected;
    self.btnwin.selected = self.btnbenfit.selected;
    
    if (self.btnbenfit.isSelected) {
        event = 1;
        win = 1;
        
        
    } else {
        event = 0;
        win = 0;
        
    }
    [self updatealram];
}

- (IBAction)btneventPress:(id)sender {
    self.btnevent.selected = !self.btnevent.selected;
    if (self.btnevent.isSelected) {
        event = 1;
    } else {
        event = 0;
    }
    if (event ==1 && win == 1) {
        self.btnbenfit.selected = true;
    } else {
        self.btnbenfit.selected = false;
    }
    [self updatealram];

}

- (IBAction)btnwinPress:(id)sender {
    self.btnwin.selected = !self.btnwin.selected;
    if (self.btnwin.isSelected) {
        win = 1;
    } else {
        win = 0;
    }
    if (event ==1 && win == 1) {
        self.btnbenfit.selected = true;
    } else {
        self.btnbenfit.selected = false;
    }
    [self updatealram];
}
@end
