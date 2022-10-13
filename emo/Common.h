//
//  Common.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/09.
//

#ifndef Common_h
#define Common_h

@interface Common : NSObject

@property (nonatomic, retain) NSArray *bannercategory, *contentcategory, *contentclass, *contenttype, *faqtype, *graderejecttype, *keywortype, *levelcode, *linkedsns, *levellimit, *markettingrejecttype, *ordercode, *ostype, *pointprocess, *pointtype, *pointtype2, *policytype, *pushtype, *rejecttype, *reportcode, *reporttype, *restrictionlimit, *routecode, *storytype, *termcode, *withdrawtype;
+ (instancetype)sharedInstance;

@end

#endif /* Common_h */
