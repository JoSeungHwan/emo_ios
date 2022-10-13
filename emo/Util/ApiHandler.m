//
//  ApiHandler.m
//  emo
//
//  Created by choi hyoung jun on 2022/08/24.
//

#import "User.h"


#define ContentList @"api/contents?order=%@&date=%@&page=%d";

@implementation ApiHandler

+ (NSDictionary *)myemoticonlist:(int)page search:(NSString *)search {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/emoticons/made?order=popular&search_text=%@&page=%d",search,page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)searchfollow:(int)page useridx:(int)useridx type:(NSString *)type search:(NSString *)search {
    NSDictionary *resultArray;
    NSString *searchparam = @"";
    if (![search isEqualToString:@""]) {
        searchparam = [NSString stringWithFormat:@"&search_text=%@",search];
    }
    NSString *url = [NSString stringWithFormat:@"api/profile/follows/%d?type=%@&page=%d%@",useridx,type, page,searchparam];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)follow:(NSString *)idx type:(NSString *)type {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/profile/follows/%@",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([type isEqualToString:@"follow"]) {
        resultArray = [self callapi:url method:@"POST" parameter:nil];
    } else {
        resultArray = [self callapi:url method:@"DELETE" parameter:nil];
    }
    
    return resultArray;
}

+ (NSDictionary *)contentbookmark:(int)idx {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/contents/bookmark/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)storiesbookmark:(int)idx{
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/stories/bookmark/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)contentsdelete:(int)idx {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/contents/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"DELETE" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)storiesdelete:(int)idx {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/stories/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"DELETE" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)searchcommentlist:(int)idx page:(int)page {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/profile/comments/%d?page=%d",idx, page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)profilebookmark:(NSString *)type {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/profile/bookmarks/%@",type];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)homesettingsave:(NSDictionary *)param {
    NSDictionary *resultArray;
    
    NSString *params = [NSString stringWithFormat:@"{\"follow\":\"%@\",\"content_types\":\"%@\",\"categorys\":\"%@\"\}",[param objectForKey:@"follow"], [param objectForKey:@"content_types"], [param objectForKey:@"categorys"]];
    NSString *url = [NSString stringWithFormat:@"api/main/settings"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"PUT" parameter:params];
    
    return resultArray;
}

+ (NSDictionary *)homesetting {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/main/settings"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)SearchCommonCode {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/codes"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)findpwd:(NSString *)email {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/auth/password?email=%@",email];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)findid:(NSString *)phone {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/auth/id?phone=%@",phone];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)snsconnect:(NSString *)type snsid:(NSString *)snsid email:(NSString *)email {
    NSDictionary *resultArray;
    
    NSString *params = [NSString stringWithFormat:@"{\"type\":\"%@\",\"id\":\"%@\",\"email\":\"%@\"\}",type, snsid, email];
    NSString *url = [NSString stringWithFormat:@"api/profile/link/sns"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:params];
    
    return resultArray;
}

+ (NSDictionary *)snsdisconnect {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/profile/link/sns"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)addinfoupdate:(NSString *)additional gender:(NSString *)gender birth:(NSString *)birth phone:(NSString *)phone {
    NSDictionary *resultArray;
    
    NSString *birth1 = @"";
    NSString *gender1 = @"";
    NSString *phone1 = @"";
    if (![birth isEqualToString:@""]) {
        birth1 = [NSString stringWithFormat:@",\"birth\":\"%@\"",birth];
    }
    
    if (![gender isEqualToString:@""]) {
        birth1 = [NSString stringWithFormat:@",\"gender\":\"%@\"",gender];
    }
    
    if (![phone isEqualToString:@""]) {
        phone1= [NSString stringWithFormat:@",\"phone\":\"%@\"",phone];
    }
    
    NSString *params = [NSString stringWithFormat:@"{\"additional_privacy_agree\":%@%@%@%@}",additional, birth1, gender1,phone1];
    NSString *url = [NSString stringWithFormat:@"api/user/update"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:params];
    
    return resultArray;
}

+ (NSDictionary *)changepassword:(NSString *)type newpassword:(NSString *)newpassword oldpassword:(NSString *)oldpassword repassword:(NSString *)repassword {
    NSDictionary *resultArray;
    User *user = [User sharedInstance];
    if (user.password_regist == 0) {
        NSString *params = [NSString stringWithFormat:@"{\"password\":\"%@\",\"password_confirm\":\"%@\"}", newpassword, repassword];
        NSString *url = [NSString stringWithFormat:@"api/auth/password"];
       // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        resultArray = [self callapi:url method:@"POST" parameter:params];
    } else {
        NSString *params = [NSString stringWithFormat:@"{\"type\":\"%@\",\"old_password\":\"%@\",\"password\":\"%@\",\"password_confirm\":\"%@\"}", type, oldpassword, newpassword, repassword];
        NSString *url = [NSString stringWithFormat:@"api/auth/password"];
       // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        resultArray = [self callapi:url method:@"POST" parameter:params];
    }
  
    
    
    return resultArray;
}

+ (NSDictionary *)emoticonbookmark:(int)idx {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/emoticons/bookmark/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)emoticonorder:(int)idx {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/emoticons/orders/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)emoticondetail:(int)idx {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/emoticons/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)emoticonlist:(int)page order:(NSString *)order search:(NSString *)search {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/emoticons?order=%@&search_text=%@&page=%d",order, search, page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)fireuser:(NSString *)stype reason:(NSString *)reason password:(NSString *)password {
    NSDictionary *resultArray;
  
    NSString *params = [NSString stringWithFormat:@"{\"type_code\":\"%@\",\"reason\":\"%@\",\"password\":\"%@\"}", stype, reason, password];
    NSString *url = [NSString stringWithFormat:@"api/user/withdraw"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:params];
    
    return resultArray;
}

+ (NSDictionary *)suggestionsadd:(NSString *)cont {
    NSDictionary *resultArray;
  
    NSString *params = [NSString stringWithFormat:@"{\"content\":\"%@\"}", cont];
    NSString *url = [NSString stringWithFormat:@"api/more/suggestions"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:params];
    
    return resultArray;
}

+ (NSDictionary *)markettingedit:(int)email tel:(int)tel sms:(int)sms push:(int)push {
    NSDictionary *resultArray;
  
    NSString *params = [NSString stringWithFormat:@"{\"email_agree\":%d,\"tel_agree\":%d,\"sms_agree\":%d,\"push_agree\":%d}", email, tel, sms, push];
    NSString *url = [NSString stringWithFormat:@"api/user/marketting"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"PUT" parameter:params];
    
    return resultArray;
}

+ (NSDictionary *)markettingagree {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/user/marketting"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)searchuserProfile:(int)idx {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/profile/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)alramupdate:(int) replies like:(int)like upgrade:(int)upgrade sales:(int)sales event:(int)event win:(int)win {
    NSDictionary *resultArray;
  
    NSString *params = [NSString stringWithFormat:@"{\"replies\":%d,\"likefollows\":%d,\"upgrade\":%d,\"sales\":%d, \"events\":%d, \"wins\":%d}", replies, like, upgrade, sales, event, win];
    NSString *url = [NSString stringWithFormat:@"api/more/notifications"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"PUT" parameter:params];
    
    return resultArray;
}

+ (NSDictionary *)alramsearch {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/more/notifications"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)loginSocialinfo:(NSDictionary *)param {
    NSDictionary *resultArray;
    
    NSString *birth = @"";
    NSString *gender = @"";
    NSString *phone = @"";
    if (![[param objectForKey:@"birthday"] isEqualToString:@""]) {
        birth = [NSString stringWithFormat:@",\"birth\":\"%@\"",[param objectForKey:@"birthday"]];
    }
    
    if (![[param objectForKey:@"gender"] isEqualToString:@""]) {
        birth = [NSString stringWithFormat:@",\"gender\":\"%@\"",[param objectForKey:@"gender"]];
    }
    
    if (![[param objectForKey:@"phone"] isEqualToString:@""]) {
        phone= [NSString stringWithFormat:@",\"phone\":\"%@\"",[param objectForKey:@"phone"]];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *params = [NSString stringWithFormat:@"{\"type\":\"%@\",\"id\":\"%@\",\"email\":\"%@\",\"is_default_image\":true,\"nickname\":%@,\"privacy_agree\":1\"email_agree\":1,\"tel_agree\":1@,\"sms_agree\":1,\"push_agree\":1,\"additional_privacy_agree\":%@%@%@%@,\"profile_image_url\":\"%@\",\"introduction\":\"%@\"}", [defaults objectForKey:@"method"], [defaults objectForKey:@"snsid"], [param objectForKey:@"sns_emaile"], [param objectForKey:@"nickanem"],[param objectForKey:@"additional_privacy_agree"], birth, gender,phone, [param objectForKey:@"profile_image_url"], [param objectForKey:@"introduction"]];
    NSString *url = [NSString stringWithFormat:@"api/auth/loginSocialinfo"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:params];
    
    return resultArray;
}

+ (NSDictionary *)eventlist:(NSString *)sort {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/events?status=%@",sort];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)faqlist:(int)page {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/faqs?page=%d",page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)emoticonList:(int)page order:(NSString *)order search:(NSString *)search {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/emoticons?order=%@&search_text=%@&page=%d",order, search, page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)orderEmoticonsList:(int)page order:(NSString *)order search:(NSString *)search {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/emoticons/orders?search_text=%@&page=%d", search, page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)morepointsearch {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/more/remain-point"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)contentscommentlike:(int)idx {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/contents/comments/like/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)contentslike:(int)idx {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/contents/like/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:nil];
    
    return resultArray;
}

+ (NSDictionary *)storiesCommentswrite:(NSDictionary *)param {
    NSDictionary *resultArray;
    
    NSString *rep = @"";

    if (![[param objectForKey:@"story_comment_idx"] isEqual:[NSNull null]]) {
        rep = [NSString stringWithFormat:@", \"story_comment_idx\":%@",[param objectForKey:@"story_comment_idx"]];
    }
        
    NSString *params = [NSString stringWithFormat:@"{\"story_idx\":%@,\"contents\":\"%@\"%@}", [param objectForKey:@"story_idx"], [param objectForKey:@"contents"],rep];
    NSString *url = [NSString stringWithFormat:@"api/stories/comments"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:params];
    
    return resultArray;

}

+ (NSDictionary *)contentsCommentswrite:(NSDictionary *)param {

    
    NSDictionary *resultArray;
    
    NSString *rep = @"";
    if (![[param objectForKey:@"content_comment_idx"] isEqual:[NSNull null]]) {
        rep = [NSString stringWithFormat:@", \"content_comment_idx\":%@",[param objectForKey:@"content_comment_idx"]];
    }
        
    NSString *params = [NSString stringWithFormat:@"{\"content_idx\":%@,\"contents\":\"%@\"%@}", [param objectForKey:@"content_idx"], [param objectForKey:@"contents"],rep];
    NSString *url = [NSString stringWithFormat:@"api/contents/comments"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:params];
    
    return resultArray;

}

+ (NSDictionary *)phoneauthcheck:(NSString *)phone authnum:(NSString *)authnum {
    NSDictionary *resultArray;
        
    NSString *param = [NSString stringWithFormat:@"{\"phone\":\"%@\",\"token\":\"%@\"}", phone, authnum];
    NSString *url = [NSString stringWithFormat:@"api/user/phone/verify"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:param];
    
    return resultArray;
}

+ (NSDictionary *)phoneauthsend:(NSString *)phone {
    NSDictionary *resultArray;
        
    NSString *param = [NSString stringWithFormat:@"{\"phone\":\"%@\"}", phone];
    NSString *url = [NSString stringWithFormat:@"api/user/phone/verification"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:param];
    
    return resultArray;
}

+ (NSDictionary *)notidetail:(int)idx {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/notices/%d",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)notilist:(int)page {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/notices?page=%d",page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)alramlist:(int)page {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/messages?page=%d",page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)profileupdate:(NSDictionary *)param {
    NSDictionary *resultArray;
    
    NSString *profile = @"";
    
    if (![[param objectForKey:@"profile_image_url"] isEqualToString:@""]) {
        profile = [NSString stringWithFormat:@",\"profile_image_url\":\"%@\"",[param objectForKey:@"profile_image_url"]];
    }
    
    
    NSString *params = [NSString stringWithFormat:@"{\"additional_privacy_agree\":1,\"nickname\":\"%@\",\"introduction\":\"%@\"%@}", [param objectForKey:@"nickname"], [param objectForKey:@"comment"],profile];
    NSString *url = [NSString stringWithFormat:@"api/user/update"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"PUT" parameter:params];
    
    return resultArray;
}

+ (NSDictionary *)registerinfo:(NSDictionary *)param {
    NSDictionary *resultArray;
    
    NSString *birth = @"";
    NSString *gender = @"";
    NSString *phone = @"";
    if (![[param objectForKey:@"birthday"] isEqualToString:@""]) {
        birth = [NSString stringWithFormat:@",\"birth\":\"%@\"",[param objectForKey:@"birthday"]];
    }
    
    if (![[param objectForKey:@"gender"] isEqualToString:@""]) {
        birth = [NSString stringWithFormat:@",\"gender\":\"%@\"",[param objectForKey:@"gender"]];
    }
    
    if (![[param objectForKey:@"phone"] isEqualToString:@""]) {
        phone= [NSString stringWithFormat:@",\"phone\":\"%@\"",[param objectForKey:@"phone"]];
    }
    
        
    NSString *params = [NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\",\"password_confirm\":\"%@\",\"nickname\":\"%@\",\"policy_agree\":%@,\"privacy_agree\":%@,\"email_agree\":%@,\"tel_agree\":%@,\"sms_agree\":%@,\"push_agree\":%@,\"additional_privacy_agree\":%@%@%@%@,\"profile_image_url\":\"%@\",\"introduction\":\"%@\"}", [param objectForKey:@"email"], [param objectForKey:@"password"], [param objectForKey:@"password_confirm"], [param objectForKey:@"nickname"], [param objectForKey:@"policy_agree"], [param objectForKey:@"privacy_agree"], [param objectForKey:@"email_agree"], [param objectForKey:@"tel_agree"], [param objectForKey:@"sms_agree"], [param objectForKey:@"push_agree"], [param objectForKey:@"additional_privacy_agree"],birth, gender,phone, [param objectForKey:@"profile_image_url"], [param objectForKey:@"introduction"]];
    NSString *url = [NSString stringWithFormat:@"api/auth/registerinfo"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:params];
    
    return resultArray;
    
}

+ (NSDictionary *)fileupload:(NSString *)filepath {
    
   /* NSDictionary *resultArray;
        
    NSString *param = [NSString stringWithFormat:@"{\"file\":[\"%@\"]}", filepath];
    NSString *url = [NSString stringWithFormat:@"/api/user/file"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:param];
    
    return resultArray;*/
    NSString *domain = @"https://m.emomanse.com/";
    NSString *url = [NSString stringWithFormat:@"%@api/user/file",domain];
    NSLog(@"URL-%@",url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    User *user = [User sharedInstance];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request addRequestHeader:@"X-Authorization" value:@"l4r2K9PaBmXUadNqBRlNTUn6gENz8EJW09QRCGJ9HAnctb6ew4889PEXRUcuTTFK"];
    [request setFile:filepath withFileName:@"profile.jpeg" andContentType:@"image/jpeg"
    forKey:@"profile_image"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    
    [request startSynchronous];
    NSError *error = [request error];
      if (!error) {
        NSString *response = [request responseString];
      } else {
          NSLog(@"%@",[error description]);
      }
        
    NSData *returnData = [request responseData];
    NSString *stStr = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"response: %@", stStr);
    stStr = [stStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    stStr=[stStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    stStr = [stStr stringByReplacingOccurrencesOfString:@"%0D%0A" withString:@"&&"];
    stStr = [stStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@",stStr);
    
    returnData = [stStr dataUsingEncoding:NSUTF8StringEncoding];
   
    
    NSDictionary *arr;
    Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
    if (!jsonSerializationClass) {
        //iOS < 5 didn't have the JSON serialization class
        arr  = [returnData objectFromJSONData]; //JSONKit
    }
    else {
        NSError *jsonParsingError = nil;
        arr = [NSJSONSerialization JSONObjectWithData:returnData options:0   error:&jsonParsingError];
        NSLog(@"%@",jsonParsingError.localizedDescription);
    }
    
    return arr;
}

+ (NSDictionary *)nicknamecheck:(NSString *)nickname {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/auth/nickname?nickname=%@",nickname];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)refreshtoken {
    NSDictionary *resultArray;
        
    NSString *url = @"api/auth/refresh";
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)policies {
    NSDictionary *resultArray;
        
    NSString *url = @"api/auth/policies";
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)policieshistory:(NSString *)type startat:(NSString *)startat {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/auth/policies/%@?start_at=%@",type, startat];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)emailauthcheck:(NSString *)email authnum:(NSString *)authnum {
    NSDictionary *resultArray;
        
    NSString *param = [NSString stringWithFormat:@"{\"email\":\"%@\",\"token\":\"%@\"}", email, authnum];
    NSString *url = [NSString stringWithFormat:@"api/auth/email/verify"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:param];
    
    return resultArray;
    
}

+ (NSDictionary *)emailauthsend:(NSString *)email {
    NSDictionary *resultArray;
        
    NSString *param = [NSString stringWithFormat:@"{\"email\":\"%@\"}", email];
    NSString *url = [NSString stringWithFormat:@"api/auth/email/verification"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:param];
    
    return resultArray;
}

+ (NSDictionary *)socialLogin:(NSString *)type snsid:(NSString *)snsid email:(NSString *)email nickname:(NSString *)nickname imgurl:(NSString *)imgurl {
    NSDictionary *resultArray;
   
    NSString *param = [NSString stringWithFormat:@"{\"type\":\"%@\",\"id\":\"%@\",\"nickname\":\"%@\",\"profile_image_url\":\"%@\",\"email\":\"%@\",\"is_default_image\":true, \"policy_agree\":1, \"privacy_agree\":1,\"email_agree\":1,\"tel_agree\":1,\"sms_agree\":1,\"push_agree\":1}",type, snsid, nickname, imgurl, email];
    NSString *url = [NSString stringWithFormat:@"api/auth/loginSocial"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:param];
    
    return resultArray;
}

+ (NSDictionary *)socialcheck:(NSString *)type snsid:(NSString *)snsid email:(NSString *)email {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/auth/social?type=%@&id=%@&email=%@",type, snsid, email];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)searchProfileStories:(int)useridx page:(int)page {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/profile/stories/%d?page=%d",useridx, page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)searchProfileContents:(int)useridx page:(int)page {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/profile/contents/%d?page=%d",useridx, page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)userProfile:(int)useridx {
   
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/profile/%d",useridx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)login:(NSString *)email password:(NSString *)password {
    NSDictionary *resultArray;
        
    NSString *param = [NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\"}", email, password];
    NSString *url = [NSString stringWithFormat:@"api/auth/login"];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"POST" parameter:param];
    
    return resultArray;
}

+ (NSDictionary *)contentstoriesDetail:(NSString *)idx {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/stories/%@",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)contentDetail:(NSString *)idx {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/contents/%@",idx];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)tagcontentssearch:(NSString *)search {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/search/tags/contents?tag=%@",search];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)tagstoriessearch:(NSString *)search page:(int)page {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/search/tags/stories?tag=%@&page=%d",search, page];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)contentSearch:(NSString *)search {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/search/contents?search_text=%@",search];
   // url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)tagSearch:(NSString *)search page:(int)page {
    NSDictionary *resultArray;
        
    NSString *url = [NSString stringWithFormat:@"api/search/tags?page=%d&search_text=%@",page,search];
    //url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)tagslist {
    NSDictionary *resultArray;
        
   // NSData *returnData = [request responseData];
    resultArray = [self callapi:@"api/suggest/tags" method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)keyworseach {
    NSDictionary *resultArray;
        
   // NSData *returnData = [request responseData];
    resultArray = [self callapi:@"api/suggest/keywords" method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)stories {
    
    NSDictionary *resultArray;
        
   // NSData *returnData = [request responseData];
    resultArray = [self callapi:@"api/stories" method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)contentList:(NSString *)order date:(NSString *)date page:(int)page {
    
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/contents?order=%@&date=%@&page=%d",order, date, page];
         
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)usersearch:(NSString *)search page:(int)page  {
    NSDictionary *resultArray;
    
    NSString *url = [NSString stringWithFormat:@"api/search/users?page=%d&search_text=%@",page, search];
   
    resultArray = [self callapi:url method:@"GET" parameter:@""];
    
    return resultArray;
}

+ (NSDictionary *)callapi:(NSString *)url method:(NSString *)method parameter:(NSString *)parameter {
    //NSString *domain = @"http://61.97.190.64/";
    NSString *domain = @"https://m.emomanse.com/";
    url = [NSString stringWithFormat:@"%@%@",domain,url];
    NSLog(@"URL-%@",url);

    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    User *user = [User sharedInstance];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request addRequestHeader:@"X-Authorization" value:@"l4r2K9PaBmXUadNqBRlNTUn6gENz8EJW09QRCGJ9HAnctb6ew4889PEXRUcuTTFK"];
    if (![user.token isEqualToString:@""] && ![user.token isEqual:[NSNull null]] && user.token != nil) {
        [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", user.token]];
    }
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:method];
    if (![parameter isEqualToString:@""]) {
        NSMutableData *data = [[NSMutableData alloc] initWithData:[parameter dataUsingEncoding:NSUTF8StringEncoding]];
        [request setPostBody:data];
    }
    [request startSynchronous];
    NSError *error = [request error];
      if (!error) {
        NSString *response = [request responseString];
      } else {
          NSLog(@"%@",[error description]);
      }
        
    NSData *returnData = [request responseData];
    NSString *stStr = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"response: %@", stStr);
    stStr = [stStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    stStr=[stStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    stStr = [stStr stringByReplacingOccurrencesOfString:@"%0D%0A" withString:@"&&"];
    stStr = [stStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@",stStr);
    
    returnData = [stStr dataUsingEncoding:NSUTF8StringEncoding];
   
    
    NSDictionary *arr;
    Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
    if (!jsonSerializationClass) {
        //iOS < 5 didn't have the JSON serialization class
        arr  = [returnData objectFromJSONData]; //JSONKit
    }
    else {
        NSError *jsonParsingError = nil;
        arr = [NSJSONSerialization JSONObjectWithData:returnData options:0   error:&jsonParsingError];
        NSLog(@"%@",jsonParsingError.localizedDescription);
    }
    
    return arr;
    
    
}

+ (NSInteger)formattedDateCompareToNow:(NSDate *)date
{
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:date]];
    NSInteger dayDiff = (int)[midnight timeIntervalSinceNow] / (60*60*24);
    return dayDiff;
}
 
+ (NSString *)calculateDate:(NSDate *)date {
 
     NSString *interval;
     int diffSecond = (int)[date timeIntervalSinceNow];
     
     if (diffSecond < 0) { //입력날짜가 과거
     
     //날짜 차이부터 체크
  
     int valueOfToday, valueOfTheDate;
     
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
     NSString *currentLanguage = [languages objectAtIndex:0];
     
     NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
     [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:currentLanguage]];
     
     [formatter setDateFormat:@"yyyyMMdd"];
     
     NSDate *now = [NSDate date];
     valueOfToday = [[formatter stringFromDate:now] intValue]; //오늘날짜
     valueOfTheDate = [[formatter stringFromDate:date] intValue]; //입력날짜
         
     [formatter setDateFormat:@"yyyy-MM-dd"];
         
     NSCalendar *sysCalendar = [NSCalendar currentCalendar]; //정확한 날짜 계산을 위해 NSCalendar 사용

         unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay; //계산할 범위 지정

     NSDate *today = [[NSDate alloc] init]; //오늘날짜

     NSDateComponents *interval_date = [sysCalendar components:unitFlags fromDate:date toDate:today options:0];                                         //날짜 비교해서 차이값 추출

     int year = interval_date.year; //년

     int month = interval_date.month; //월

     int day = interval_date.day; //일
     
     if (year > 0) {
         interval = [NSString stringWithFormat:@"%d년전",year];
     } else if (month > 0) {
         interval = [NSString stringWithFormat:@"%d달전",month];
     } else if (day > 0) {
         interval = [NSString stringWithFormat:@"%d일전",day];
     } else { //날짜가 같은경우 시간 비교
     
         [formatter setDateFormat:@"HH"];
         
         valueOfToday = [[formatter stringFromDate:now] intValue]; //오늘시간
         valueOfTheDate = [[formatter stringFromDate:date] intValue]; //입력시간
        int valueInterval = valueOfToday - valueOfTheDate; //두 시간 차이
         
         if(valueInterval == 1)
             interval = @"1시간전";
         else if(valueInterval <= 2)
             interval = [NSString stringWithFormat:@"%i시간전", valueInterval];
         else { //시간이 같은 경우 분 비교
         
             [formatter setDateFormat:@"mm"];
             
             valueOfToday = [[formatter stringFromDate:now] intValue]; //오늘분
             valueOfTheDate = [[formatter stringFromDate:date] intValue]; //입력분
             valueInterval = valueOfToday - valueOfTheDate; //두 분 차이
             
             if(valueInterval == 1) {
                 interval = @"1분전";
             }
             else if(valueInterval <= 2) {
                 interval = [NSString stringWithFormat:@"%i분전", valueInterval];
             }
             else {
                 interval = @"지금 등록";
             }
             
             }
     
         }
         
     }
     else { //입력날짜가 미래
         NSLog(@"%s, 입력된 날짜가 미래임", __func__);
         interval = @"지금 등록";
     }
     
     
     return interval;
}

@end
