//
//  PoliciesController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef PoliciesController_h
#define PoliciesController_h
#import <WebKit/WebKit.h>
#import "CZPicker/CZPicker.h"


@interface PoliciesController : UIViewController<WKUIDelegate, WKNavigationDelegate, CZPickerViewDelegate, CZPickerViewDataSource>  {
    WKWebView *webView;
    UILabel *lblsubject;
    UIPickerView *pickerView;
    UIButton *btnhistory;
}

@property (nonatomic, retain) IBOutlet WKWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *lblsubject;
@property (nonatomic, retain) IBOutlet UIButton *btnhistory;
@property (nonatomic, retain) NSString *stype;
@property (nonatomic, retain) NSMutableArray *historyarray;

@end

#endif /* PoliciesController_h */
