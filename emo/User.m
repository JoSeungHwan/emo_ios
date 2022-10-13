//
//  User.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/25.
//

#import <Foundation/Foundation.h>
#import "User.h"

@implementation User

+ (instancetype)sharedInstance {
    //static, 객체 자신의 타입으로 shared 를 선언하여 해당 클래스 내에서 언제든 접근이 가능하다.
    static User *shared = nil;
    
    //dispatch_once_t 타입의 일명 onceToken 을 static으로 선언
    //이 변수를 통해 dispatch_once 블럭의 실행유무를 확인할 수 있게 된다.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[User alloc] init];
    });
    return shared;
}

- (void)userinit:(NSDictionary *)dict {
    NSLog(@"%@",[dict description]);
    if ([dict objectForKey:@"idx"] != [NSNull null]) {
        [self setIdx:[[dict objectForKey:@"idx"] intValue]];
    } else {
        [self setIdx:0];
    }
    
    if ([dict objectForKey:@"id"] != [NSNull null]) {
        [self setIds:[dict objectForKey:@"id"]];
    } else {
        [self setIds:@""];
    }
    
    if ([dict objectForKey:@"email"] != [NSNull null]) {
        [self setEmail:[dict objectForKey:@"email"]];
    } else {
        [self setEmail:@""];
    }
    
    if ([dict objectForKey:@"email_idx"] != [NSNull null]) {
        [self setEmail_idx:[[dict objectForKey:@"email_idx"] intValue]];
    } else {
        [self setEmail_idx:0];
    }
    
    if ([dict objectForKey:@"name"] != [NSNull null]) {
        [self setName:[dict objectForKey:@"name"]];
    } else {
        [self setName:@""];
    }
    
    if ([dict objectForKey:@"nickname"] != [NSNull null]) {
        [self setNickname:[dict objectForKey:@"nickname"]];
        
    } else {
        [self setNickname:@""];
    }
    
    if ([dict objectForKey:@"birth"] != [NSNull null]) {
        [self setBirth:[dict objectForKey:@"birth"]];
    } else {
        [self setBirth:@""];
    }
    
    if ([dict objectForKey:@"gender"] != [NSNull null]) {
        [self setGender:[dict objectForKey:@"gender"]];
    } else {
        [self setGender:@""];
    }
    
    if ([dict objectForKey:@"phone"] != [NSNull null]) {
        [self setPhone:[dict objectForKey:@"phone"]];
    } else {
        [self setPhone:@""];
    }
    
    if ([dict objectForKey:@"phone_verify"] != [NSNull null]) {
        [self setPhone_verify:[[dict objectForKey:@"phone_verify"] intValue]];
    } else {
        [self setPhone_verify:0];
    }
    
    if ([dict objectForKey:@"profile_image_url"] != [NSNull null]) {
        [self setProfile_image_url:[dict objectForKey:@"profile_image_url"]];
    } else {
        [self setProfile_image_url:@""];
    }
    
    if ([dict objectForKey:@"profile_image"] != [NSNull null]) {
        [self setProfile_image:[dict objectForKey:@"profile_image"]];
    } else {
        [self setProfile_image:@""];
    }
    
    if ([dict objectForKey:@"landing"] != [NSNull null]) {
        [self setLanding:[[dict objectForKey:@"landing"] intValue]];
    } else {
        [self setLanding:0];
    }
    
    if ([dict objectForKey:@"status"] != [NSNull null]) {
        [self setStatus:[[dict objectForKey:@"status"] intValue]];
    } else {
        [self setStatus:0];
    }
    
    if ([dict objectForKey:@"introduction"] != [NSNull null]) {
        [self setIntroduction:[dict objectForKey:@"introduction"]];
    } else {
        [self setIntroduction:@""];
    }
    
    if ([dict objectForKey:@"route_code"] != [NSNull null]) {
        [self setRoute_code:[dict objectForKey:@"route_code"]];
    } else {
        [self setRoute_code:@""];
    }
    
    if ([dict objectForKey:@"linked_sns"] != [NSNull null]) {
        [self setLinked_sns:[dict objectForKey:@"linked_sns"]];
    } else {
        [self setLinked_sns:@""];
    }
    
    if ([dict objectForKey:@"sns_id"] != [NSNull null]) {
        [self setSns_id:[dict objectForKey:@"sns_id"]];
    } else {
        [self setSns_id:@""];
    }
    
    if ([dict objectForKey:@"sns_email"] != [NSNull null]) {
        [self setSns_email:[dict objectForKey:@"sns_email"]];
    } else {
        [self setSns_email:@""];
    }
    
    if ([dict objectForKey:@"level"] != [NSNull null]) {
        [self setLevel:[[dict objectForKey:@"level"] intValue]];
    } else {
        [self setLevel:0];
    }
    
    if ([dict objectForKey:@"restrain"] != [NSNull null]) {
        [self setRestrain:[[dict objectForKey:@"restrain"] intValue]];
    } else {
        [self setRestrain:0];
    }
    
    if ([dict objectForKey:@"dormancy_at"] != [NSNull null]) {
        [self setDormancy_at:[dict objectForKey:@"dormancy_at"]];
    } else {
        [self setDormancy_at:@""];
    }
    
    if ([dict objectForKey:@"policy_agree"] != [NSNull null]) {
        [self setPolicy_agree:[[dict objectForKey:@"policy_agree"] intValue]];
    } else {
        [self setPolicy_agree:0];
    }
    
    if ([dict objectForKey:@"privacy_agree"] != [NSNull null]) {
        [self setPrivacy_agree:[[dict objectForKey:@"privacy_agree"] intValue]];
    } else {
        [self setPrivacy_agree:0];
    }
    
    if ([dict objectForKey:@"additional_privacy_agree"] != [NSNull null]) {
        [self setAdditional_privacy_agree:[[dict objectForKey:@"additional_privacy_agree"] intValue]];
    } else {
        [self setAdditional_privacy_agree:0];
    }
    
    if ([dict objectForKey:@"email_agree"] != [NSNull null]) {
        [self setEmail_agree:[[dict objectForKey:@"email_agree"] intValue]];
    } else {
        [self setEmail_agree:0];
    }
    
    if ([dict objectForKey:@"tel_agree"] != [NSNull null]) {
        [self setTel_agree:[[dict objectForKey:@"tel_agree"] intValue]];
    } else {
        [self setTel_agree:0];
    }
    
    if ([dict objectForKey:@"sms_agree"] != [NSNull null]) {
        [self setSms_agree:[[dict objectForKey:@"sms_agree"] intValue]];
    } else {
        [self setSms_agree:0];
    }
    
    if ([dict objectForKey:@"push_agree"] != [NSNull null]) {
        [self setPush_agree:[[dict objectForKey:@"push_agree"] intValue]];
    } else {
        [self setPush_agree:0];
    }
    
    if ([dict objectForKey:@"marketting_agree"] != [NSNull null]) {
        [self setMarketting_agree:[[dict objectForKey:@"marketting_agree"] intValue]];
    } else {
        [self setMarketting_agree:0];
    }
    
    if ([dict objectForKey:@"marketting_agree_at"] != [NSNull null]) {
        [self setMarketting_agree_at:[dict objectForKey:@"marketting_agree_at"]];
    } else {
        [self setMarketting_agree_at:@""];
    }
    
    if ([dict objectForKey:@"connected_at"] != [NSNull null]) {
        [self setConnected_at:[dict objectForKey:@"connected_at"]];
    } else {
        [self setConnected_at:@""];
    }
    
    if ([dict objectForKey:@"password_at"] != [NSNull null]) {
        [self setPassword_at:[dict objectForKey:@"password_at"]];
    } else {
        [self setPassword_at:@""];
    }
    
    if ([dict objectForKey:@"reported_at"] != [NSNull null]) {
        [self setReported_at:[dict objectForKey:@"reported_at"]];
    } else {
        [self setReported_at:@""];
    }
    
    if ([dict objectForKey:@"report_clear_at"] != [NSNull null]) {
        [self setReport_clear_at:[dict objectForKey:@"report_clear_at"]];
    } else {
        [self setReport_clear_at:@""];
    }
    
    if ([dict objectForKey:@"created_at"] != [NSNull null]) {
        [self setCreated_at:[dict objectForKey:@"created_at"]];
    } else {
        [self setCreated_at:@""];
    }
    
    if ([dict objectForKey:@"updated_at"] != [NSNull null]) {
        [self setUpdated_at:[dict objectForKey:@"updated_at"]];
    } else {
        [self setUpdated_at:@""];
    }
    
    if ([dict objectForKey:@"deleted_at"] != [NSNull null]) {
        [self setDelete_at:[dict objectForKey:@"deleted_at"]];
    } else {
        [self setDelete_at:@""];
    }
    
    if ([dict objectForKey:@"dormancy"] != [NSNull null]) {
        [self setDormancy:[[dict objectForKey:@"dormancy"] intValue]];
    } else {
        [self setDormancy:0];
    }
    
    if ([dict objectForKey:@"token"] != [NSNull null]) {
        [self setToken:[dict objectForKey:@"token"]];
    } else {
        [self setToken:@""];
    }
    
    if ([dict objectForKey:@"temporary_password"] != [NSNull null]) {
        [self setTemporary_password:[[dict objectForKey:@"temporary_password"] intValue]];
    } else {
        [self setTemporary_password:0];
    }
    
    if ([dict objectForKey:@"over_password_date"] != [NSNull null]) {
        [self setOver_password_date:[[dict objectForKey:@"over_password_date"] intValue]];
    } else {
        [self setOver_password_date:0];
    }
    
    if ([dict objectForKey:@"password_regist"] != [NSNull null]) {
        [self setPassword_regist:[[dict objectForKey:@"password_regist"] intValue]];
    } else {
        [self setPassword_regist:0];
    }
}

- (User *)init:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        NSLog(@"%@",[dict description]);
        if ([dict objectForKey:@"idx"] != [NSNull null]) {
            [self setIdx:[[dict objectForKey:@"idx"] intValue]];
        } else {
            [self setIdx:0];
        }
        
        if ([dict objectForKey:@"id"] != [NSNull null]) {
            [self setIds:[dict objectForKey:@"id"]];
        } else {
            [self setIds:@""];
        }
        
        if ([dict objectForKey:@"email"] != [NSNull null]) {
            [self setEmail:[dict objectForKey:@"email"]];
        } else {
            [self setEmail:@""];
        }
        
        if ([dict objectForKey:@"email_idx"] != [NSNull null]) {
            [self setEmail_idx:[[dict objectForKey:@"email_idx"] intValue]];
        } else {
            [self setEmail_idx:0];
        }
        
        if ([dict objectForKey:@"name"] != [NSNull null]) {
            [self setName:[dict objectForKey:@"name"]];
        } else {
            [self setName:@""];
        }
        
        if ([dict objectForKey:@"nickname"] != [NSNull null]) {
            [self setNickname:[dict objectForKey:@"nickname"]];
            
        } else {
            [self setNickname:@""];
        }
        
        if ([dict objectForKey:@"birth"] != [NSNull null]) {
            [self setBirth:[dict objectForKey:@"birth"]];
        } else {
            [self setBirth:@""];
        }
        
        if ([dict objectForKey:@"gender"] != [NSNull null]) {
            [self setGender:[dict objectForKey:@"gender"]];
        } else {
            [self setGender:@""];
        }
        
        if ([dict objectForKey:@"phone"] != [NSNull null]) {
            [self setPhone:[dict objectForKey:@"phone"]];
        } else {
            [self setPhone:@""];
        }
        
        if ([dict objectForKey:@"phone_verify"] != [NSNull null]) {
            [self setPhone_verify:[[dict objectForKey:@"phone_verify"] intValue]];
        } else {
            [self setPhone_verify:0];
        }
        
        if ([dict objectForKey:@"profile_image_url"] != [NSNull null]) {
            [self setProfile_image_url:[dict objectForKey:@"profile_image_url"]];
        } else {
            [self setProfile_image_url:@""];
        }
        
        if ([dict objectForKey:@"profile_image"] != [NSNull null]) {
            [self setProfile_image:[dict objectForKey:@"profile_image"]];
        } else {
            [self setProfile_image:@""];
        }
        
        if ([dict objectForKey:@"landing"] != [NSNull null]) {
            [self setLanding:[[dict objectForKey:@"landing"] intValue]];
        } else {
            [self setLanding:0];
        }
        
        if ([dict objectForKey:@"status"] != [NSNull null]) {
            [self setStatus:[[dict objectForKey:@"status"] intValue]];
        } else {
            [self setStatus:0];
        }
        
        if ([dict objectForKey:@"introduction"] != [NSNull null]) {
            [self setIntroduction:[dict objectForKey:@"introduction"]];
        } else {
            [self setIntroduction:@""];
        }
        
        if ([dict objectForKey:@"route_code"] != [NSNull null]) {
            [self setRoute_code:[dict objectForKey:@"route_code"]];
        } else {
            [self setRoute_code:@""];
        }
        
        if ([dict objectForKey:@"linked_sns"] != [NSNull null]) {
            [self setLinked_sns:[dict objectForKey:@"linked_sns"]];
        } else {
            [self setLinked_sns:@""];
        }
        
        if ([dict objectForKey:@"sns_id"] != [NSNull null]) {
            [self setSns_id:[dict objectForKey:@"sns_id"]];
        } else {
            [self setSns_id:@""];
        }
        
        if ([dict objectForKey:@"sns_email"] != [NSNull null]) {
            [self setSns_email:[dict objectForKey:@"sns_email"]];
        } else {
            [self setSns_email:@""];
        }
        
        if ([dict objectForKey:@"level"] != [NSNull null]) {
            [self setLevel:[[dict objectForKey:@"level"] intValue]];
        } else {
            [self setLevel:0];
        }
        
        if ([dict objectForKey:@"restrain"] != [NSNull null]) {
            [self setRestrain:[[dict objectForKey:@"restrain"] intValue]];
        } else {
            [self setRestrain:0];
        }
        
        if ([dict objectForKey:@"dormancy_at"] != [NSNull null]) {
            [self setDormancy_at:[dict objectForKey:@"dormancy_at"]];
        } else {
            [self setDormancy_at:@""];
        }
        
        if ([dict objectForKey:@"policy_agree"] != [NSNull null]) {
            [self setPolicy_agree:[[dict objectForKey:@"policy_agree"] intValue]];
        } else {
            [self setPolicy_agree:0];
        }
        
        if ([dict objectForKey:@"privacy_agree"] != [NSNull null]) {
            [self setPrivacy_agree:[[dict objectForKey:@"privacy_agree"] intValue]];
        } else {
            [self setPrivacy_agree:0];
        }
        
        if ([dict objectForKey:@"additional_privacy_agree"] != [NSNull null]) {
            [self setAdditional_privacy_agree:[[dict objectForKey:@"additional_privacy_agree"] intValue]];
        } else {
            [self setAdditional_privacy_agree:0];
        }
        
        if ([dict objectForKey:@"email_agree"] != [NSNull null]) {
            [self setEmail_agree:[[dict objectForKey:@"email_agree"] intValue]];
        } else {
            [self setEmail_agree:0];
        }
        
        if ([dict objectForKey:@"tel_agree"] != [NSNull null]) {
            [self setTel_agree:[[dict objectForKey:@"tel_agree"] intValue]];
        } else {
            [self setTel_agree:0];
        }
        
        if ([dict objectForKey:@"sms_agree"] != [NSNull null]) {
            [self setSms_agree:[[dict objectForKey:@"sms_agree"] intValue]];
        } else {
            [self setSms_agree:0];
        }
        
        if ([dict objectForKey:@"push_agree"] != [NSNull null]) {
            [self setPush_agree:[[dict objectForKey:@"push_agree"] intValue]];
        } else {
            [self setPush_agree:0];
        }
        
        if ([dict objectForKey:@"marketting_agree"] != [NSNull null]) {
            [self setMarketting_agree:[[dict objectForKey:@"marketting_agree"] intValue]];
        } else {
            [self setMarketting_agree:0];
        }
        
        if ([dict objectForKey:@"marketting_agree_at"] != [NSNull null]) {
            [self setMarketting_agree_at:[dict objectForKey:@"marketting_agree_at"]];
        } else {
            [self setMarketting_agree_at:@""];
        }
        
        if ([dict objectForKey:@"connected_at"] != [NSNull null]) {
            [self setConnected_at:[dict objectForKey:@"connected_at"]];
        } else {
            [self setConnected_at:@""];
        }
        
        if ([dict objectForKey:@"password_at"] != [NSNull null]) {
            [self setPassword_at:[dict objectForKey:@"password_at"]];
        } else {
            [self setPassword_at:@""];
        }
        
        if ([dict objectForKey:@"reported_at"] != [NSNull null]) {
            [self setReported_at:[dict objectForKey:@"reported_at"]];
        } else {
            [self setReported_at:@""];
        }
        
        if ([dict objectForKey:@"report_clear_at"] != [NSNull null]) {
            [self setReport_clear_at:[dict objectForKey:@"report_clear_at"]];
        } else {
            [self setReport_clear_at:@""];
        }
        
        if ([dict objectForKey:@"created_at"] != [NSNull null]) {
            [self setCreated_at:[dict objectForKey:@"created_at"]];
        } else {
            [self setCreated_at:@""];
        }
        
        if ([dict objectForKey:@"updated_at"] != [NSNull null]) {
            [self setUpdated_at:[dict objectForKey:@"updated_at"]];
        } else {
            [self setUpdated_at:@""];
        }
        
        if ([dict objectForKey:@"deleted_at"] != [NSNull null]) {
            [self setDelete_at:[dict objectForKey:@"deleted_at"]];
        } else {
            [self setDelete_at:@""];
        }
        
        if ([dict objectForKey:@"dormancy"] != [NSNull null]) {
            [self setDormancy:[[dict objectForKey:@"dormancy"] intValue]];
        } else {
            [self setDormancy:0];
        }
        
        if ([dict objectForKey:@"token"] != [NSNull null]) {
            [self setToken:[dict objectForKey:@"token"]];
        } else {
            [self setToken:@""];
        }
        
        if ([dict objectForKey:@"temporary_password"] != [NSNull null]) {
            [self setTemporary_password:[[dict objectForKey:@"temporary_password"] intValue]];
        } else {
            [self setTemporary_password:0];
        }
        
        if ([dict objectForKey:@"over_password_date"] != [NSNull null]) {
            [self setOver_password_date:[[dict objectForKey:@"over_password_date"] intValue]];
        } else {
            [self setOver_password_date:0];
        }
        
        if ([dict objectForKey:@"password_regist"] != [NSNull null]) {
            [self setPassword_regist:[[dict objectForKey:@"password_regist"] intValue]];
        } else {
            [self setPassword_regist:0];
        }
        
    }
    
    return self;
}



@end
