//
//  ReviewApiEngine.h
//  YouxiaReview
//
//  Created by kino on 16/8/4.
//  Copyright © 2016年 kino. All rights reserved.
//

#import "BaseApiEngine.h"

@interface ReviewApiEngine : BaseApiEngine

/**
 *  获取评测列表
 */
+ (void)fetchReviewListWithSuccessHandler:(ResponseBlock)completeBlock
							 errorHandler:(ErrorBlock)errorBlock
							   translater:(Class<DataTranslate>)translater;

@end
