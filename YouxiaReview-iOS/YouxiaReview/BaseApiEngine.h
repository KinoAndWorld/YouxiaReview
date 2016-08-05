//
//  BaseApiEngine.h
//  HomeInns-iOS
//
//  Created by kino on 15/9/7.
//
//

#import <Foundation/Foundation.h>
#import "APIManager.h"

#import <AFHTTPSessionManager.h>

#define Default_Handle ^(id responseResult){\
        [[APIManager shareManager] handleCompleteBlock:completeBlock\
                                              errBlock:errorBlock\
                                                result:responseResult\
                                            translater:translater];\
        }



@interface BaseApiEngine : NSObject


@end
