//
//  TransferLogicCore.m
//  POS2iPhone
//
//  Created by  STH on 1/11/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#define GENERALTRANSFER							@"GENERALTRANSFER"
#define UPLOADSIGNIMAGETRANSFER					@"UPLOADSIGNIMAGETRANSFER"

#import "Transfer+Action.h"
#import "EncryptionUtil.h"
#import "FileOperatorUtil.h"
#import "ParseXMLUtil.h"
#import "SystemConfig.h"
#import "TransferSuccessDBHelper.h"
#import "StringUtil.h"
#import "EncryptionUtil.h"
#import "ReversalDBHelper.h"
#import "SuccessTransferModel.h"
#import "AnnouncementModel.h"
#import "UploadSignImageDBHelper.h"
#import "DateUtil.h"
#import "PayeeAccountDBHelper.h"
#import "PayeeAccountModel.h"
#import "TimedoutUtil.h"

#import "JSONKit.h"
#import "LoginViewController.h"

#import "UserModel.h"
#import "BankModel.h"
#import "TransferDetailModel.h"

@implementation Transfer (Action)

- (void) actionDone
{
    if (self.requestSucBlock)
    {
        self.requestSucBlock(self.receDic);
    }
}

@end
