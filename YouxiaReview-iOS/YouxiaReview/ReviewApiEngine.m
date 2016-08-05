//
//  ReviewApiEngine.m
//  YouxiaReview
//
//  Created by kino on 16/8/4.
//  Copyright © 2016年 kino. All rights reserved.
//

#import "ReviewApiEngine.h"

@implementation ReviewApiEngine

/**
 *  获取评测列表
 */
+ (void)fetchReviewListWithSuccessHandler:(ResponseBlock)completeBlock
							 errorHandler:(ErrorBlock)errorBlock
							   translater:(Class<DataTranslate>)translater{
	
	[[APIManager shareManager] sendRequestFromMethod:APIMethodGet
												path:API_ReviewList
											  params:nil
										  onComplete:Default_Handle
											 onError:errorBlock];
}

@end
