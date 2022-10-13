//
//  notidetailController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef notidetailController_h
#define notidetailController_h
#import "WebKit/WebKit.h"

@interface notidetailController : UIViewController {
    WKWebView *webView;
    UILabel *lbltitle;
}
@property (nonatomic, retain) IBOutlet WKWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *lbltitle;
@property int idx;

@end

#endif /* notidetailController_h */
