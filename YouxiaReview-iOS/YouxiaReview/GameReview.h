//
//  GameReview.h
//  YouxiaReview
//
//  Created by kino on 16/8/4.
//  Copyright © 2016年 kino. All rights reserved.
//

#import "DataTranslate.h"

@interface GameReview : KOModel

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *cover_image;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *score;

@end
