//
//  User.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/25.
//

#ifndef User_h
#define User_h

@interface User : NSObject

@property int idx, email_idx, phone_verify, landing, status, level,  restrain, policy_agree, privacy_agree, additional_privacy_agree, email_agree, tel_agree, sms_agree, push_agree, marketting_agree, dormancy, temporary_password, over_password_date, password_regist;
@property (nonatomic, retain) NSString *ids, *email, *name, *nickname, *birth, *gender, *phone, *profile_image_url, *profile_image, *introduction, *route_code, *linked_sns, *sns_id, *sns_email, *dormancy_at, *marketting_agree_at, *connected_at, *password_at, *delete_at, *token, *reported_at, *report_clear_at, *created_at, *updated_at ;

- (User *)init:(NSDictionary *)dict;
+ (instancetype)sharedInstance;
- (void)userinit:(NSDictionary *)dict;
@end

#endif /* User_h */
