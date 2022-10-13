//
//  ApiHandler.h
//  emo
//
//  Created by choi hyoung jun on 2022/08/24.
//

#ifndef ApiHandler_h
#define ApiHandler_h


@interface ApiHandler : NSObject {
    NSArray *categoryList;
}

+ (NSDictionary *)contentList:(NSString *)order date:(NSString *)date page:(int)page;
+ (NSDictionary *)stories;
+ (NSDictionary *)usersearch:(NSString *)search page:(int)page;
+ (NSDictionary *)callapi:(NSString *)url method:(NSString *)method parameter:(NSString *)parameter;
+ (NSDictionary *)keyworseach;
+ (NSDictionary *)tagslist;
+ (NSDictionary *)contentSearch:(NSString *)search;
+ (NSDictionary *)tagSearch:(NSString *)search page:(int)page;
+ (NSDictionary *)tagcontentssearch:(NSString *)search;
+ (NSDictionary *)tagstoriessearch:(NSString *)search page:(int)page;
+ (NSDictionary *)contentDetail:(NSString *)idx;
+ (NSString *)calculateDate:(NSDate *)date;
+ (NSDictionary *)contentstoriesDetail:(NSString *)idx;
+ (NSDictionary *)login:(NSString *)email password:(NSString *)password;
+ (NSDictionary *)userProfile:(int)useridx;
+ (NSDictionary *)searchProfileContents:(int)useridx page:(int)page;
+ (NSDictionary *)searchProfileStories:(int)useridx page:(int)page;
+ (NSDictionary *)socialcheck:(NSString *)type snsid:(NSString *)snsid email:(NSString *)email;
+ (NSDictionary *)socialLogin:(NSString *)type snsid:(NSString *)snsid email:(NSString *)email nickname:(NSString *)nickname imgurl:(NSString *)imgurl;
+ (NSDictionary *)emailauthsend:(NSString *)email;
+ (NSDictionary *)emailauthcheck:(NSString *)email authnum:(NSString *)authnum;
+ (NSDictionary *)policieshistory:(NSString *)type startat:(NSString *)startat;
+ (NSDictionary *)policies;
+ (NSDictionary *)refreshtoken;
+ (NSDictionary *)nicknamecheck:(NSString *)nickname;
+ (NSDictionary *)fileupload:(NSString *)filepath;
+ (NSDictionary *)registerinfo:(NSDictionary *)param;
+ (NSDictionary *)profileupdate:(NSDictionary *)param;
+ (NSDictionary *)alramlist:(int)page;
+ (NSDictionary *)notilist:(int)page;
+ (NSDictionary *)notidetail:(int)idx;
+ (NSDictionary *)phoneauthsend:(NSString *)phone;
+ (NSDictionary *)phoneauthcheck:(NSString *)phone authnum:(NSString *)authnum;
+ (NSDictionary *)contentsCommentswrite:(NSDictionary *)param;
+ (NSDictionary *)storiesCommentswrite:(NSDictionary *)param;
+ (NSDictionary *)contentslike:(int)idx;
+ (NSDictionary *)contentscommentlike:(int)idx;
+ (NSDictionary *)morepointsearch;
+ (NSDictionary *)orderEmoticonsList:(int)page order:(NSString *)order search:(NSString *)search;
+ (NSDictionary *)emoticonList:(int)page order:(NSString *)order search:(NSString *)search;
+ (NSDictionary *)faqlist:(int)page;
+ (NSDictionary *)eventlist:(NSString *)sort;
+ (NSDictionary *)loginSocialinfo:(NSDictionary *)param;
+ (NSDictionary *)alramsearch;
+ (NSDictionary *)alramupdate:(int) replies like:(int)like upgrade:(int)upgrade sales:(int)sales event:(int)event win:(int)win;
+ (NSDictionary *)searchuserProfile:(int)idx;
+ (NSDictionary *)markettingagree;
+ (NSDictionary *)markettingedit:(int)email tel:(int)tel sms:(int)sms push:(int)push;
+ (NSDictionary *)suggestionsadd:(NSString *)cont;
+ (NSDictionary *)fireuser:(NSString *)stype reason:(NSString *)reason password:(NSString *)password;
+ (NSDictionary *)emoticonlist:(int)page order:(NSString *)order search:(NSString *)search;
+ (NSDictionary *)emoticondetail:(int)idx;
+ (NSDictionary *)emoticonorder:(int)idx;
+ (NSDictionary *)emoticonbookmark:(int)idx;
+ (NSDictionary *)changepassword:(NSString *)type newpassword:(NSString *)newpassword oldpassword:(NSString *)oldpassword repassword:(NSString *)repassword;
+ (NSDictionary *)addinfoupdate:(NSString *)additional gender:(NSString *)gender birth:(NSString *)birth phone:(NSString *)phone;
+ (NSDictionary *)snsdisconnect;
+ (NSDictionary *)snsconnect:(NSString *)type snsid:(NSString *)snsid email:(NSString *)email;
+ (NSDictionary *)findid:(NSString *)phone;
+ (NSDictionary *)findpwd:(NSString *)email;
+ (NSDictionary *)SearchCommonCode;
+ (NSDictionary *)homesetting;
+ (NSDictionary *)homesettingsave:(NSDictionary *)param;
+ (NSDictionary *)profilebookmark:(NSString *)type;
+ (NSDictionary *)searchcommentlist:(int)idx page:(int)page;
+ (NSDictionary *)contentsdelete:(int)idx;
+ (NSDictionary *)storiesdelete:(int)idx;
+ (NSDictionary *)contentbookmark:(int)idx;
+ (NSDictionary *)storiesbookmark:(int)idx;
+ (NSDictionary *)follow:(NSString *)idx type:(NSString *)type;
+ (NSDictionary *)searchfollow:(int)page useridx:(int)useridx type:(NSString *)type search:(NSString *)search;
+ (NSDictionary *)myemoticonlist:(int)page search:(NSString *)search;
@end


#endif /* ApiHandler_h */
