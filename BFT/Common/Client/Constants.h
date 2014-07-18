//
//  Constants.h
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "AppDelegate.h"


#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define UserDefaults [NSUserDefaults standardUserDefaults]


// HTTP
#define HOST                                @"www.payfortune.com:2399"
#define JSONURL                             @"mobile/"

#define FILEURL                             @"http://106.120.253.181:8888/pos/xmlFiles/"



//判断设备是否是iPhone5
#define iPhone5                             ([UIScreen instancesRespondToSelector:@selector (currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)

#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue ]>=7.0)

//判断设备是否是IOS7 systemVersion
#define DeviceVersion    [[[UIDevice currentDevice] systemVersion] floatValue]

//颜色设置
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kOnePageSize    20

// DataBase
#define kDataBaseName                       @"POS2iPhone.db"

#define kTransferSuccessTableName           @"TransferSuccessTable"
#define kReversalTableName                  @"ReversalTable"
#define kPayeeAccountTableName              @"PayeeAccountTable"
#define kUploadSignImageTableName           @"UploadSignImageTable"
#define kAnnouncementTableName              @"AnnouncementTable"

// NSUserDefault
#define TRACEAUDITNUM 					    @"traceAuditNum"
#define BATCHNUM							 @"batchNum"
#define PASSWORD							 @"password"
#define PHONENUM							 @"phoneNum"
#define PWDLOGIN                            @"loginpwd"
#define REMBERPWD                           @"remberpwd"
#define VERSION                             @"version"

#define ALREAD_SHOWGUIDE                    @"ALREAD_SHOWGUIDE"

#define UUIDSTRING                          @"UUIDString"

#define MERCHERNAME                         @"mercherName"

#define MERCHANT_ID                         @"merchant_id"
//服务器返回商户名称
#define MERCHANT_NAME                        @"merchant_name"
//身份证
#define PID                                 @"pid"
//身份认证 0 未认证  1 已认证
#define IS_IDENTIFY                         @"is_identify"
//完善注册信息 0 未完善  1 已完善
#define IS_COMPLETE                         @"is_complete"

//md5key
#define MD5KEY                              @"md5key"


// 程序中最新公告编号
#define SYSTEM_ANNOUNCEMENT_LASTEST_NUM		@"SystemAnnouncementLastestNum"
#define SERVER_ANNOUNCEMENT_LASTEST_NUM		@"ServerAnnouncementLastestNum"

// 流量相关值
#define TRAFFIC_MONTH                           @"traffic_month"
#define MONTH_WIFISEND                          @"month_wifi_send"
#define MONTH_WIFIRECEIVE                       @"month_wifi_receive"
#define MONTH_MOBILESEND                        @"month_mobile_send"
#define MONTH_MOBILESRECEIVE                    @"month_mobile_receive"

#define TRAFFIC_DAY                             @"traffic_day"
#define DAY_WIFISEND                            @"day_wifi_send"
#define DAY_WIFIRECEIVE                         @"day_wifi_receive"
#define DAY_MOBILESEND                          @"day_mobile_send"
#define DAY_MOBILESRECEIVE                      @"day_mobile_receive"

// 公钥相关值
#define PUBLICKEY_MOD                           @"publickey_mod"
#define PUBLICKEY_EXP                           @"publickey_exp"
#define PUBLICKEY_VERSION                       @"publickey_version"
#define PUBLICKEY_TYPE                          @"publickey_type"

//#define INIT_PUBLICKEY_MOD					@ "D9D0D2224E6E84899184BBCD389F8EE08EB09EBA123948309804113B3F829D24D6093F1AFC153D113FAB8673114F4FABFDAAC9BB1B58B9E569B255BA4C338A2465642411A5EB0D68B78BB1B4E45AFF51580C3802AE01FF4DCF976D4CC681944C478FE3490A051F2B4894C321703C4D091E5365718509B20D23D78BBAD163E405"

#define INIT_PUBLICKEY_MOD					@ "30818902818100B6FBD43211AE9B8AE9CC17529512F69CB8755C432F33E519242820091AE07F8038990F93B2CE52C5159EBCF09AF94EAF7208328D0E5FCB014FC426B3560C687598BBBF2795207F2A9B9881FE752D2D9F779BC18AD423380E1EAF662F39E960FFE298AA85B442447A56AFE5D4C2E9490F6EF666B9296ABD0055"
//9EDF7A86B07CB0203

#define INIT_PUBLICKEY_EXP					@"010001"

#define INIT_PUBLICKEY_VERSION				@"000000000000"

#define DEVICEID                               @"deviceId"

#define version_num                         101

#define IsFirstEnter                       @"ISFIRSTENTER"


