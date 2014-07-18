//
//  HttpManager.m
//  POS2iPhone
//
//  Created by  STH on 1/11/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "HttpManager.h"
#import "JSONKit.h"

@implementation HttpManager

static HttpManager  *instance;

+ (HttpManager *) sharedHttpManager
{
    @synchronized(self)
    {
        if (nil == instance) {
            instance = [[HttpManager alloc] initWithHostName:HOST];
            //[instance useCache];
        }
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    
    return nil;
}

- (MKNetworkOperation *) transfer:(NSDictionary *) reqDic
                   successHandler:(TransferSuccessBlack) successBlock
                     errorHandler:(MKNKErrorBlock) errorBlock
                     actionString:(NSString *)actionString
{
    NSLog(@"request:%@", reqDic);
//    NSString *methodName = [MethodNameUtil getMethodNameWithTransferCode:actionString];
    
#ifndef DEMO
    if (![StaticTools checkNetAvailable])
        return nil;
    
    MKNetworkEngine *workEngine = [[MKNetworkEngine alloc] initWithHostName:HOST];
    
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:JSONURL];
    [url appendString:actionString];

    NSString *postType = @"POST";
    if ([actionString isEqualToString:@"version"])
    {
        postType = @"GET";
    }
    
    MKNetworkOperation *op = [workEngine operationWithPath:url params:reqDic httpMethod:postType ssl:NO];
    //CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)
    [op setStringEncoding:NSUTF8StringEncoding];
    [op setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    
    if (APPDataCenter.cookid!=nil&&![actionString isEqualToString:@"verifyCodes"])
    {
        NSLog(@"cookid:%@",APPDataCenter.cookid);
        [op addHeaders:@{@"cookie2":APPDataCenter.cookid}];
    }
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         if([completedOperation isCachedResponse]) {
             NSLog(@"Data from cache %@", [completedOperation responseString]);
         }
         else {
             NSLog(@"Data from server %@", [completedOperation responseString]);
         }
         
         if ([actionString isEqualToString:@"verifyCodes"])
         {
             NSDictionary *header =completedOperation.readonlyResponse.allHeaderFields;
             if (header[@"Set-Cookie"]!=nil)
             {
                 NSLog(@"cook is:%@",header[@"Set-Cookie"]);
                 NSString *cookid =header[@"Set-Cookie"];
                 NSArray *temarr = [cookid componentsSeparatedByString:@";"];
                 
                 NSString *cook;
                 for (NSString *tem in temarr)
                 {
                     if ([tem hasPrefix:@"uuid"])
                     {
                         cook = tem;
                     }
                 }
                 NSArray *arr = [cook componentsSeparatedByString:@","];
                 if (arr.count>1)
                 {
                     
                     NSString *uuid = arr[1];
                     uuid = [uuid substringFromIndex:6];
                     APPDataCenter.cookid = uuid;
                 }
                 
                 
                 //             NSLog(@"get cookids:%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
             }
             //         NSLog(@"dd:%@", [NSHTTPCookie requestHeaderFieldsWithCookies:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]]);
         }
       
         
         NSDictionary *respDic = [[completedOperation responseString] objectFromJSONString];
         successBlock(respDic);
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         NSLog(@"MKNetwork request error : %@", [error localizedDescription]);
         errorBlock(error);
         
     }];
    
    [workEngine enqueueOperation:op];
    
    return op;
#endif
    
    
#ifdef DEMO
    MKNetworkEngine *workEngine = [[MKNetworkEngine alloc] initWithHostName:@"www.baidu.com"];
    MKNetworkOperation *op = [workEngine operationWithPath:@"" params:reqDic httpMethod:@"POST"];
    [op setStringEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    [op setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *respDic = [[DemoClient getMessageWithTranCode:[reqDic objectForKey:@"fieldTrancode"]] objectFromJSONString];
         NSLog(@"response:%@", respDic);
         successBlock(respDic);
         
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         NSLog(@"MKNetwork request error : %@", [error localizedDescription]);
         errorBlock(error);
         
     }];
    
    [workEngine enqueueOperation:op];
    return op;
    
#endif
    
}

@end

/**********************************
 
 // 关于流量统计
 
 // 在MKNetworkOperation.m 中添加
 
 
 
 - (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
 totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
 
 // TODO STH
 #ifndef DEMO
 [[TrafficUtil sharedInstance] setTraffic:TYPE_SEND length:totalBytesExpectedToWrite];
 #endif
 
 
 for(MKNKProgressBlock uploadProgressBlock in self.uploadProgressChangedHandlers) {
 
 if(totalBytesExpectedToWrite > 0) {
 uploadProgressBlock(((double)totalBytesWritten/(double)totalBytesExpectedToWrite));
 }
 }
 }
 
 
 
 AND
 
 
 
 -(NSString*) responseStringWithEncoding:(NSStringEncoding) encoding {
 // TODO STH
 #ifndef DEMO
 [[TrafficUtil sharedInstance] setTraffic:TYPE_RECEIVE length:[[self responseData] length]];
 #endif
 
 
 return [[NSString alloc] initWithData:[self responseData] encoding:encoding];
 }
 
 
 
 *********************************/




/************************************
 
 // AFNetworking -- 中文有问题。
 
 NSURL *url = [NSURL URLWithString:@"http://192.168.0.248:8888/"];
 AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
 [httpClient setParameterEncoding:AFJSONParameterEncoding];
 [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
 [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
 
 NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
 [httpClient setStringEncoding:enc];
 
 [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", nil]];
 NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:JSONURL parameters:params];
 NSLog(@"%@", request);
 AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
 {
 NSLog(@"---%@",JSON);
 
 //NSDictionary *jsonDictionary = JSON;
 //[self.delegate performSelector:@selector(didReceiveJSONResponse:) withObject:jsonDictionary];
 
 }
 
 failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON)
 {
 NSLog(@"Failed: %@",[error localizedDescription]);
 [self.delegate performSelector:@selector(didNotReceiveJSONResponse)];
 
 }];
 
 [operation start];
 [operation waitUntilFinished];
 
 ***/

