//
//  APIManager.m
//  Swipidea
//
//  Created by kino on 15/9/1.
//  Copyright (c) 2015年 cosmo. All rights reserved.
//

#import "APIManager.h"

#import <AFNetworking/AFNetworking.h>

//#define DEBUG_MODE @"DebugVersion"

@interface APIManager()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation APIManager

+ (APIManager *)shareManager{
    static APIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[APIManager alloc] init];
        instance.manager = [AFHTTPSessionManager manager];
        instance.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        instance.manager.requestSerializer.timeoutInterval = 20.0f;
    });
    return instance;
}

- (void)sendRequestFromMethod:(APIMethod)method
                         path:(NSString *)path
                       params:(NSDictionary *)params
                   onComplete:(ResponseBlock)completeBlock
                      onError:(ErrorBlock)errorBlock
           responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer{
    return [self sendRequestFromMethod:method path:path params:params
                            onComplete:completeBlock onError:errorBlock
                    responseSerializer:responseSerializer
             constructingBodyWithBlock:nil progress:nil];
}


- (void)sendRequestFromMethod:(APIMethod)method
                         path:(NSString *)path
                       params:(NSDictionary *)params
                   onComplete:(ResponseBlock)completeBlock
                      onError:(ErrorBlock)errorBlock
           responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress{
    if (responseSerializer) {
        self.manager.responseSerializer = responseSerializer;
    }else{
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    [NSHTTPCookieStorage sharedHTTPCookieStorage].cookieAcceptPolicy = NSHTTPCookieAcceptPolicyNever;
    
#ifdef DEBUG_MODE
    NSString *route = [NSString stringWithFormat:@"%@/%@",TEST_BASE_API_URL, path];
#else
    NSString *route = [NSString stringWithFormat:@"%@/%@",BASE_API_URL, path];
#endif
    if (method == APIMethodGet) {
        [self.manager GET:route parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completeBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"network error:%@",task.response);
            errorBlock(error);
        }];
    }else if (method == APIMethodPost){
        [self.manager POST:route parameters:params constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completeBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"network error:%@",task.response);
            errorBlock(error);
        }];
        
    }else if(method == APIMethodPut){
        [self.manager PUT:route parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completeBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"network error:%@",task.response);
            errorBlock(error);
        }];
    }else{
        [self.manager DELETE:route parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completeBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"network error:%@",task.response);
            errorBlock(error);
        }];
    }
}


- (void)sendRequestFromMethod:(APIMethod)method
                         path:(NSString *)path
                       params:(NSDictionary *)params
                   onComplete:(ResponseBlock)completeBlock
                      onError:(ErrorBlock)errorBlock{
    
    [self sendRequestFromMethod:method path:path params:params onComplete:completeBlock onError:errorBlock responseSerializer:nil];
}


- (void)handleCompleteBlock:(ResponseBlock)completeBlock
                   errBlock:(ErrorBlock)errorBlock
                     result:(id)responseResult
                 translater:(Class<DataTranslate>)translater{
    
    id apiResponseDic = responseResult;
    
    if ([apiResponseDic isKindOfClass:[NSArray class]] && [apiResponseDic count] != 0) {
        completeBlock([translater translateFromData:apiResponseDic]);
        return ;
    }
    
    if (![apiResponseDic isKindOfClass:[NSDictionary class]]){
        completeBlock(responseResult);
        return ;
    }
    
    /* DEBUG */
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:apiResponseDic
                                                       options:kNilOptions
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonString);
    /* DEBUG */
    
    if (!apiResponseDic[@"code"] || [apiResponseDic[@"code"] intValue] == 0) {
        id dataArray = apiResponseDic[@"data"];
        
        if (!dataArray) {
            if (translater) {
                completeBlock? completeBlock([translater translateFromData:apiResponseDic]): nil;
            }else{
                completeBlock? completeBlock(apiResponseDic) : nil;
            }
        }else{
            if (translater) {
                completeBlock? completeBlock([translater translateFromData:dataArray]) : nil;
            }else{
                completeBlock? completeBlock(dataArray) : nil;
            }
        }
        
    }else{
        NSString *errMsg = @"";
        if ([apiResponseDic objectForKey:@"result_message"] &&
            [apiResponseDic[@"result_message"] isKindOfClass:[NSString class]]) {
            errMsg = apiResponseDic[@"result_message"];
        }
        NSError *requestFailErr = [NSError errorWithDomain:errMsg
                                                      code:-1
                                                  userInfo:apiResponseDic];
        errorBlock? errorBlock(requestFailErr) : nil;
    }
}

- (void)handleErrorBlock:(ErrorBlock)block withError:(NSError *)error{
    block? block(error) : nil;
}

- (void)clearAllCookies{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
}


@end

